#include "VpuShaderLib.h"

void shader_main(void)
{
  dx_types_Handle bufferOut = dx_op_createHandle(57, 1, 2, 2, 0);
  dx_types_Handle buffer1 = dx_op_createHandle(57, 1, 2, 2, 0);
  dx_types_Handle buffer0 = dx_op_createHandle(57, 1, 2, 2, 0);
  
  int32_t threadId = dx_op_threadId_i32(93, 0);
  
  dx_types_ResRet_i32 i0 = dx_op_bufferLoad_i32(68, buffer0, 0, 0);
  dx_types_ResRet_i32 i1 = dx_op_bufferLoad_i32(68, buffer1, 0, 0);
  int32_t iadd = i0.v0 + i1.v0;
  dx_op_bufferStore_i32(69, bufferOut, 0, 0, iadd, 0, 0, 0, 1);
  
  dx_types_ResRet_f32 f0 = dx_op_bufferLoad_f32(68, buffer0, 0, 0);
  dx_types_ResRet_f32 f1 = dx_op_bufferLoad_f32(68, buffer1, 0, 0);
  int32_t fadd = f0.v0 + f1.v0;
  dx_op_bufferStore_i32(69, bufferOut, 0, 0, fadd, 0, 0, 0, 1);
}
