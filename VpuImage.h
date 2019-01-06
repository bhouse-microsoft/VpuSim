#pragma once

#include "Vpu.h"
#include <vector>
#include <assert.h>
#include <sstream>

struct VpuImageHeader
{
	uint64_t m_codeSize;
	uint64_t m_entryOffset;
	uint64_t m_tlsSize;
	uint16_t m_relocationCount;

	uint64_t GetSerializationSize(void)
	{
		return sizeof(VpuImageHeader) + (m_relocationCount * sizeof(VpuRelocation)) + m_codeSize;
	}

	uint64_t GetTlsOffset(void)
	{
		return AlignUp(m_codeSize, kVpuImageCodeAlignment);
	}

	uint64_t GetImageSize()
	{
		return AlignUp(m_codeSize, kVpuImageCodeAlignment) +
			AlignUp(m_tlsSize, kVpuImagekDataAlignment);
	}

	uint64_t GetEntryOffset()
	{
		return m_entryOffset;
	}

	bool Load(uint8_t * base, uint64_t size);
	bool ApplyRelocation(uint8_t * base, VpuRelocation * reolocation);

private:

	static const uint32_t kVpuImageCodeAlignment = 4096;
	static const uint32_t kVpuImagekDataAlignment = 4096;

	uint64_t AlignUp(uint64_t value, uint64_t alignment)
	{
		uint64_t mask = alignment - 1;
		return (value + mask) & ~mask;
	}

};
