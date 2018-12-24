:: llvm-as ComputeShader.ll -o ComputeShader.bc
llc -filetype=obj ComputeShader.ll -o ComputeShader.obj

:: clang -c VpuSim.cpp -emit-llvm -o VpuSim.bc
:: llvm-dis < VpuSim.bc > VpuSim.ll
:: llc -filetype=obj VpuSim.bc -o VpuSim.obj

clang -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
llvm-dis < VpuShaderLib.bc > VpuShaderLib.ll
llc -filetype=obj VpuShaderLib.ll -o VpuShaderLib.obj

:: llvm-link  -o VpuShader.bc ComputeShader.bc VpuShaderLib.bc
:: llvm-dis < VpuShader.bc > VpuShader.ll

:: llc -filetype=obj VpuShader.bc -o VpuShader.obj

:: clang ComputeShader.obj VpuSim.obj VpuShaderLib.obj -o VpuSim.exe

lld-link VpuShaderLib.obj ComputeShader.obj /entry:main /out:VpuShader.exe /export:g_tls /export:main /dynamicbase

