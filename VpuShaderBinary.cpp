#include "VpuShaderBinary.h"

#include <Windows.h>


using namespace llvm;
using namespace object;

bool VpuShaderBinary::FindExport(StringRef & name, uint32_t & value)
{
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

#if 0
    auto i = m_coff->export_directory_begin();
    auto end = m_coff->export_directory_end();

    while (i != end) {
        StringRef testName;

        if (i->getSymbolName(testName))
            continue;

        if (testName == name) {
            if (i->getExportRVA(value))
                return false;

            return true;
        }

        ++i;
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

    StringRef tlsName = StringRef("_g_tls");

    for (auto relocation : m_code.relocations()) {

        uint32_t relocationOffset = (uint32_t) relocation.getOffset();

        uint32_t relocationType = relocation.getType();

        auto symbol = relocation.getSymbol();

        Expected<StringRef> nameOrErr = symbol->getName();

        if (!nameOrErr) return false;

        StringRef name = *nameOrErr;

        uint32_t symbolOffset = symbol->getValue();

        if (name == tlsName)
            symbolOffset = m_tlsOffset;

//        if (type != IMAGE_REL_BASED_HIGHLOW)

        uint32_t * loc = (uint32_t *)(base + relocationOffset);

        uint32_t reference = *loc;

        if (relocationType == IMAGE_REL_I386_REL32)
            *loc = symbolOffset - relocationOffset - 4;
        else if (relocationType == IMAGE_REL_I386_DIR32)
            *loc = symbolOffset + (uint32_t) base;
        else
            return false;
    }

#if 0
    if (section == m_code) {
        DWORD oldProtection;
        if (!VirtualProtect(base + sectionOffset, sectionSize, PAGE_EXECUTE_READ, & oldProtection ))
            return false;
    }
#endif

    return true;
}

bool VpuShaderBinary::Load(uint8_t * base, uint32_t size)
{
    return LoadCode(base, size);
}

bool VpuShaderBinary::Open(void)
{
    StringRef file("C:/git/github.com/bhouse-microsoft/VpuSim/VpuShader.obj");

    Expected<OwningBinary<Binary>> binaryOrErr = createBinary(file);

    if (!binaryOrErr)
        return false;

    m_binary = std::move(*binaryOrErr);

    Binary * binary = m_binary.getBinary();
    m_obj = dyn_cast<ObjectFile>(binary);

    if (m_obj == nullptr)
        return false;

    m_coff = dyn_cast<const COFFObjectFile>(m_obj);

    if (m_coff == nullptr)
        return false;

    if (!FindExport(StringRef("_g_tls"), m_tlsSize))
        return false;

    if (!FindExport(StringRef("_main"), m_mainOffset))
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
        else if (name == ".data") {
            m_data = section;
        }
    }

    if (m_code == SectionRef() || m_data == SectionRef())
        return false;

    m_tlsOffset = m_codeSize;
    m_dataSize = AlignSectionSize(m_tlsSize);

    m_imageSize = m_codeSize + m_dataSize;

    m_loaded = true;
    return true;
}
