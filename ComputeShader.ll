; ModuleID = 'ComputeShader.bc'
source_filename = "ComputeShader.c"
target datalayout = "e-m:x-p:32:32-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i686-pc-windows-msvc19.16.27025"

%struct.VpuResourceDescriptor = type { i8*, i32 }
%struct.dx_types_ResRet_i32 = type { i32, i32, i32, i32, i32 }
%struct.dx_types_ResRet_f32 = type { float, float, float, float, i32 }

; Function Attrs: noinline nounwind optnone
define dso_local void @shader_main() #0 {
  %1 = alloca %struct.VpuResourceDescriptor*, align 4
  %2 = alloca %struct.VpuResourceDescriptor*, align 4
  %3 = alloca %struct.VpuResourceDescriptor*, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.dx_types_ResRet_i32, align 4
  %6 = alloca %struct.dx_types_ResRet_i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.dx_types_ResRet_f32, align 4
  %9 = alloca %struct.dx_types_ResRet_f32, align 4
  %10 = alloca i32, align 4
  %11 = call %struct.VpuResourceDescriptor* @dx_op_createHandle(i32 57, i8 signext 1, i32 2, i32 2, i8 signext 0)
  store %struct.VpuResourceDescriptor* %11, %struct.VpuResourceDescriptor** %1, align 4
  %12 = call %struct.VpuResourceDescriptor* @dx_op_createHandle(i32 57, i8 signext 1, i32 2, i32 2, i8 signext 0)
  store %struct.VpuResourceDescriptor* %12, %struct.VpuResourceDescriptor** %2, align 4
  %13 = call %struct.VpuResourceDescriptor* @dx_op_createHandle(i32 57, i8 signext 1, i32 2, i32 2, i8 signext 0)
  store %struct.VpuResourceDescriptor* %13, %struct.VpuResourceDescriptor** %3, align 4
  %14 = call i32 @dx_op_threadId_i32(i32 93, i32 0)
  store i32 %14, i32* %4, align 4
  %15 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %3, align 4
  call void @dx_op_bufferLoad_i32(%struct.dx_types_ResRet_i32* sret %5, i32 68, %struct.VpuResourceDescriptor* %15, i32 0, i32 0)
  %16 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %2, align 4
  call void @dx_op_bufferLoad_i32(%struct.dx_types_ResRet_i32* sret %6, i32 68, %struct.VpuResourceDescriptor* %16, i32 0, i32 0)
  %17 = getelementptr inbounds %struct.dx_types_ResRet_i32, %struct.dx_types_ResRet_i32* %5, i32 0, i32 0
  %18 = load i32, i32* %17, align 4
  %19 = getelementptr inbounds %struct.dx_types_ResRet_i32, %struct.dx_types_ResRet_i32* %6, i32 0, i32 0
  %20 = load i32, i32* %19, align 4
  %21 = add nsw i32 %18, %20
  store i32 %21, i32* %7, align 4
  %22 = load i32, i32* %7, align 4
  %23 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %1, align 4
  call void @dx_op_bufferStore_i32(i32 69, %struct.VpuResourceDescriptor* %23, i32 0, i32 0, i32 %22, i32 0, i32 0, i32 0, i32 1)
  %24 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %3, align 4
  call void @dx_op_bufferLoad_f32(%struct.dx_types_ResRet_f32* sret %8, i32 68, %struct.VpuResourceDescriptor* %24, i32 0, i32 0)
  %25 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %2, align 4
  call void @dx_op_bufferLoad_f32(%struct.dx_types_ResRet_f32* sret %9, i32 68, %struct.VpuResourceDescriptor* %25, i32 0, i32 0)
  %26 = getelementptr inbounds %struct.dx_types_ResRet_f32, %struct.dx_types_ResRet_f32* %8, i32 0, i32 0
  %27 = load float, float* %26, align 4
  %28 = getelementptr inbounds %struct.dx_types_ResRet_f32, %struct.dx_types_ResRet_f32* %9, i32 0, i32 0
  %29 = load float, float* %28, align 4
  %30 = fadd float %27, %29
  %31 = fptosi float %30 to i32
  store i32 %31, i32* %10, align 4
  %32 = load i32, i32* %10, align 4
  %33 = load %struct.VpuResourceDescriptor*, %struct.VpuResourceDescriptor** %1, align 4
  call void @dx_op_bufferStore_i32(i32 69, %struct.VpuResourceDescriptor* %33, i32 0, i32 0, i32 %32, i32 0, i32 0, i32 0, i32 1)
  ret void
}

declare dso_local %struct.VpuResourceDescriptor* @dx_op_createHandle(i32, i8 signext, i32, i32, i8 signext) #1

declare dso_local i32 @dx_op_threadId_i32(i32, i32) #1

declare dso_local void @dx_op_bufferLoad_i32(%struct.dx_types_ResRet_i32* sret, i32, %struct.VpuResourceDescriptor*, i32, i32) #1

declare dso_local void @dx_op_bufferStore_i32(i32, %struct.VpuResourceDescriptor*, i32, i32, i32, i32, i32, i32, i32) #1

declare dso_local void @dx_op_bufferLoad_f32(%struct.dx_types_ResRet_f32* sret, i32, %struct.VpuResourceDescriptor*, i32, i32) #1

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="i386" "target-features"="+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="i386" "target-features"="+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
