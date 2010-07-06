.section .data
	_zero : .long 0
	_menysu : .long -1
	true : .long -1
	false : .long 0
	_cnt_14 : .long -2
	_cnt_15 : .long 2
	_cnt_18 : .long 5
	_cnt_22 : .long -2
	_cnt_24 : .long 4
	_cnt_26 : .long 7
	_cnt_28 : .long 1
	_cnt_31 : .long 2
	_cnt_34 : .long 5
	_cnt_38 : .long -2
	_cnt_40 : .long 4
	_cnt_42 : .long 1

.section .bss
	.comm DISP, 100

.section .text
	.global main

main:
	jmp _etq_1

	 # 	Etiqueta  1
_etq_1: nop

	 # 	Preambul  9
	movl	$DISP, %esi
	pushl	4(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 4(%esi)
	subl	$160, %esp

	 # 	Copia
	 # 	LD es una constant  15, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -48(%ebp)

	 # 	Negacio
	xorl	%eax, %eax
	 # 	LD variable local
	movl	-48(%ebp), %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -52(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-52(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Etiqueta  2
_etq_2: nop

	 # 	Copia
	 # 	LD es una constant  18, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -60(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD variable local
	movl	-60(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_10
	jmp	_etq_4
_etq_10: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -64(%ebp)

	 # 	Brancament Incondicional  5
	jmp	_etq_5

	 # 	Etiqueta  4
_etq_4: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -64(%ebp)

	 # 	Etiqueta  5
_etq_5: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-64(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_11
	jmp	_etq_3
_etq_11: nop

	 # 	Resta
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD es una constant  22, %ebx
	movl	$-2, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -68(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD es una constant  24, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -76(%ebp)

	 # 	Copia
	 # 	LD es una constant  26, %eax
	movl	$7, %eax
	 # 	ST a una variable local
	movl	%eax, -92(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-32(%ebp), %edi
	 # 	LD variable local
	movl	-76(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-92(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  28, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -100(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD variable local
	movl	-100(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -104(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-104(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Brancament Incondicional  2
	jmp	_etq_2

	 # 	Etiqueta  3
_etq_3: nop

	 # 	Copia
	 # 	LD es una constant  31, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -112(%ebp)

	 # 	Negacio
	xorl	%eax, %eax
	 # 	LD variable local
	movl	-112(%ebp), %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -116(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Etiqueta  6
_etq_6: nop

	 # 	Copia
	 # 	LD es una constant  34, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -124(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD variable local
	movl	-124(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_12
	jmp	_etq_8
_etq_12: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Brancament Incondicional  9
	jmp	_etq_9

	 # 	Etiqueta  8
_etq_8: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Etiqueta  9
_etq_9: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-128(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_13
	jmp	_etq_7
_etq_13: nop

	 # 	Resta
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD es una constant  38, %ebx
	movl	$-2, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -132(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-132(%ebp), %eax
	 # 	LD es una constant  40, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -140(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-32(%ebp), %eax
	 # 	LD variable local
	movl	-140(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  42, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -156(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD variable local
	movl	-156(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -160(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-160(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Brancament Incondicional  6
	jmp	_etq_6

	 # 	Etiqueta  7
_etq_7: nop

	 # 	Return  9
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	4(%edi)
	ret
