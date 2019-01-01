
VpuShader.obj:	file format COFF-i386

Disassembly of section .text:
_main:
       0:	55 	pushl	%ebp
       1:	53 	pushl	%ebx
       2:	57 	pushl	%edi
       3:	56 	pushl	%esi
       4:	83 ec 58 	subl	$88, %esp
       7:	6a 00 	pushl	$0
       9:	6a 02 	pushl	$2
       b:	6a 02 	pushl	$2
       d:	6a 01 	pushl	$1
       f:	6a 39 	pushl	$57
      11:	e8 00 00 00 00 	calll	0 <_main+0x16>
			00000012:  IMAGE_REL_I386_REL32	_dx.op.createHandle
      16:	83 c4 14 	addl	$20, %esp
      19:	89 44 24 04 	movl	%eax, 4(%esp)
      1d:	6a 00 	pushl	$0
      1f:	6a 01 	pushl	$1
      21:	6a 01 	pushl	$1
      23:	6a 01 	pushl	$1
      25:	6a 39 	pushl	$57
      27:	e8 00 00 00 00 	calll	0 <_main+0x2c>
			00000028:  IMAGE_REL_I386_REL32	_dx.op.createHandle
      2c:	83 c4 14 	addl	$20, %esp
      2f:	89 c7 	movl	%eax, %edi
      31:	6a 00 	pushl	$0
      33:	6a 00 	pushl	$0
      35:	6a 00 	pushl	$0
      37:	6a 01 	pushl	$1
      39:	6a 39 	pushl	$57
      3b:	e8 00 00 00 00 	calll	0 <_main+0x40>
			0000003c:  IMAGE_REL_I386_REL32	_dx.op.createHandle
      40:	83 c4 14 	addl	$20, %esp
      43:	89 c5 	movl	%eax, %ebp
      45:	6a 00 	pushl	$0
      47:	6a 5d 	pushl	$93
      49:	e8 00 00 00 00 	calll	0 <_main+0x4e>
			0000004a:  IMAGE_REL_I386_REL32	_dx.op.threadId.i32
      4e:	83 c4 08 	addl	$8, %esp
      51:	89 c3 	movl	%eax, %ebx
      53:	8d 44 24 44 	leal	68(%esp), %eax
      57:	6a 00 	pushl	$0
      59:	53 	pushl	%ebx
      5a:	55 	pushl	%ebp
      5b:	6a 44 	pushl	$68
      5d:	50 	pushl	%eax
      5e:	e8 00 00 00 00 	calll	0 <_main+0x63>
			0000005f:  IMAGE_REL_I386_REL32	_dx.op.bufferLoad.i32
      63:	83 c4 14 	addl	$20, %esp
      66:	8b 74 24 44 	movl	68(%esp), %esi
      6a:	8d 44 24 30 	leal	48(%esp), %eax
      6e:	6a 00 	pushl	$0
      70:	53 	pushl	%ebx
      71:	57 	pushl	%edi
      72:	6a 44 	pushl	$68
      74:	50 	pushl	%eax
      75:	e8 00 00 00 00 	calll	0 <_main+0x7a>
			00000076:  IMAGE_REL_I386_REL32	_dx.op.bufferLoad.i32
      7a:	83 c4 14 	addl	$20, %esp
      7d:	03 74 24 30 	addl	48(%esp), %esi
      81:	83 ec 24 	subl	$36, %esp
      84:	89 74 24 10 	movl	%esi, 16(%esp)
      88:	89 5c 24 08 	movl	%ebx, 8(%esp)
      8c:	8b 74 24 28 	movl	40(%esp), %esi
      90:	89 74 24 04 	movl	%esi, 4(%esp)
      94:	c7 44 24 20 01 00 00 00 	movl	$1, 32(%esp)
      9c:	c7 44 24 0c 00 00 00 00 	movl	$0, 12(%esp)
      a4:	c7 04 24 45 00 00 00 	movl	$69, (%esp)
      ab:	e8 00 00 00 00 	calll	0 <_main+0xb0>
			000000ac:  IMAGE_REL_I386_REL32	_dx.op.bufferStore.i32
      b0:	83 c4 24 	addl	$36, %esp
      b3:	8d 44 24 1c 	leal	28(%esp), %eax
      b7:	6a 04 	pushl	$4
      b9:	53 	pushl	%ebx
      ba:	55 	pushl	%ebp
      bb:	6a 44 	pushl	$68
      bd:	50 	pushl	%eax
      be:	e8 00 00 00 00 	calll	0 <_main+0xc3>
			000000bf:  IMAGE_REL_I386_REL32	_dx.op.bufferLoad.f32
      c3:	83 c4 14 	addl	$20, %esp
      c6:	d9 44 24 1c 	flds	28(%esp)
      ca:	d9 1c 24 	fstps	(%esp)
      cd:	8d 44 24 08 	leal	8(%esp), %eax
      d1:	6a 04 	pushl	$4
      d3:	53 	pushl	%ebx
      d4:	57 	pushl	%edi
      d5:	6a 44 	pushl	$68
      d7:	50 	pushl	%eax
      d8:	e8 00 00 00 00 	calll	0 <_main+0xdd>
			000000d9:  IMAGE_REL_I386_REL32	_dx.op.bufferLoad.f32
      dd:	83 c4 14 	addl	$20, %esp
      e0:	d9 04 24 	flds	(%esp)
      e3:	d8 44 24 08 	fadds	8(%esp)
      e7:	83 ec 24 	subl	$36, %esp
      ea:	d9 5c 24 10 	fstps	16(%esp)
      ee:	89 5c 24 08 	movl	%ebx, 8(%esp)
      f2:	89 74 24 04 	movl	%esi, 4(%esp)
      f6:	c7 44 24 20 01 00 00 00 	movl	$1, 32(%esp)
      fe:	c7 44 24 0c 04 00 00 00 	movl	$4, 12(%esp)
     106:	c7 04 24 45 00 00 00 	movl	$69, (%esp)
     10d:	e8 00 00 00 00 	calll	0 <_main+0x112>
			0000010e:  IMAGE_REL_I386_REL32	_dx.op.bufferStore.f32
     112:	83 c4 7c 	addl	$124, %esp
     115:	5e 	popl	%esi
     116:	5f 	popl	%edi
     117:	5b 	popl	%ebx
     118:	5d 	popl	%ebp
     119:	c3 	retl
     11a:	90 	nop
     11b:	90 	nop
     11c:	90 	nop
     11d:	90 	nop
     11e:	90 	nop
     11f:	90 	nop

