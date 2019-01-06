#include "VpuImage.h"

#include <windows.h>

bool VpuImageHeader::Load(uint8_t * base, uint64_t size)
{
	if (size < GetImageSize())
		return false;

	VpuRelocation * relocations = (VpuRelocation *) (this + 1);
	uint8_t * code = (uint8_t *)&relocations[m_relocationCount];

    memset(base, 0, size);
    memcpy(base, code, m_codeSize);

	for(int i = 0; i < m_relocationCount; i++)
		if (!ApplyRelocation(base, &relocations[i]))
			return false;

	return true;
}

bool VpuImageHeader::ApplyRelocation(uint8_t * base, VpuRelocation * relocation)
{
	uint32_t * loc = (uint32_t *)(base + relocation->m_fixupOffset);

	if (relocation->m_type == IMAGE_REL_I386_REL32 || relocation->m_type == IMAGE_REL_AMD64_REL32)
		*loc = relocation->m_referenceOffset - relocation->m_fixupOffset - 4;
#ifdef _M_IX86
	else if (relocation.m_type == IMAGE_REL_I386_DIR32)
		*loc = relocation.m_referenceOffset + (uint32_t)base;
#endif
	else
		return false;
	return true;
}
