#pragma once

#include "Vpu.h"
#include <vector>
#include <assert.h>
#include <sstream>

class VpuImage
{
public:

	VpuImage() 
	{
		m_loaded = false;
		m_code = nullptr;
	}
	~VpuImage()
	{
		if (m_loaded) {
			assert(m_code != nullptr);
			free(m_code);
			m_code = nullptr;
		}
	}

	bool BuildFromObj(const char * objPath, const char * entryName);

	void Store(std::basic_stringstream <uint8_t> & s);
	void Load(std::basic_stringstream <uint8_t> & s);

	uint64_t GetImageInMemorySize() { return m_codeSize + m_dataSize;  }
	bool LoadInMemory(uint8_t * base, uint64_t size);
	uint64_t GetEntryOffset() { return m_entryOffset;  }
	uint64_t GetTlsOffset() { return m_codeSize; }

private:

	bool m_loaded;

	std::vector<VpuRelocation> m_relocations;
	uint8_t * m_code;

	uint64_t m_codeSize;
	uint64_t m_dataSize;

	uint64_t m_entryOffset;
	uint64_t m_tlsSize;

	uint64_t AlignUp(uint64_t value, uint64_t alignment)
	{
		uint64_t mask = alignment - 1;
		return (value + mask) & ~mask;
	}

	bool ApplyRelocation(uint8_t * base, VpuRelocation & reolocation);

};