_memset:
     120:	55 	pushl	%ebp
     121:	89 e5 	movl	%esp, %ebp
     123:	50 	pushl	%eax
     124:	8b 45 10 	movl	16(%ebp), %eax
     127:	8b 45 0c 	movl	12(%ebp), %eax
     12a:	8b 45 08 	movl	8(%ebp), %eax
     12d:	8b 45 08 	movl	8(%ebp), %eax
     130:	89 45 fc 	movl	%eax, -4(%ebp)
     133:	8b 45 10 	movl	16(%ebp), %eax
     136:	89 c1 	movl	%eax, %ecx
     138:	83 c1 ff 	addl	$-1, %ecx
     13b:	89 4d 10 	movl	%ecx, 16(%ebp)
     13e:	83 f8 00 	cmpl	$0, %eax
     141:	76 12 	jbe	18 <_memset+0x35>
     143:	8b 45 0c 	movl	12(%ebp), %eax
     146:	8b 4d fc 	movl	-4(%ebp), %ecx
     149:	89 ca 	movl	%ecx, %edx
     14b:	83 c2 01 	addl	$1, %edx
     14e:	89 55 fc 	movl	%edx, -4(%ebp)
     151:	88 01 	movb	%al, (%ecx)
     153:	eb de 	jmp	-34 <_memset+0x13>
     155:	8b 45 08 	movl	8(%ebp), %eax
     158:	83 c4 04 	addl	$4, %esp
     15b:	5d 	popl	%ebp
     15c:	c3 	retl
     15d:	90 	nop
     15e:	90 	nop
     15f:	90 	nop

_dx_op_createHandle:
     160:	55 	pushl	%ebp
     161:	89 e5 	movl	%esp, %ebp
     163:	50 	pushl	%eax
     164:	8a 45 18 	movb	24(%ebp), %al
     167:	8b 45 14 	movl	20(%ebp), %eax
     16a:	8b 45 10 	movl	16(%ebp), %eax
     16d:	8a 45 0c 	movb	12(%ebp), %al
     170:	8b 45 08 	movl	8(%ebp), %eax
     173:	8d 05 00 00 00 00 	leal	0, %eax
			00000175:  IMAGE_REL_I386_DIR32	_g_tls
     179:	83 c0 04 	addl	$4, %eax
     17c:	8b 4d 14 	movl	20(%ebp), %ecx
     17f:	c1 e1 03 	shll	$3, %ecx
     182:	01 c8 	addl	%ecx, %eax
     184:	89 45 fc 	movl	%eax, -4(%ebp)
     187:	8b 45 fc 	movl	-4(%ebp), %eax
     18a:	83 c4 04 	addl	$4, %esp
     18d:	5d 	popl	%ebp
     18e:	c3 	retl
     18f:	90 	nop

