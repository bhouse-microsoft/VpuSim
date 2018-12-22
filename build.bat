llvm-as ComputeShader.ll -o ComputeShader.bc
llc -filetype=obj ComputeShader.bc -o ComputeShader.obj

clang -c VpuSim.cpp -emit-llvm -o VpuSim.bc
llvm-dis < VpuSim.bc > VpuSim.ll
llc -filetype=obj VpuSim.bc -o VpuSim.obj

clang -c VpuShaderLib.c -emit-llvm -o VpuShaderLib.bc
llvm-dis < VpuShaderLib.bc > VpuShaderLib.ll
llc -filetype=obj VpuShaderLib.bc -o VpuShaderLib.obj

clang ComputeShader.obj VpuSim.obj VpuShaderLib.obj -o VpuSim.exe
