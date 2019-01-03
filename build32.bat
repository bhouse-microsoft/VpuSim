set KITSBIN=%ProgramFiles(x86)%\Windows Kits\10\bin\10.0.18298.0\x64
set GITDIR=C:\git
set LLVMBIN=%GIDDIR%\github.com\bhouse-microsoft\VpuSimShaderCompiler.build32\debug\bin

%LLVMBIN%\clang -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
%LLVMBIN%\llvm-dis VpuShaderLib.bc -o=VpuShaderLib.ll

%LLVMBIN%\llvm-link ComputeShader.dxil VpuShaderLib.bc -o VpuShader.bc
%LLVMBIN%\llvm-dis VpuShader.bc -o=VpuShader.ll

%LLVMBIN%\llc VpuShader.bc -filetype=obj -o VpuShader.obj
%LLVMBIN%\llvm-objdump -r VpuShader.obj > VpuShader.reloc
%LLVMBIN%\llvm-objdump -disassemble -r VpuShader.obj > VpuShader.asm
%LLVMBIN%\llvm-objdump -t VpuShader.obj > VpuShader.sym

:: %LLVMBIN%\lld-link VpuShader.obj /entry:main /out:VpuShader.exe /export:g_tls /export:main /dynamicbase



