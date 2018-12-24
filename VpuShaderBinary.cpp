#include "VpuShaderBinary.h"

#include <Windows.h>


using namespace llvm;
using namespace object;

bool VpuShaderBinary::FindExport(StringRef & name, uint32_t & value)
{
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

    return false;
}

bool VpuShaderBinary::LoadSection(llvm::object::SectionRef section, uint8_t * base, uint32_t size)
{
    if ((m_pe32Header->SectionAlignment - 1) & (uint32_t)base)
        return false;

    uint32_t imageBase = (uint32_t)m_coff->getImageBase();
    uint32_t imageSize = m_pe32Header->SizeOfImage;
    uint32_t sectionBase = (uint32_t)section.getAddress();
    uint32_t sectionSize = (uint32_t)section.getSize();

    if (sectionBase < imageBase)
        return false;

    uint32_t sectionOffset = sectionBase - imageBase;

    if (imageSize > size)
        return false;

    if (sectionOffset + sectionSize > size)
        return false;

    StringRef contents;
    if (section.getContents(contents))
        return false;

    if (contents.size() > sectionSize)
        return false;

    memset(base + sectionOffset, 0, sectionSize);
    memcpy(base + sectionOffset, contents.data(), contents.size());

    uint32_t relocationDelta = (uint32_t)base - (uint32_t)imageBase;

    for (auto relocation : m_coff->base_relocs()) {
        uint32_t relocationOffset;

        if (relocation.getRVA(relocationOffset))
            return false;

        uint8_t type;
        if (relocation.getType(type))
            return false;

        if (type != IMAGE_REL_BASED_HIGHLOW)
            return false;

        if (relocationOffset < sectionOffset ||
            relocationOffset >= sectionOffset + sectionSize)
            continue;

        uint32_t * loc = (uint32_t *)(base + relocationOffset);

        uint32_t reference = *loc;

        if (reference < imageBase || reference >= (imageBase + imageSize))
            return false;

        reference += relocationDelta;

        *loc = reference;
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
    return LoadSection(m_data, base, size) && LoadSection(m_code, base, size);
}

bool VpuShaderBinary::Open(void)
{
    StringRef file("C:/git/github.com/bhouse-microsoft/VpuSim/VpuShader.exe");

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

    if (m_coff->getPE32Header(m_pe32Header))
        return false;

    for (const SectionRef &section : m_obj->sections())
    {
        StringRef name;
        if (section.getName(name))
            return false;

        if (name == ".text")
            m_code = section;
        else if (name == ".data")
            m_data = section;

    }

    if (m_code == SectionRef() || m_data == SectionRef())
        return false;

    if (!FindExport(StringRef("g_tls"), m_tlsOffset))
        return false;

    if (!FindExport(StringRef("main"), m_mainOffset))
        return false;

    m_loaded = true;
    return true;
}
