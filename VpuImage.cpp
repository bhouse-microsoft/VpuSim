#include "VpuImage.h"
#include "VpuObject.h"

#include "llvm/Support/Error.h"
#include "llvm/Object/Binary.h"
#include "llvm/Object/ObjectFile.h"
#include "llvm/Object/COFF.h"
#include "llvm/Object/ELF.h"

#include <windows.h>

using namespace llvm;
using namespace object;

#define TLS_SYMBOL "g_tls"

bool VpuImage::BuildFromObj(const char * objPath, const char * entryName)
{
	bool success = true;
	VpuObject obj;

	success = obj.Open(objPath) &&
		obj.GetSymbolValue(entryName, m_entryOffset) &&
		obj.GetSymbolValue(TLS_SYMBOL, m_tlsSize);
	
	if (success) {
		static const uint32_t kCodeAlignment = 4096;
		static const uint32_t kDataAlignment = 4096;

		m_codeSize = AlignUp(obj.GetCodeSize(), kCodeAlignment);
		m_dataSize = AlignUp(m_tlsSize, kDataAlignment);

		m_code = (uint8_t *)malloc(m_codeSize);
		success = obj.GetCode(m_code, m_codeSize);
	}

	if (success) {
		std::vector<VpuObjRelocation> objRelocations;

		obj.GetRelocations(objRelocations);

		for (auto & or : objRelocations) {
			VpuRelocation r;

			r.m_fixupOffset = or.m_fixupOffset;
			r.m_type = or.m_type;

			if (or.m_symbolName == TLS_SYMBOL)
				r.m_referenceOffset = m_codeSize;
			else {

				std::string name = or.m_symbolName;

				if (!obj.GetSymbolValue(name.c_str(), r.m_referenceOffset)) {
					success = false;
					break;
				}
			}

			m_relocations.push_back(r);
		}
	}

	obj.Close();

	m_loaded = success;

	return success;
}

void VpuImage::Store(std::basic_stringstream <uint8_t> & s)
{
	assert(m_loaded);

	s.write((uint8_t *) &m_codeSize, sizeof(m_codeSize));
	s.write((uint8_t *) &m_dataSize, sizeof(m_dataSize));
	s.write((uint8_t *) &m_entryOffset, sizeof(m_entryOffset));
	s.write((uint8_t *) &m_tlsSize, sizeof(m_tlsSize));

	uint64_t num_relocations = m_relocations.size();
	s.write((uint8_t *)&num_relocations, sizeof(m_tlsSize));

	s.write(m_code, m_codeSize);

	for (auto & r : m_relocations) {
		s.write((uint8_t *)&r, sizeof(r));
		assert(!s.fail());
	}
}

void VpuImage::Load(std::basic_stringstream <uint8_t> & s)
{
	assert(!m_loaded);

	s.read((uint8_t *)&m_codeSize, sizeof(m_codeSize));
	s.read((uint8_t *)&m_dataSize, sizeof(m_dataSize));
	s.read((uint8_t *)&m_entryOffset, sizeof(m_entryOffset));
	s.read((uint8_t *)&m_tlsSize, sizeof(m_tlsSize));

	uint64_t num_relocations;
	s.read((uint8_t *)&num_relocations, sizeof(m_tlsSize));

	m_code = (uint8_t *)malloc(m_codeSize);
	assert(m_code != NULL);
	s.read(m_code, m_codeSize);
	assert(!s.fail());

	while (num_relocations-- > 0) {
		VpuRelocation r;
		s.read((uint8_t *)&r, sizeof(r));
		assert(!s.fail());
		m_relocations.push_back(r);
	}
	m_loaded = true;

}

bool VpuImage::LoadInMemory(uint8_t * base, uint64_t size)
{
	if (size < (m_codeSize + m_dataSize))
		return false;

    memset(base, 0, size);
    memcpy(base, m_code, m_codeSize);

	for (auto & r : m_relocations)
		if (!ApplyRelocation(base, r))
			return false;

	return true;
}

bool VpuImage::ApplyRelocation(uint8_t * base, VpuRelocation & relocation)
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
