#pragma once

#include <stdint.h>

#include "llvm/Support/Error.h"
#include "llvm/Object/Binary.h"
#include "llvm/Object/ObjectFile.h"
#include "llvm/Object/COFF.h"

class VpuShaderBinary {
public:

    VpuShaderBinary() :  m_loaded(false), m_tlsOffset(0) {}
    ~VpuShaderBinary() {}

    bool Open();

    bool Load(uint8_t * base, uint32_t size);

    uint32_t GetTlsOffset() { return m_tlsOffset;  }
    uint32_t GetMainOffset() { return m_mainOffset; }

    uint32_t GetImageSize() { return (uint32_t)m_pe32Header->SizeOfImage; }
    uint32_t GetImageAlignment() { return (uint32_t)m_pe32Header->SectionAlignment; }

private:

    bool m_loaded;

    uint32_t m_tlsOffset;
    uint32_t m_mainOffset;

    llvm::object::OwningBinary<llvm::object::Binary> m_binary;
    llvm::object::ObjectFile * m_obj;
    const llvm::object::COFFObjectFile * m_coff;
    const llvm::object::pe32_header *m_pe32Header;
    llvm::object::SectionRef m_code;
    llvm::object::SectionRef m_data;

    bool FindExport(llvm::StringRef & name, uint32_t & value);

    bool LoadSection(llvm::object::SectionRef section, uint8_t * base, uint32_t size);

};
