	.file	"vectortest.cpp"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	_Z16getCurrentTimeUSv
	.type	_Z16getCurrentTimeUSv, @function
_Z16getCurrentTimeUSv:
.LFB1315:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	xorl	%esi, %esi
	movq	%rsp, %rdi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	gettimeofday
	imulq	$1000000, (%rsp), %rax
	addq	8(%rsp), %rax
	movq	24(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L5
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE1315:
	.size	_Z16getCurrentTimeUSv, .-_Z16getCurrentTimeUSv
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Case 1: "
.LC4:
	.string	"Case 2: "
	.section	.text.unlikely
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB1316:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	$100, %r13d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebp, %ebp
	subq	$8264, %rsp
	.cfi_def_cfa_offset 8304
	movq	%fs:40, %rax
	movq	%rax, 8248(%rsp)
	xorl	%eax, %eax
	movdqa	.LC2(%rip), %xmm1
	leaq	8240(%rsp), %rbx
	.p2align 4,,10
	.p2align 3
.L8:
	leaq	32(%rsp), %rdi
	xorl	%esi, %esi
	leaq	48(%rsp), %r12
	movaps	%xmm1, (%rsp)
	call	gettimeofday
	imulq	$1000000, 32(%rsp), %rax
	movdqa	.LC1(%rip), %xmm0
	movdqa	(%rsp), %xmm1
	addq	40(%rsp), %rax
	subq	%rax, %rbp
	movq	%r12, %rax
	.p2align 4,,10
	.p2align 3
.L7:
	movaps	%xmm0, (%rax)
	paddd	%xmm1, %xmm0
	addq	$16, %rax
	cmpq	%rbx, %rax
	jne	.L7
	leaq	32(%rsp), %rdi
	xorl	%esi, %esi
	movaps	%xmm1, (%rsp)
	call	gettimeofday
	imulq	$1000000, 32(%rsp), %rax
	movdqa	(%rsp), %xmm1
	addq	40(%rsp), %rax
	addq	%rax, %rbp
	subl	$1, %r13d
	jne	.L8
	movl	$.LC3, %esi
	movl	$_ZSt4cout, %edi
	movl	$100, %r13d
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rbp, %rsi
	movq	%rax, %rdi
	xorl	%ebp, %ebp
	call	_ZNSo9_M_insertIlEERSoT_
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	movdqa	.LC1(%rip), %xmm6
	movaps	%xmm6, 16(%rsp)
	movdqa	(%rsp), %xmm1
	.p2align 4,,10
	.p2align 3
.L10:
	leaq	32(%rsp), %rdi
	xorl	%esi, %esi
	movaps	%xmm1, (%rsp)
	call	gettimeofday
	imulq	$1000000, 32(%rsp), %rax
	movdqa	16(%rsp), %xmm0
	movdqa	(%rsp), %xmm1
	addq	40(%rsp), %rax
	subq	%rax, %rbp
	leaq	48(%rsp), %rax
	.p2align 4,,10
	.p2align 3
.L9:
	movaps	%xmm0, (%rax)
	paddd	%xmm1, %xmm0
	addq	$16, %rax
	cmpq	%rbx, %rax
	jne	.L9
	leaq	32(%rsp), %rdi
	xorl	%esi, %esi
	movaps	%xmm1, (%rsp)
	call	gettimeofday
	imulq	$1000000, 32(%rsp), %rax
	movdqa	(%rsp), %xmm1
	addq	40(%rsp), %rax
	addq	%rax, %rbp
	subl	$1, %r13d
	jne	.L10
	pxor	%xmm1, %xmm1
	pxor	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L11:
	movdqa	(%r12), %xmm0
	movdqa	%xmm4, %xmm2
	addq	$16, %r12
	pcmpgtd	%xmm0, %xmm2
	movdqa	%xmm0, %xmm3
	cmpq	%rbx, %r12
	punpckldq	%xmm2, %xmm3
	punpckhdq	%xmm2, %xmm0
	paddq	%xmm3, %xmm1
	paddq	%xmm0, %xmm1
	jne	.L11
	movdqa	%xmm1, %xmm5
	movl	$.LC4, %esi
	movl	$_ZSt4cout, %edi
	psrldq	$8, %xmm5
	movaps	%xmm1, 16(%rsp)
	movaps	%xmm5, (%rsp)
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	_ZNSo9_M_insertIlEERSoT_
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	movdqa	16(%rsp), %xmm1
	movl	$_ZSt4cout, %edi
	movdqa	(%rsp), %xmm0
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rsi
	call	_ZNSo9_M_insertIlEERSoT_
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	xorl	%eax, %eax
	movq	8248(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L19
	addq	$8264, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE1316:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE5:
	.section	.text.startup
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.section	.text.startup
.LHOTB6:
	.p2align 4,,15
	.type	_GLOBAL__sub_I__Z16getCurrentTimeUSv, @function
_GLOBAL__sub_I__Z16getCurrentTimeUSv:
.LFB1331:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	__cxa_atexit
	.cfi_endproc
.LFE1331:
	.size	_GLOBAL__sub_I__Z16getCurrentTimeUSv, .-_GLOBAL__sub_I__Z16getCurrentTimeUSv
	.section	.text.unlikely
.LCOLDE6:
	.section	.text.startup
.LHOTE6:
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z16getCurrentTimeUSv
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC2:
	.long	4
	.long	4
	.long	4
	.long	4
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 4.9.2-10ubuntu13) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
