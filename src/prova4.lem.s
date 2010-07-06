.section .data
	_zero : .long 0
	_menysu : .long -1
	true : .long -1
	false : .long 0
	v_len : .long 20
	max : .long 251
	_cnt_32 : .long 0
	_cnt_33 : .long 0
	_cnt_35 : .long 19
	_cnt_40 : .long 0
	_cnt_42 : .long 4
	_cnt_44 : .long 50
	_cnt_50 : .long 1
	_cnt_53 : .long 0
	_cnt_55 : .long 0
	_cnt_57 : .asciz ",  "
	_cnt_62 : .long 0
	_cnt_64 : .long 4
	_cnt_66 : .long 1
	_cnt_71 : .long 0
	_cnt_73 : .long 4
	_cnt_77 : .long 0
	_cnt_79 : .long 4
	_cnt_83 : .long 0
	_cnt_85 : .long 4
	_cnt_90 : .long 0
	_cnt_92 : .long 4
	_cnt_100 : .long 2
	_cnt_104 : .long 0
	_cnt_106 : .long 4
	_cnt_110 : .long 1
	_cnt_116 : .long 0
	_cnt_118 : .long 4
	_cnt_122 : .long 1
	_cnt_125 : .long 1
	_cnt_132 : .long 1
	_cnt_137 : .long 1
	_cnt_141 : .asciz "vector desordenat"
	_cnt_143 : .long 0
	_cnt_146 : .asciz "vector ordenat"

.section .bss
	.comm DISP, 100

.section .text
	.global main

main:
	jmp _etq_1

	 # 	Etiqueta  2
