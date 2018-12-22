#pragma once

#include <stdint.h>

#define kVpuSegmentUndefined 0
#define kVpuSegmentGlobal 1
#define kVpuSegmentGroupShared 2
#define kVpuSegmentLocal 3
#define kVpuSegmentGlobalConstant 4

typedef int32_t VpuSegment;

#define kVpuResourceClassSRV 0
#define kVpuResourceClassUAV 1
#define kVpuResourceClassCBV 2
#define kVpuResourceClassSampler 3

typedef int32_t VpuResourceClass;

typedef struct {
    int8_t * m_base;
    int32_t m_elementSize;
} VpuResourceDescriptor;

#define kVpuMaxUAVs 4

typedef struct {
    int32_t m_id;
    VpuResourceDescriptor m_uavs[kVpuMaxUAVs];
} VpuThreadLocalStorage;

typedef VpuResourceDescriptor * VpuResourceHandle;
