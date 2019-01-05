#include "VpuCompiler.h"
#include "LlvmLinker.h"
#include "LlvmCompiler.h"
#include "VpuImage.h"

#include <dxcapi.h>
#include <d3dcompiler.h>

#include <assert.h>

bool vpu_compiler(ID3DBlob * inDxilByteCode, ID3DBlob ** outVpuImage)
{
	IDxcCompiler * pCompiler;
	HRESULT hr = DxcCreateInstance(CLSID_DxcCompiler, __uuidof(IDxcCompiler), (void **)& pCompiler);
	assert(hr == S_OK);

	IDxcBlobEncoding * pDisassembly;
	hr = pCompiler->Disassemble((IDxcBlob *)inDxilByteCode, &pDisassembly);
	assert(hr == S_OK);

	hr = D3DWriteBlobToFile((ID3DBlob *)pDisassembly, L"dis.dxil", TRUE);
	assert(hr == S_OK);

	pDisassembly->Release();
	pCompiler->Release();

	llvm_linker("vpu_compiler",
		"VpuShaderLib.bc",
		"DxilToVpu.ll",
		"dis.dxil",
		"VpuShader.bc");

	llvm_compile("vpu_compiler", "VpuShader.bc", "VpuShader.obj");

	VpuImage vpuImage;

	if (!vpuImage.BuildFromObj("VpuShader.obj", "main")) {
		printf("error opening object\n");
		exit(1);
	}

	std::basic_stringstream<uint8_t> storage;
	vpuImage.Store(storage);

	uint64_t blobSize = storage.tellp();

	printf("image storage size = %d\n", (int)blobSize);

	hr = D3DCreateBlob(blobSize, outVpuImage);
	assert(hr == S_OK);

	storage.seekp(0);
	storage.read((uint8_t *)(*outVpuImage)->GetBufferPointer(), blobSize);

	return true;
}
