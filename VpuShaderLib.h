#pragma once

#include "Vpu.h"

typedef struct { float v0; float v1; float v2; float v3; int32_t mask; } dx_types_ResRet_f32;
typedef struct { int32_t v0; int32_t v1; int32_t v2; int32_t v3; int32_t mask; } dx_types_ResRet_i32;

typedef VpuResourceHandle dx_types_Handle;

dx_types_Handle dx_op_createHandle(
    int32_t opcode,
    int8_t resource_class,
    int32_t range_id,
    int32_t index,
    int8_t non_uniform);

dx_types_ResRet_f32 dx_op_bufferLoad_f32(
    int32_t opcode,
    dx_types_Handle handle,
    int32_t index,
    int32_t offset);

dx_types_ResRet_i32 dx_op_bufferLoad_i32(
    int32_t opcode,
    dx_types_Handle handle,
    int32_t index,
    int32_t offset);

void dx_op_bufferStore_f32(
    int32_t opcode,
    dx_types_Handle handle,
    int32_t index,
    int32_t offset,
    float v0,
    float v1,
    float v2,
    float v3,
    int8_t mask);

void dx_op_bufferStore_i32(
    int32_t opcode,
    dx_types_Handle handle,
    int32_t index,
    int32_t offset,
    int32_t v0,
    int32_t v1,
    int32_t v2,
    int32_t v3,
    int32_t mask);

int32_t dx_op_threadId_i32(
    int32_t opcode,
    int32_t do_not_know);
