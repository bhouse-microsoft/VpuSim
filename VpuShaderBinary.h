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

    uint32_t GetImageSize() { return m_codeSize + m_dataSize; }
    uint32_t GetImageAlignment() { return kSectionAlignment; }

private:

    static const uint32_t kSectionAlignment = 4096;
    static const uint32_t kSectionAlignmentMask = kSectionAlignment - 1;

    bool m_loaded;

    uint32_t m_codeSize;
    uint32_t m_dataSize;
    uint32_t m_imageSize;

    uint32_t m_tlsSize;

    uint32_t m_mainOffset;
    uint32_t m_tlsOffset;

    llvm::object::OwningBinary<llvm::object::Binary> m_binary;
    llvm::object::ObjectFile * m_obj;
    const llvm::object::COFFObjectFile * m_coff;

    llvm::object::SectionRef m_code;
    llvm::object::SectionRef m_data;

    bool FindExport(llvm::StringRef & name, uint32_t & value);

    bool LoadCode(uint8_t * base, uint32_t size);

    uint32_t AlignSectionSize(uint32_t size) 
    {
        return (size + kSectionAlignmentMask) & ~kSectionAlignmentMask;
    }

};
