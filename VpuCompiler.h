#pragma once

#include <Windows.h>
#include <d3dcommon.h>

bool vpu_compiler(ID3DBlob * inDxilByteCode, ID3DBlob ** outVpuImage);
