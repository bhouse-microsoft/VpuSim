#include "VpuShaderBinary.h"

#include <Windows.h>

#ifdef _M_IX86
#define TLS_SYMBOL "_g_tls"
#define MAIN_SYMBOL "_main"
#else
#define TLS_SYMBOL "g_tls"
#define MAIN_SYMBOL "main"
#endif

using namespace llvm;
using namespace object;

bool VpuShaderBinary::FindExport(const char * name, uint32_t & value)
{

#if 1
//#ifdef _M_IX86
    for(uint32_t i = 0; i < m_coff->getNumberOfSymbols(); i++)
    {
        Expected<COFFSymbolRef> symbolOrErr = m_coff->getSymbol(i);

        if (!symbolOrErr)
            return false;

        auto symbol = *symbolOrErr;

        StringRef testName;
        if (m_coff->getSymbolName(symbol, testName))
            return false;

        if (testName == name) {
            value = symbol.getValue();
            return true;
        }

        i += symbol.getNumberOfAuxSymbols();
	}
#else
	for (const SymbolRef &Symbol : m_obj->symbols()) {
		Expected<SymbolRef::Type> TypeOrError = Symbol.getType();
		if (!TypeOrError)
			return false;
		SymbolRef::Type Type = *TypeOrError;
		if (Type == SymbolRef::ST_Debug)
			continue;
		Expected<StringRef> NameOrErr = Symbol.getName();
		if (!NameOrErr)
			return false;
		StringRef testName;
		testName = *NameOrErr;
		if (testName == name) {
			Expected<uint64_t> AddressOrError = Symbol.getAddress();
			if (!AddressOrError)
				return false;
			uint64_t Address = *AddressOrError;
			value = (uint32_t)Address;
			return true;
		}
	}
#endif

    return false;
}

bool VpuShaderBinary::LoadCode(uint8_t * base, uint32_t size)
{
    StringRef contents;

    if (m_code.getContents(contents))
        return false;

    if (contents.size() > m_codeSize)
        return false;

    memset(base, 0, m_codeSize);
    memcpy(base, contents.data(), contents.size());

	for (auto r : m_relocations)
		if (!ApplyRelocation(base, r))
			return false;

	return true;
}

bool VpuShaderBinary::Load(uint8_t * base, uint32_t size)
{
	return LoadCode(base, size);
}

bool VpuShaderBinary::ApplyRelocation(uint8_t * base, VpuRelocation & relocation)
{
	uint32_t * loc = (uint32_t *)(base + relocation.m_fixupOffset);

	if (relocation.m_type == IMAGE_REL_I386_REL32 || relocation.m_type == IMAGE_REL_AMD64_REL32)
		*loc = relocation.m_referenceOffset - relocation.m_fixupOffset - 4;
#ifdef _M_IX86
    else if (relocation.m_type == IMAGE_REL_I386_DIR32)
		*loc = relocation.m_referenceOffset + (uint32_t)base;
#endif
	else
		return false;
	return true;
}

bool VpuShaderBinary::BuildRelocations(void)
{
	StringRef tlsName = StringRef(TLS_SYMBOL);

	//#ifdef _M_IX86
#if 1
	for (auto relocation : m_code.relocations()) {
#else
	for (auto relocation : m_reloc.relocations()) {
#endif

		uint32_t relocationOffset = (uint32_t)relocation.getOffset();

		uint32_t relocationType = relocation.getType();

		auto symbol = relocation.getSymbol();

		Expected<SymbolRef::Type> typeOrErr = symbol->getType();
		if (!typeOrErr) return false;
		SymbolRef::Type type = *typeOrErr;

		Expected<StringRef> nameOrErr = symbol->getName();

		if (!nameOrErr) return false;

		StringRef name = *nameOrErr;

#if 0
		auto sectionOrErr = symbol->getSection();
		if (!sectionOrErr) return false;

		auto section = *sectionOrErr;
#endif

		uint32_t symbolOffset = symbol->getValue();

		if (type == SymbolRef::Type::ST_Unknown) {
			if (name.contains(".")) {
				std::string newName(name);
				std::replace(newName.begin(), newName.end(), '.', '_');
				if (!FindExport(newName.c_str(), symbolOffset))
					return false;
			}
			else
				return false;
		}
		else if (type == SymbolRef::Type::ST_Data) {
			if (name == tlsName)
				symbolOffset = m_tlsOffset;
			else
				return false;
		}
		else if (type == SymbolRef::Type::ST_Function) {
			; // do nothing
		}
		else
			return false;


		//#ifdef _M_IX86
#if 1
		if (relocationType != IMAGE_REL_I386_REL32 &&
			relocationType != IMAGE_REL_AMD64_REL32 &&
			relocationType != IMAGE_REL_I386_DIR32)
			return false;

		VpuRelocation relocation;
		relocation.m_type = relocationType;
		relocation.m_fixupOffset = relocationOffset;
		relocation.m_referenceOffset = symbolOffset;

		m_relocations.push_back(relocation);
#else
		if (relocationType == ELF::R_X86_64_PLT32) {
			uint32_t * loc = (uint32_t *)(base + relocationOffset);
			*loc = symbolOffset - relocationOffset - 4;
		}
		else if (relocationType == ELF::R_X86_64_64) {
			uint64_t * loc = (uint64_t *)(base + relocationOffset);
			*loc = symbolOffset + (uint64_t)base;
		}
		else if (relocationType == ELF::R_X86_64_32S) {
			uint32_t * loc = (uint64_t *)(base + relocationOffset);
			*loc = symbolOffset + (uint64_t)base;
		}
#endif
	}

	return true;
}

bool VpuShaderBinary::Open(const char * path)
{
    StringRef file(path);

    Expected<OwningBinary<Binary>> binaryOrErr = createBinary(file);

    if (!binaryOrErr)
        return false;

    m_binary = std::move(*binaryOrErr);

    Binary * binary = m_binary.getBinary();
    m_obj = dyn_cast<ObjectFile>(binary);

    if (m_obj == nullptr)
        return false;

//#ifdef _M_IX86
#if 1
	m_coff = dyn_cast<const COFFObjectFile>(m_obj);

    if (m_coff == nullptr)
        return false;
#endif

    if (!FindExport(TLS_SYMBOL, m_tlsSize))
        return false;

    if (!FindExport(MAIN_SYMBOL, m_mainOffset))
        return false;

    for (const SectionRef &section : m_obj->sections())
    {
        StringRef name;
        if (section.getName(name))
            return false;

        if (name == ".text") {
            m_code = section;
            m_codeSize = AlignSectionSize(section.getSize());
        }

#if 0
// #ifndef _M_IX86
		if (name == ".rela.text") {
			m_reloc = section;
		}
#endif

    }

    if (m_code == SectionRef())
        return false;

#if 0
//#ifndef _M_IX86
	if (m_reloc == SectionRef())
		return false;
#endif

	m_tlsOffset = m_codeSize;
    m_dataSize = AlignSectionSize(m_tlsSize);

    m_imageSize = m_codeSize + m_dataSize;

	if (!BuildRelocations())
		return false;

    m_loaded = true;
    return true;
}

