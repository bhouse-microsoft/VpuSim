set DXC=c:\git\github.com\bhouse-microsoft\hlsl.bin\Debug\bin\dxc.exe

%DXC% -T cs_6_0 -E main ComputeShader.hlsl > ComputeShader.dxil

clang -march=i386 -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
llvm-dis VpuShaderLib.bc -o=VpuShaderLib.ll

clang -march=i386 -c ComputeShader.c -emit-llvm -o ComputeShader.bc
llvm-dis ComputeShader.bc -o=ComputeShader.ll

llvm-link VpuShaderLib.bc ComputeShader.dxil.rename -o VpuShader.bc
::llvm-link ComputeShader.bc VpuShaderLib.bc -o VpuShader.bc
llvm-dis VpuShader.bc -o=VpuShader.ll

llc -march=x86-64 VpuShader.bc -filetype=obj -o VpuShader.obj
llvm-objdump -r VpuShader.obj > VpuShader.reloc
llvm-objdump -disassemble -r VpuShader.obj > VpuShader.asm
llvm-objdump -t VpuShader.obj > VpuShader.sym

:: lld-link VpuShader.obj /entry:main /out:VpuShader.exe /export:g_tls /export:main /dynamicbase