_etq_2: nop

	 # 	Preambul  10
	movl	$DISP, %esi
	pushl	8(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 8(%esi)
	subl	$96, %esp

	 # 	Copia
	 # 	LD es una constant  33, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -24(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-24(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Copia
	 # 	LD es una constant  35, %eax
	movl	$19, %eax
	 # 	ST a una variable local
	movl	%eax, -32(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-32(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -16(%ebp)

	 # 	Etiqueta  3
_etq_3: nop

	 # 	Copia
	 # 	LD es una constant  12, %eax
	movl	$20, %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-36(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_31
	jmp	_etq_5
_etq_31: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -40(%ebp)

	 # 	Brancament Incondicional  6
	jmp	_etq_6

	 # 	Etiqueta  5
_etq_5: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -40(%ebp)

	 # 	Etiqueta  6
_etq_6: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-40(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_32
	jmp	_etq_4
_etq_32: nop

	 # 	Resta
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD es una constant  40, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -44(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-44(%ebp), %eax
	 # 	LD es una constant  42, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -52(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %edi
	 # 	LD variable local
	movl	-52(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-16(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  44, %eax
	movl	$50, %eax
	 # 	ST a una variable local
	movl	%eax, -68(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-16(%ebp), %eax
	 # 	LD variable local
	movl	-68(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -72(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-72(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -16(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-16(%ebp), %eax
	 # 	LD variable local
	movl	-16(%ebp), %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -76(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-76(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -16(%ebp)

	 # 	Copia
	 # 	LD es una constant  17, %eax
	movl	$251, %eax
	 # 	ST a una variable local
	movl	%eax, -80(%ebp)

	 # 	Modul
	 # 	LD variable local
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	 # 	LD variable local
	movl	-80(%ebp), %ebx
	idivl	%ebx
	 # 	ST a una variable local
	movl	%edx, -84(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-84(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -16(%ebp)

	 # 	Copia
	 # 	LD es una constant  50, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -92(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-92(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -96(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-96(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-16(%ebp), %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Brancament Incondicional  3
	jmp	_etq_3

	 # 	Etiqueta  4
_etq_4: nop

	 # 	Return  10
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	8(%edi)
	ret

	 # 	Etiqueta  7
_etq_7: nop

	 # 	Preambul  11
	movl	$DISP, %esi
	pushl	8(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 8(%esi)
	subl	$76, %esp

	 # 	Copia
	 # 	LD es una constant  53, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -20(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-20(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Copia
	 # 	LD es una constant  55, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -28(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-28(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -8(%ebp)

	 # 	Copia
	 # 	LD es una constant string 57, %eax
	movl	$_cnt_57, %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -12(%ebp)

	 # 	Etiqueta  8
_etq_8: nop

	 # 	Copia
	 # 	LD es una constant  12, %eax
	movl	$20, %eax
	 # 	ST a una variable local
	movl	%eax, -40(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-40(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_33
	jmp	_etq_10
_etq_33: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -44(%ebp)

	 # 	Brancament Incondicional  11
	jmp	_etq_11

	 # 	Etiqueta  10
_etq_10: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -44(%ebp)

	 # 	Etiqueta  11
_etq_11: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-44(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_34
	jmp	_etq_9
_etq_34: nop

	 # 	Resta
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD es una constant  62, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -48(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-48(%ebp), %eax
	 # 	LD es una constant  64, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -56(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb parametre local
	movl	12(%ebp), %esi
	 # 	LD variable local
	movl	-56(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -8(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-8(%ebp), %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-12(%ebp), %eax
	pushl	%eax

	 # 	Call  6
	 # 	Crida a 'gets' o 'puts'
	popl	%eax
	movl	(%eax), %eax
	pushl	%eax
	call	_puts
	addl	$4, %esp

	 # 	Copia
	 # 	LD es una constant  66, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -72(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-72(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -76(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-76(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Brancament Incondicional  8
	jmp	_etq_8

	 # 	Etiqueta  9
_etq_9: nop

	 # 	Return  11
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	8(%edi)
	ret

	 # 	Etiqueta  12
_etq_12: nop

	 # 	Preambul  12
	movl	$DISP, %esi
	pushl	8(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 8(%esi)
	subl	$104, %esp

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -8(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD es una constant  71, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -12(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-12(%ebp), %eax
	 # 	LD es una constant  73, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -20(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %esi
	 # 	LD variable local
	movl	-20(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -32(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-32(%ebp), %eax
	 # 	LD es una constant  77, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-36(%ebp), %eax
	 # 	LD es una constant  79, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -44(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -56(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-56(%ebp), %eax
	 # 	LD es una constant  83, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -60(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-60(%ebp), %eax
	 # 	LD es una constant  85, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -68(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %esi
	 # 	LD variable local
	movl	-68(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -80(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %edi
	 # 	LD variable local
	movl	-44(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-80(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -84(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-84(%ebp), %eax
	 # 	LD es una constant  90, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -88(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-88(%ebp), %eax
	 # 	LD es una constant  92, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -96(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %edi
	 # 	LD variable local
	movl	-96(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-4(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Return  12
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	8(%edi)
	ret

	 # 	Etiqueta  13
_etq_13: nop

	 # 	Preambul  13
	movl	$DISP, %esi
	pushl	8(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 8(%esi)
	subl	$204, %esp

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -20(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -24(%ebp)
	 # 	IF Menor
	 # 	LD variable local
	movl	-20(%ebp), %eax
	 # 	LD variable local
	movl	-24(%ebp), %ebx
	cmpl	%ebx, %eax
	jge	_etq_35
	jmp	_etq_15
_etq_35: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -28(%ebp)

	 # 	Brancament Incondicional  16
	jmp	_etq_16

	 # 	Etiqueta  15
_etq_15: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -28(%ebp)

	 # 	Etiqueta  16
_etq_16: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-28(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_36
	jmp	_etq_14
_etq_36: nop

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -32(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -36(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-32(%ebp), %eax
	 # 	LD variable local
	movl	-36(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -40(%ebp)

	 # 	Copia
	 # 	LD es una constant  100, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -48(%ebp)

	 # 	Divisio
	 # 	LD variable local
	movl	-40(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	 # 	LD variable local
	movl	-48(%ebp), %ebx
	idivl	%ebx
	 # 	ST a una variable local
	movl	%eax, -52(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-52(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -16(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-16(%ebp), %eax
	 # 	LD es una constant  104, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -56(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-56(%ebp), %eax
	 # 	LD es una constant  106, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -64(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %esi
	 # 	LD variable local
	movl	-64(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -12(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -76(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-16(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-76(%ebp), %eax
	pushl	%eax

	 # 	Call  12
	call	_etq_12
	addl	$8, %esp

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -80(%ebp)

	 # 	Copia
	 # 	LD es una constant  110, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -88(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-80(%ebp), %eax
	 # 	LD variable local
	movl	-88(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -92(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-92(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -96(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-96(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -8(%ebp)

	 # 	Etiqueta  17
_etq_17: nop
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-8(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_37
	jmp	_etq_19
_etq_37: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -100(%ebp)

	 # 	Brancament Incondicional  20
	jmp	_etq_20

	 # 	Etiqueta  19
_etq_19: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -100(%ebp)

	 # 	Etiqueta  20
_etq_20: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-100(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_38
	jmp	_etq_18
_etq_38: nop

	 # 	Resta
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD es una constant  116, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -104(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-104(%ebp), %eax
	 # 	LD es una constant  118, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -112(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable global
	movl	$DISP, %esi
	movl	4(%esi), %esi
	leal	-104(%esi), %esi
	 # 	LD variable local
	movl	-112(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -124(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-124(%ebp), %eax
	 # 	LD variable local
	movl	-12(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_39
	jmp	_etq_23
_etq_39: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Brancament Incondicional  24
	jmp	_etq_24

	 # 	Etiqueta  23
_etq_23: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Etiqueta  24
_etq_24: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-128(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_40
	jmp	_etq_21
_etq_40: nop

	 # 	Copia
	 # 	LD es una constant  122, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -136(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-4(%ebp), %eax
	 # 	LD variable local
	movl	-136(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -140(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-140(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -4(%ebp)

	 # 	Brancament Incondicional  22
	jmp	_etq_22

	 # 	Etiqueta  21
_etq_21: nop

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-8(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-4(%ebp), %eax
	pushl	%eax

	 # 	Call  12
	call	_etq_12
	addl	$8, %esp

	 # 	Copia
	 # 	LD es una constant  125, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -148(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD variable local
	movl	-148(%ebp), %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -152(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-152(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -8(%ebp)

	 # 	Etiqueta  22
_etq_22: nop

	 # 	Brancament Incondicional  17
	jmp	_etq_17

	 # 	Etiqueta  18
_etq_18: nop

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -156(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-8(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-156(%ebp), %eax
	pushl	%eax

	 # 	Call  12
	call	_etq_12
	addl	$8, %esp

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -160(%ebp)
	 # 	IF Major
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD variable local
	movl	-160(%ebp), %ebx
	cmpl	%ebx, %eax
	jle	_etq_41
	jmp	_etq_26
_etq_41: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -164(%ebp)

	 # 	Brancament Incondicional  27
	jmp	_etq_27

	 # 	Etiqueta  26
_etq_26: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -164(%ebp)

	 # 	Etiqueta  27
_etq_27: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-164(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_42
	jmp	_etq_25
_etq_42: nop

	 # 	Copia
	 # 	LD parametre local
	movl	 12(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -168(%ebp)

	 # 	Copia
	 # 	LD es una constant  132, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -176(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD variable local
	movl	-176(%ebp), %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -180(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-180(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-168(%ebp), %eax
	pushl	%eax

	 # 	Call  13
	call	_etq_13
	addl	$8, %esp

	 # 	Etiqueta  25
_etq_25: nop

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -184(%ebp)
	 # 	IF Menor
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD variable local
	movl	-184(%ebp), %ebx
	cmpl	%ebx, %eax
	jge	_etq_43
	jmp	_etq_29
_etq_43: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -188(%ebp)

	 # 	Brancament Incondicional  30
	jmp	_etq_30

	 # 	Etiqueta  29
_etq_29: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -188(%ebp)

	 # 	Etiqueta  30
_etq_30: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-188(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_44
	jmp	_etq_28
_etq_44: nop

	 # 	Copia
	 # 	LD es una constant  137, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -196(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-8(%ebp), %eax
	 # 	LD variable local
	movl	-196(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -200(%ebp)

	 # 	Copia
	 # 	LD parametre local
	movl	 16(%ebp), %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -204(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-204(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-200(%ebp), %eax
	pushl	%eax

	 # 	Call  13
	call	_etq_13
	addl	$8, %esp

	 # 	Etiqueta  28
_etq_28: nop

	 # 	Etiqueta  14
_etq_14: nop

	 # 	Return  13
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	8(%edi)
	ret

	 # 	Etiqueta  1
_etq_1: nop

	 # 	Preambul  9
	movl	$DISP, %esi
	pushl	4(%esi)
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, 4(%esi)
	subl	$140, %esp

	 # 	Call  10
	call	_etq_2
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant string 141, %eax
	movl	$_cnt_141, %eax
	 # 	ST a una variable local
	movl	%eax, -120(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-120(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -108(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %eax
	pushl	%eax

	 # 	Call  6
	 # 	Crida a 'gets' o 'puts'
	popl	%eax
	movl	(%eax), %eax
	pushl	%eax
	call	_puts
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-104(%ebp), %eax
	pushl	%eax

	 # 	Call  11
	call	_etq_7
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  143, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Copia
	 # 	LD es una constant  12, %eax
	movl	$20, %eax
	 # 	ST a una variable local
	movl	%eax, -132(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-132(%ebp), %eax
	pushl	%eax

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-128(%ebp), %eax
	pushl	%eax

	 # 	Call  13
	call	_etq_13
	addl	$8, %esp

	 # 	Copia
	 # 	LD es una constant string 146, %eax
	movl	$_cnt_146, %eax
	 # 	ST a una variable local
	movl	%eax, -140(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-140(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -108(%ebp)

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %eax
	pushl	%eax

	 # 	Call  6
	 # 	Crida a 'gets' o 'puts'
	popl	%eax
	movl	(%eax), %eax
	pushl	%eax
	call	_puts
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Parametre Simple
	 # 	LDADDR amb variable local
	leal	-104(%ebp), %eax
	pushl	%eax

	 # 	Call  11
	call	_etq_7
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Return  9
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	4(%edi)
	ret
