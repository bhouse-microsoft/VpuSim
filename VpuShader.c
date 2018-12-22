#include <SDKDDKVer.h>

#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
// Windows Header Files
#include <windows.h>

BOOL APIENTRY DllMain(HMODULE hModule,
    DWORD  ul_reason_for_call,
    LPVOID lpReserved
)
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

#include "VpuShaderLib.h"

extern __declspec(dllexport) void shader_main();

void shader_main()
{
    int32_t threadId = dx_op_threadId_i32(0, 0);
    dx_types_Handle rUav = dx_op_createHandle(0, kVpuResourceClassUAV, 2, 2, 0);
    dx_types_Handle bUav = dx_op_createHandle(0, kVpuResourceClassUAV, 1, 1, 0);
    dx_types_Handle aUav = dx_op_createHandle(0, kVpuResourceClassUAV, 0, 0, 0);

    dx_types_ResRet_i32 ai = dx_op_bufferLoad_i32(0, aUav, threadId, 0);
    dx_types_ResRet_i32 bi = dx_op_bufferLoad_i32(0, bUav, threadId, 0);

    int32_t ri = ai.v0 + bi.v0;

    dx_op_bufferStore_i32(0, rUav, threadId, 0, ri, 0, 0, 0, 1);

    dx_types_ResRet_f32 af = dx_op_bufferLoad_f32(0, aUav, threadId, 4);
    dx_types_ResRet_f32 bf = dx_op_bufferLoad_f32(0, bUav, threadId, 4);

    float rf = af.v0 + bf.v0;

    dx_op_bufferStore_f32(0, rUav, threadId, 4, rf, 0, 0, 0, 1);
}
