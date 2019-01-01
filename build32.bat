clang -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
llvm-dis VpuShaderLib.bc -o=VpuShaderLib.ll

llvm-link ComputeShader.dxil VpuShaderLib.bc -o VpuShader.bc
llvm-dis VpuShader.bc -o=VpuShader.ll

llc VpuShader.bc -filetype=obj -o VpuShader.obj
llvm-objdump -r VpuShader.obj > VpuShader.reloc
llvm-objdump -disassemble -r VpuShader.obj > VpuShader.asm
llvm-objdump -t VpuShader.obj > VpuShader.sym

:: lld-link VpuShader.obj /entry:main /out:VpuShader.exe /export:g_tls /export:main /dynamicbase



