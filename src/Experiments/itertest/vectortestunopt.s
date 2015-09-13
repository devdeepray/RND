	.file	"vectortest.cpp"
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.text
	.globl	_Z16getCurrentTimeUSv
	.type	_Z16getCurrentTimeUSv, @function
_Z16getCurrentTimeUSv:
.LFB1288:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday
	movq	-32(%rbp), %rax
	imulq	$1000000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L3
	call	__stack_chk_fail
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1288:
	.size	_Z16getCurrentTimeUSv, .-_Z16getCurrentTimeUSv
	.section	.rodata
.LC0:
	.string	"Case 1: "
.LC1:
	.string	"Case 2: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB1289:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8256, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -8232(%rbp)
	movl	$0, -8252(%rbp)
	jmp	.L5
.L8:
	call	_Z16getCurrentTimeUSv
	subq	%rax, -8232(%rbp)
	movl	$0, -8248(%rbp)
	jmp	.L6
.L7:
	movl	-8248(%rbp), %eax
	cltq
	movl	-8248(%rbp), %edx
	movl	%edx, -8208(%rbp,%rax,4)
	addl	$1, -8248(%rbp)
.L6:
	cmpl	$2047, -8248(%rbp)
	jle	.L7
	call	_Z16getCurrentTimeUSv
	addq	%rax, -8232(%rbp)
	addl	$1, -8252(%rbp)
.L5:
	cmpl	$99, -8252(%rbp)
	jle	.L8
	movl	$.LC0, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdx
	movq	-8232(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEl
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	$0, -8232(%rbp)
	movl	$0, -8244(%rbp)
	jmp	.L9
.L12:
	leaq	-8208(%rbp), %rax
	movq	%rax, -8224(%rbp)
	call	_Z16getCurrentTimeUSv
	subq	%rax, -8232(%rbp)
	movl	$0, -8240(%rbp)
	jmp	.L10
.L11:
	movq	-8224(%rbp), %rax
	movl	-8240(%rbp), %edx
	movl	%edx, (%rax)
	addq	$4, -8224(%rbp)
	addl	$1, -8240(%rbp)
.L10:
	cmpl	$2047, -8240(%rbp)
	jle	.L11
	call	_Z16getCurrentTimeUSv
	addq	%rax, -8232(%rbp)
	addl	$1, -8244(%rbp)
.L9:
	cmpl	$99, -8244(%rbp)
	jle	.L12
	movq	$0, -8216(%rbp)
	movl	$0, -8236(%rbp)
	jmp	.L13
.L14:
	movl	-8236(%rbp), %eax
	cltq
	movl	-8208(%rbp,%rax,4), %eax
	cltq
	addq	%rax, -8216(%rbp)
	addl	$1, -8236(%rbp)
.L13:
	cmpl	$2047, -8236(%rbp)
	jle	.L14
	movl	$.LC1, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdx
	movq	-8232(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEl
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-8216(%rbp), %rax
	movq	%rax, %rsi
	movl	$_ZSt4cout, %edi
	call	_ZNSolsEl
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L16
	call	__stack_chk_fail
.L16:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1289:
	.size	main, .-main
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB1303:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L17
	cmpl	$65535, -8(%rbp)
	jne	.L17
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	call	__cxa_atexit
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1303:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I__Z16getCurrentTimeUSv, @function
_GLOBAL__sub_I__Z16getCurrentTimeUSv:
.LFB1304:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1304:
	.size	_GLOBAL__sub_I__Z16getCurrentTimeUSv, .-_GLOBAL__sub_I__Z16getCurrentTimeUSv
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z16getCurrentTimeUSv
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 4.9.2-10ubuntu13) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
