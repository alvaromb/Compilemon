	.file	"stdio.c"
	.section	.rodata
.LC0:
	.string	"%i"
.section	.text
.global _puti
.global _geti
.global _getc
.global _gets
.global _putc
.global _puts
.global _new_line
	
	.type	_puti, @function
_puti:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
	.size	_puti, .-_puti
.global _geti
	.type	_geti, @function
_geti:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	scanf
	leave
	ret
	.size	_geti, .-_geti
	.section	.rodata
.LC1:
	.string	"%1s"
	.text
.global _getc
	.type	_getc, @function
_getc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	scanf
	movl    stdin, %eax
	movl    %eax, (%esp)
	call    fflush
	leave
	ret
	.size	_getc, .-_getc

.global _putc
	.type	_putc, @function
_putc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al,%eax
	movl	%eax, (%esp)
	call	putchar
	leave
	ret
	.size	_putc, .-_putc
	.section	.rodata

.LC2:
	.string	"%s"
	.text
.global _puts
	.type	_puts, @function
_puts:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	leave
	ret
	.size	_puts, .-_puts

.global _gets
	.type	_gets, @function
_gets:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	scanf
	leave
	ret
	.size	_gets, .-_gets

.global _new_line
	.type	_new_line, @function
_new_line:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$10, (%esp)
	call	putchar
	leave
	ret

	.ident	"GCC: (Debian 4.3.3-13) 4.3.3"
	.section	.note.GNU-stack,"",@progbits
