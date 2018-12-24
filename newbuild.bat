:: llvm-as ComputeShader.ll -o ComputeShader.bc
:: llc -filetype=obj ComputeShader.ll -o ComputeShader.obj
:: clang -c VpuSim.cpp -emit-llvm -o VpuSim.bc
:: llvm-dis < VpuSim.bc > VpuSim.ll
:: llc -filetype=obj VpuSim.bc -o VpuSim.obj
:: llvm-dis < VpuShaderLib.bc > VpuShaderLib.ll
:: llc -filetype=obj VpuShaderLib.ll -o VpuShaderLib.obj
:: llvm-dis < VpuShader.bc > VpuShader.ll
:: clang ComputeShader.obj VpuSim.obj VpuShaderLib.obj -o VpuSim.exe

clang -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
llvm-link ComputeShader.ll VpuShaderLib.bc -o VpuShader.bc
llc VpuShader.bc -filetype=obj -o VpuShader.obj
lld-link VpuShader.obj /entry:main /out:VpuShader.exe /export:g_tls /export:main /dynamicbase