_dx_op_bufferLoad_f32:
     190:	55 	pushl	%ebp
     191:	89 e5 	movl	%esp, %ebp
     193:	56 	pushl	%esi
     194:	83 ec 0c 	subl	$12, %esp
     197:	8b 75 08 	movl	8(%ebp), %esi
     19a:	8b 45 18 	movl	24(%ebp), %eax
     19d:	8b 45 14 	movl	20(%ebp), %eax
     1a0:	8b 45 10 	movl	16(%ebp), %eax
     1a3:	8b 45 0c 	movl	12(%ebp), %eax
     1a6:	31 c0 	xorl	%eax, %eax
     1a8:	89 34 24 	movl	%esi, (%esp)
     1ab:	c7 44 24 04 00 00 00 00 	movl	$0, 4(%esp)
     1b3:	c7 44 24 08 14 00 00 00 	movl	$20, 8(%esp)
     1bb:	e8 00 00 00 00 	calll	0 <_dx_op_bufferLoad_f32+0x30>
			000001bc:  IMAGE_REL_I386_REL32	_memset
     1c0:	8b 45 10 	movl	16(%ebp), %eax
     1c3:	8b 00 	movl	(%eax), %eax
     1c5:	8b 4d 14 	movl	20(%ebp), %ecx
     1c8:	8b 55 10 	movl	16(%ebp), %edx
     1cb:	0f af 4a 04 	imull	4(%edx), %ecx
     1cf:	01 c8 	addl	%ecx, %eax
     1d1:	8b 4d 18 	movl	24(%ebp), %ecx
     1d4:	f3 0f 10 04 08 	movss	(%eax,%ecx), %xmm0
     1d9:	f3 0f 11 06 	movss	%xmm0, (%esi)
     1dd:	89 f0 	movl	%esi, %eax
     1df:	83 c4 0c 	addl	$12, %esp
     1e2:	5e 	popl	%esi
     1e3:	5d 	popl	%ebp
     1e4:	c3 	retl
     1e5:	90 	nop
     1e6:	90 	nop
     1e7:	90 	nop
     1e8:	90 	nop
     1e9:	90 	nop
     1ea:	90 	nop
     1eb:	90 	nop
     1ec:	90 	nop
     1ed:	90 	nop
     1ee:	90 	nop
     1ef:	90 	nop

_dx_op_bufferLoad_i32:
     1f0:	55 	pushl	%ebp
     1f1:	89 e5 	movl	%esp, %ebp
     1f3:	56 	pushl	%esi
     1f4:	83 ec 0c 	subl	$12, %esp
     1f7:	8b 75 08 	movl	8(%ebp), %esi
     1fa:	8b 45 18 	movl	24(%ebp), %eax
     1fd:	8b 45 14 	movl	20(%ebp), %eax
     200:	8b 45 10 	movl	16(%ebp), %eax
     203:	8b 45 0c 	movl	12(%ebp), %eax
     206:	31 c0 	xorl	%eax, %eax
     208:	89 34 24 	movl	%esi, (%esp)
     20b:	c7 44 24 04 00 00 00 00 	movl	$0, 4(%esp)
     213:	c7 44 24 08 14 00 00 00 	movl	$20, 8(%esp)
     21b:	e8 00 00 00 00 	calll	0 <_dx_op_bufferLoad_i32+0x30>
			0000021c:  IMAGE_REL_I386_REL32	_memset
     220:	8b 45 10 	movl	16(%ebp), %eax
     223:	8b 00 	movl	(%eax), %eax
     225:	8b 4d 14 	movl	20(%ebp), %ecx
     228:	8b 55 10 	movl	16(%ebp), %edx
     22b:	0f af 4a 04 	imull	4(%edx), %ecx
     22f:	01 c8 	addl	%ecx, %eax
     231:	8b 4d 18 	movl	24(%ebp), %ecx
     234:	8b 04 08 	movl	(%eax,%ecx), %eax
     237:	89 06 	movl	%eax, (%esi)
     239:	89 f0 	movl	%esi, %eax
     23b:	83 c4 0c 	addl	$12, %esp
     23e:	5e 	popl	%esi
     23f:	5d 	popl	%ebp
     240:	c3 	retl
     241:	90 	nop
     242:	90 	nop
     243:	90 	nop
     244:	90 	nop
     245:	90 	nop
     246:	90 	nop
     247:	90 	nop
     248:	90 	nop
     249:	90 	nop
     24a:	90 	nop
     24b:	90 	nop
     24c:	90 	nop
     24d:	90 	nop
     24e:	90 	nop
     24f:	90 	nop

