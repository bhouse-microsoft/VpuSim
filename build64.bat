set KITSBIN=%ProgramFiles(x86)%\Windows Kits\10\bin\10.0.18298.0\x64
set GITDIR=C:\git
set LLVMBIN=%GITDIR%\github.com\bhouse-microsoft\VpuSimShaderCompiler.build64\debug\bin
:: set CLANGBIN=%ProgramFiles%\LLVM\bin
set CLANGBIN=C:\llvm\7.0.0\x32\bin

set DXC="%KITSBIN%\dxc.exe"
set CLANG="%CLANGBIN%\clang.exe"

:: Build test dxil
%DXC% -T cs_6_0 -E main Test.hlsl > Test.dxil

:: Build VpuShaderLib.ll
%CLANG% -march=x86-64 -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
%LLVMBIN%\llvm-dis VpuShaderLib.bc -o=VpuShaderLib.ll
del VpuShaderLib.bc

:: %CLANG% -march=x86-64 -c VpuShader.c -emit-llvm -o VpuShader.bc
:: %LLVMBIN%\llvm-dis VpuShader.bc -o=VpuShader.ll

:: %LLVMBIN%\llc -mtriple=x86_64-AMD-windows VpuShaderLib.bc -filetype=obj -o VpuShaderLib.obj
:: %LLVMBIN%\llvm-objdump -r VpuShaderLib.obj > VpuShaderLib.reloc
:: %LLVMBIN%\llvm-objdump -disassemble -r VpuShaderLib.obj > VpuShaderLib.asm
:: %LLVMBIN%\llvm-objdump -t VpuShaderLib.obj > VpuShaderLib.sym

:: %LLVMBIN%\llc -mtriple=x86_64-AMD-windows Test.dxil -filetype=obj -o Test.obj
:: %LLVMBIN%\llvm-objdump -r Test.obj > Test.reloc
:: %LLVMBIN%\llvm-objdump -disassemble -r Test.obj > Test.asm
:: %LLVMBIN%\llvm-objdump -t Test.obj > Test.sym

:: %LLVMBIN%\llc -mtriple=x86_64-AMD-windows VpuShader.bc -filetype=obj -o VpuShader.obj
:: %LLVMBIN%\llvm-objdump -r VpuShader.obj > VpuShader.reloc
:: %LLVMBIN%\llvm-objdump -disassemble -r VpuShader.obj > VpuShader.asm
:: %LLVMBIN%\llvm-objdump -t VpuShader.obj > VpuShader.sym

:: %LLVMBIN%\llc -mtriple=x86_64-AMD-windows DxilToVpu.ll -filetype=obj -o DxilToVpu.obj
:: %LLVMBIN%\llvm-objdump -r DxilToVpu.obj > DxilToVpu.reloc
:: %LLVMBIN%\llvm-objdump -disassemble -r DxilToVpu.obj > DxilToVpu.asm
:: %LLVMBIN%\llvm-objdump -t DxilToVpu.obj > DxilToVpu.sym

:: %CLANG% -march=x86-64 -c ComputeShader.c -emit-llvm -o ComputeShader.bc
:: %LLVMBIN%\llvm-dis ComputeShader.bc -o=ComputeShader.ll

:: %LLVMBIN%\llvm-link VpuShaderLib.bc DxilToVpu.ll Test.dxil -o VpuShader.bc
:: %LLVMBIN%\llvm-dis VpuShader.bc -o=VpuShader.ll

:: %LLVMBIN%\llc -mtriple=x86_64-pc-windows-msvc19.16.27025 VpuShader.bc -filetype=obj -o VpuShader.obj
:: %LLVMBIN%\llvm-objdump -r VpuShader.obj > VpuShader.reloc
:: %LLVMBIN%\llvm-objdump -disassemble -r VpuShader.obj > VpuShader.asm
:: %LLVMBIN%\llvm-objdump -t VpuShader.obj > VpuShader.sym


