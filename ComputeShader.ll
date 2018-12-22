;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
;
; Pipeline Runtime Information: 
;
;
;
; Buffer Definitions:
;
; Resource bind info for Buffer0
; {
;
;   struct struct.BufType
;   {
;
;       int i;                                        ; Offset:    0
;       float f;                                      ; Offset:    4
;   
;   } $Element;                                       ; Offset:    0 Size:     8
;
; }
;
; Resource bind info for Buffer1
; {
;
;   struct struct.BufType
;   {
;
;       int i;                                        ; Offset:    0
;       float f;                                      ; Offset:    4
;   
;   } $Element;                                       ; Offset:    0 Size:     8
;
; }
;
; Resource bind info for BufferOut
; {
;
;   struct struct.BufType
;   {
;
;       int i;                                        ; Offset:    0
;       float f;                                      ; Offset:    4
;   
;   } $Element;                                       ; Offset:    0 Size:     8
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; Buffer0                               UAV  struct         r/w      U0             u0     1
; Buffer1                               UAV  struct         r/w      U1             u1     1
; BufferOut                             UAV  struct         r/w      U2             u2     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "i686-pc-windows-msvc19.16.27025"

%"class.RWStructuredBuffer<BufType>" = type { %struct.BufType }
%struct.BufType = type { i32, float }
%dx_types_Handle = type { i8* }
%dx_types_ResRet_i32 = type { i32, i32, i32, i32, i32 }
%dx_types_ResRet_f32 = type { float, float, float, float, i32 }

@"\01?Buffer0@@3V?$RWStructuredBuffer@UBufType@@@@A" = external constant %"class.RWStructuredBuffer<BufType>", align 4
@"\01?Buffer1@@3V?$RWStructuredBuffer@UBufType@@@@A" = external constant %"class.RWStructuredBuffer<BufType>", align 4
@"\01?BufferOut@@3V?$RWStructuredBuffer@UBufType@@@@A" = external constant %"class.RWStructuredBuffer<BufType>", align 4

define void @shader_main() {
entry:
  %BufferOut_UAV_structbuf = call %dx_types_Handle @dx_op_createHandle(i32 57, i8 1, i32 2, i32 2, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %Buffer1_UAV_structbuf = call %dx_types_Handle @dx_op_createHandle(i32 57, i8 1, i32 1, i32 1, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %Buffer0_UAV_structbuf = call %dx_types_Handle @dx_op_createHandle(i32 57, i8 1, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %0 = call i32 @dx_op_threadId_i32(i32 93, i32 0)  ; ThreadId(component)
  %1 = call %dx_types_ResRet_i32 @dx_op_bufferLoad_i32(i32 68, %dx_types_Handle %Buffer0_UAV_structbuf, i32 %0, i32 0)  ; BufferLoad(srv,index,wot)
  %2 = extractvalue %dx_types_ResRet_i32 %1, 0
  %3 = call %dx_types_ResRet_i32 @dx_op_bufferLoad_i32(i32 68, %dx_types_Handle %Buffer1_UAV_structbuf, i32 %0, i32 0)  ; BufferLoad(srv,index,wot)
  %4 = extractvalue %dx_types_ResRet_i32 %3, 0
  %add = add nsw i32 %4, %2
  call void @dx_op_bufferStore_i32(i32 69, %dx_types_Handle %BufferOut_UAV_structbuf, i32 %0, i32 0, i32 %add, i32 undef, i32 undef, i32 undef, i8 1)  ; BufferStore(uav,coord0,coord1,value0,value1,value2,value3,mask)
  %5 = call %dx_types_ResRet_f32 @dx_op_bufferLoad_f32(i32 68, %dx_types_Handle %Buffer0_UAV_structbuf, i32 %0, i32 4)  ; BufferLoad(srv,index,wot)
  %6 = extractvalue %dx_types_ResRet_f32 %5, 0
  %7 = call %dx_types_ResRet_f32 @dx_op_bufferLoad_f32(i32 68, %dx_types_Handle %Buffer1_UAV_structbuf, i32 %0, i32 4)  ; BufferLoad(srv,index,wot)
  %8 = extractvalue %dx_types_ResRet_f32 %7, 0
  %add8 = fadd fast float %8, %6
  call void @dx_op_bufferStore_f32(i32 69, %dx_types_Handle %BufferOut_UAV_structbuf, i32 %0, i32 4, float %add8, float undef, float undef, float undef, i8 1)  ; BufferStore(uav,coord0,coord1,value0,value1,value2,value3,mask)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx_op_threadId_i32(i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx_types_Handle @dx_op_createHandle(i32, i8, i32, i32, i1) #1

; Function Attrs: nounwind readonly
declare %dx_types_ResRet_i32 @dx_op_bufferLoad_i32(i32, %dx_types_Handle, i32, i32) #1

; Function Attrs: nounwind
declare void @dx_op_bufferStore_i32(i32, %dx_types_Handle, i32, i32, i32, i32, i32, i32, i8) #2

; Function Attrs: nounwind readonly
declare %dx_types_ResRet_f32 @dx_op_bufferLoad_f32(i32, %dx_types_Handle, i32, i32) #1

; Function Attrs: nounwind
declare void @dx_op_bufferStore_f32(i32, %dx_types_Handle, i32, i32, float, float, float, float, i8) #2

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.typeAnnotations = !{!10, !16}
!dx.entryPoints = !{!20}

!0 = !{!"clang version 3.7 (tags/RELEASE_370/final)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 4}
!3 = !{!"cs", i32 6, i32 0}
!4 = !{null, !5, null, null}
!5 = !{!6, !8, !9}
!6 = !{i32 0, %"class.RWStructuredBuffer<BufType>"* undef, !"Buffer0", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!7 = !{i32 1, i32 8}
!8 = !{i32 1, %"class.RWStructuredBuffer<BufType>"* undef, !"Buffer1", i32 0, i32 1, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!9 = !{i32 2, %"class.RWStructuredBuffer<BufType>"* undef, !"BufferOut", i32 0, i32 2, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!10 = !{i32 0, %"class.RWStructuredBuffer<BufType>" undef, !11, %struct.BufType undef, !13}
!11 = !{i32 8, !12}
!12 = !{i32 6, !"h", i32 3, i32 0}
!13 = !{i32 8, !14, !15}
!14 = !{i32 6, !"i", i32 3, i32 0, i32 7, i32 4}
!15 = !{i32 6, !"f", i32 3, i32 4, i32 7, i32 9}
!16 = !{i32 1, void ()* @shader_main, !17}
!17 = !{!18}
!18 = !{i32 0, !19, !19}
!19 = !{}
!20 = !{void ()* @shader_main, !"shader_main", null, !4, !21}
!21 = !{i32 0, i64 16, i32 4, !22}
!22 = !{i32 4, i32 1, i32 1}