_dx_op_bufferStore_f32:
     250:	55 	pushl	%ebp
     251:	89 e5 	movl	%esp, %ebp
     253:	8a 45 28 	movb	40(%ebp), %al
     256:	f3 0f 10 45 24 	movss	36(%ebp), %xmm0
     25b:	f3 0f 10 45 20 	movss	32(%ebp), %xmm0
     260:	f3 0f 10 45 1c 	movss	28(%ebp), %xmm0
     265:	f3 0f 10 45 18 	movss	24(%ebp), %xmm0
     26a:	8b 45 14 	movl	20(%ebp), %eax
     26d:	8b 45 10 	movl	16(%ebp), %eax
     270:	8b 45 0c 	movl	12(%ebp), %eax
     273:	8b 45 08 	movl	8(%ebp), %eax
     276:	f3 0f 10 45 18 	movss	24(%ebp), %xmm0
     27b:	8b 45 0c 	movl	12(%ebp), %eax
     27e:	8b 00 	movl	(%eax), %eax
     280:	8b 4d 10 	movl	16(%ebp), %ecx
     283:	8b 55 0c 	movl	12(%ebp), %edx
     286:	0f af 4a 04 	imull	4(%edx), %ecx
     28a:	01 c8 	addl	%ecx, %eax
     28c:	8b 4d 14 	movl	20(%ebp), %ecx
     28f:	f3 0f 11 04 08 	movss	%xmm0, (%eax,%ecx)
     294:	5d 	popl	%ebp
     295:	c3 	retl
     296:	90 	nop
     297:	90 	nop
     298:	90 	nop
     299:	90 	nop
     29a:	90 	nop
     29b:	90 	nop
     29c:	90 	nop
     29d:	90 	nop
     29e:	90 	nop
     29f:	90 	nop

_dx_op_bufferStore_i32:
     2a0:	55 	pushl	%ebp
     2a1:	89 e5 	movl	%esp, %ebp
     2a3:	56 	pushl	%esi
     2a4:	8b 45 28 	movl	40(%ebp), %eax
     2a7:	8b 45 24 	movl	36(%ebp), %eax
     2aa:	8b 45 20 	movl	32(%ebp), %eax
     2ad:	8b 45 1c 	movl	28(%ebp), %eax
     2b0:	8b 45 18 	movl	24(%ebp), %eax
     2b3:	8b 45 14 	movl	20(%ebp), %eax
     2b6:	8b 45 10 	movl	16(%ebp), %eax
     2b9:	8b 45 0c 	movl	12(%ebp), %eax
     2bc:	8b 45 08 	movl	8(%ebp), %eax
     2bf:	8b 45 18 	movl	24(%ebp), %eax
     2c2:	8b 4d 0c 	movl	12(%ebp), %ecx
     2c5:	8b 09 	movl	(%ecx), %ecx
     2c7:	8b 55 10 	movl	16(%ebp), %edx
     2ca:	8b 75 0c 	movl	12(%ebp), %esi
     2cd:	0f af 56 04 	imull	4(%esi), %edx
     2d1:	01 d1 	addl	%edx, %ecx
     2d3:	8b 55 14 	movl	20(%ebp), %edx
     2d6:	89 04 11 	movl	%eax, (%ecx,%edx)
     2d9:	5e 	popl	%esi
     2da:	5d 	popl	%ebp
     2db:	c3 	retl
     2dc:	90 	nop
     2dd:	90 	nop
     2de:	90 	nop
     2df:	90 	nop

_dx_op_threadId_i32:
     2e0:	55 	pushl	%ebp
     2e1:	89 e5 	movl	%esp, %ebp
     2e3:	8b 45 0c 	movl	12(%ebp), %eax
     2e6:	8b 45 08 	movl	8(%ebp), %eax
     2e9:	a1 00 00 00 00 	movl	0, %eax
			000002ea:  IMAGE_REL_I386_DIR32	_g_tls
     2ee:	5d 	popl	%ebp
     2ef:	c3 	retl
