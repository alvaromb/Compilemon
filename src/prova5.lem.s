.section .data
	_zero : .long 0
	_menysu : .long -1
	true : .long -1
	false : .long 0
	_cnt_19 : .long 6
	_cnt_20 : .long 1
	_cnt_22 : .long 1
	_cnt_24 : .long 5
	_cnt_27 : .long 1
	_cnt_29 : .long 5
	_cnt_32 : .long 5
	_cnt_36 : .long 6
	_cnt_38 : .long 4
	_cnt_40 : .long 5
	_cnt_44 : .long 6
	_cnt_46 : .long 4
	_cnt_48 : .long 5
	_cnt_52 : .long 6
	_cnt_54 : .long 4
	_cnt_56 : .long 0
	_cnt_58 : .long 1
	_cnt_61 : .long 1
	_cnt_64 : .long 1
	_cnt_67 : .long 1
	_cnt_69 : .long 5
	_cnt_72 : .long 1
	_cnt_74 : .long 5
	_cnt_77 : .long 1
	_cnt_79 : .long 5
	_cnt_82 : .long 5
	_cnt_86 : .long 6
	_cnt_88 : .long 4
	_cnt_90 : .long 5
	_cnt_94 : .long 6
	_cnt_96 : .long 4
	_cnt_98 : .long 5
	_cnt_102 : .long 6
	_cnt_104 : .long 4
	_cnt_106 : .long 5
	_cnt_110 : .long 6
	_cnt_112 : .long 4
	_cnt_119 : .long 1
	_cnt_122 : .long 1
	_cnt_125 : .long 1
	_cnt_128 : .long 2
	_cnt_130 : .long 5
	_cnt_133 : .long 1
	_cnt_136 : .long 5
	_cnt_140 : .long 6
	_cnt_142 : .long 4
	_cnt_144 : .long 5
	_cnt_148 : .long 6
	_cnt_150 : .long 4
	_cnt_152 : .long 5
	_cnt_156 : .long 6
	_cnt_158 : .long 4
	_cnt_161 : .long 5
	_cnt_165 : .long 6
	_cnt_167 : .long 4
	_cnt_169 : .long 1
	_cnt_172 : .long 1
	_cnt_175 : .long 1
	_cnt_177 : .long 5
	_cnt_180 : .long 1
	_cnt_182 : .long 5
	_cnt_185 : .long 5
	_cnt_189 : .long 6
	_cnt_191 : .long 4
	_cnt_193 : .long 1
	_cnt_196 : .long 1

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
	subl	$1036, %esp

	 # 	Copia
	 # 	LD es una constant  20, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -328(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-328(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -316(%ebp)

	 # 	Copia
	 # 	LD es una constant  22, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -336(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-336(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Etiqueta  2
_etq_2: nop

	 # 	Copia
	 # 	LD es una constant  24, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -344(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-344(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_38
	jmp	_etq_4
_etq_38: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -348(%ebp)

	 # 	Brancament Incondicional  5
	jmp	_etq_5

	 # 	Etiqueta  4
_etq_4: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -348(%ebp)

	 # 	Etiqueta  5
_etq_5: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-348(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_39
	jmp	_etq_3
_etq_39: nop

	 # 	Copia
	 # 	LD es una constant  27, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -356(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-356(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Etiqueta  6
_etq_6: nop

	 # 	Copia
	 # 	LD es una constant  29, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -364(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-364(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_40
	jmp	_etq_8
_etq_40: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -368(%ebp)

	 # 	Brancament Incondicional  9
	jmp	_etq_9

	 # 	Etiqueta  8
_etq_8: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -368(%ebp)

	 # 	Etiqueta  9
_etq_9: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-368(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_41
	jmp	_etq_7
_etq_41: nop

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  32, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -376(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-376(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -380(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-380(%ebp), %eax
	 # 	LD es una constant  36, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -384(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-384(%ebp), %eax
	 # 	LD es una constant  38, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -392(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-300(%ebp), %edi
	 # 	LD variable local
	movl	-392(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-316(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  40, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -408(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-408(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -412(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-412(%ebp), %eax
	 # 	LD es una constant  44, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -416(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-416(%ebp), %eax
	 # 	LD es una constant  46, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -424(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-200(%ebp), %edi
	 # 	LD variable local
	movl	-424(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-316(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  48, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -440(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-440(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -444(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-444(%ebp), %eax
	 # 	LD es una constant  52, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -448(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-448(%ebp), %eax
	 # 	LD es una constant  54, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -456(%ebp)

	 # 	Copia
	 # 	LD es una constant  56, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -472(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %edi
	 # 	LD variable local
	movl	-456(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-472(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  58, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -480(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-316(%ebp), %eax
	 # 	LD variable local
	movl	-480(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -484(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-484(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -316(%ebp)

	 # 	Copia
	 # 	LD es una constant  61, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -492(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-492(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -496(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-496(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Brancament Incondicional  6
	jmp	_etq_6

	 # 	Etiqueta  7
_etq_7: nop

	 # 	Copia
	 # 	LD es una constant  64, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -504(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-504(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -508(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-508(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Brancament Incondicional  2
	jmp	_etq_2

	 # 	Etiqueta  3
_etq_3: nop

	 # 	Copia
	 # 	LD es una constant  67, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -516(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-516(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Etiqueta  10
_etq_10: nop

	 # 	Copia
	 # 	LD es una constant  69, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -524(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-524(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_42
	jmp	_etq_12
_etq_42: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -528(%ebp)

	 # 	Brancament Incondicional  13
	jmp	_etq_13

	 # 	Etiqueta  12
_etq_12: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -528(%ebp)

	 # 	Etiqueta  13
_etq_13: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-528(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_43
	jmp	_etq_11
_etq_43: nop

	 # 	Copia
	 # 	LD es una constant  72, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -536(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-536(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Etiqueta  14
_etq_14: nop

	 # 	Copia
	 # 	LD es una constant  74, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -544(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-544(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_44
	jmp	_etq_16
_etq_44: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -548(%ebp)

	 # 	Brancament Incondicional  17
	jmp	_etq_17

	 # 	Etiqueta  16
_etq_16: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -548(%ebp)

	 # 	Etiqueta  17
_etq_17: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-548(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_45
	jmp	_etq_15
_etq_45: nop

	 # 	Copia
	 # 	LD es una constant  77, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -556(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-556(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -304(%ebp)

	 # 	Etiqueta  18
_etq_18: nop

	 # 	Copia
	 # 	LD es una constant  79, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -564(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-304(%ebp), %eax
	 # 	LD variable local
	movl	-564(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_46
	jmp	_etq_20
_etq_46: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -568(%ebp)

	 # 	Brancament Incondicional  21
	jmp	_etq_21

	 # 	Etiqueta  20
_etq_20: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -568(%ebp)

	 # 	Etiqueta  21
_etq_21: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-568(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_47
	jmp	_etq_19
_etq_47: nop

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  82, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -576(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-576(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -580(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-580(%ebp), %eax
	 # 	LD es una constant  86, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -584(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-584(%ebp), %eax
	 # 	LD es una constant  88, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -592(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  90, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -608(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-608(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -612(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-612(%ebp), %eax
	 # 	LD es una constant  94, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -616(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-616(%ebp), %eax
	 # 	LD es una constant  96, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -624(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  98, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -640(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-640(%ebp), %eax
	 # 	LD variable local
	movl	-304(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -644(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-644(%ebp), %eax
	 # 	LD es una constant  102, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -648(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-648(%ebp), %eax
	 # 	LD es una constant  104, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -656(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-304(%ebp), %eax
	 # 	LD es una constant  106, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -672(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-672(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -676(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-676(%ebp), %eax
	 # 	LD es una constant  110, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -680(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-680(%ebp), %eax
	 # 	LD es una constant  112, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -688(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-300(%ebp), %esi
	 # 	LD variable local
	movl	-656(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -700(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-200(%ebp), %esi
	 # 	LD variable local
	movl	-688(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -704(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-700(%ebp), %eax
	 # 	LD variable local
	movl	-704(%ebp), %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -708(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %esi
	 # 	LD variable local
	movl	-624(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -712(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-712(%ebp), %eax
	 # 	LD variable local
	movl	-708(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -716(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %edi
	 # 	LD variable local
	movl	-592(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-716(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  119, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -724(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-304(%ebp), %eax
	 # 	LD variable local
	movl	-724(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -728(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-728(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -304(%ebp)

	 # 	Brancament Incondicional  18
	jmp	_etq_18

	 # 	Etiqueta  19
_etq_19: nop

	 # 	Copia
	 # 	LD es una constant  122, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -736(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-736(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -740(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-740(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Brancament Incondicional  14
	jmp	_etq_14

	 # 	Etiqueta  15
_etq_15: nop

	 # 	Copia
	 # 	LD es una constant  125, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -748(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-748(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -752(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-752(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Brancament Incondicional  10
	jmp	_etq_10

	 # 	Etiqueta  11
_etq_11: nop

	 # 	Copia
	 # 	LD es una constant  128, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -760(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-760(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Etiqueta  22
_etq_22: nop

	 # 	Copia
	 # 	LD es una constant  130, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -768(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-768(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_48
	jmp	_etq_24
_etq_48: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -772(%ebp)

	 # 	Brancament Incondicional  25
	jmp	_etq_25

	 # 	Etiqueta  24
_etq_24: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -772(%ebp)

	 # 	Etiqueta  25
_etq_25: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-772(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_49
	jmp	_etq_23
_etq_49: nop

	 # 	Copia
	 # 	LD es una constant  133, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -780(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-780(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Etiqueta  26
_etq_26: nop
	 # 	IF Menor
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-312(%ebp), %ebx
	cmpl	%ebx, %eax
	jge	_etq_50
	jmp	_etq_28
_etq_50: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -784(%ebp)

	 # 	Brancament Incondicional  29
	jmp	_etq_29

	 # 	Etiqueta  28
_etq_28: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -784(%ebp)

	 # 	Etiqueta  29
_etq_29: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-784(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_51
	jmp	_etq_27
_etq_51: nop

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  136, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -792(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-792(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -796(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-796(%ebp), %eax
	 # 	LD es una constant  140, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -800(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-800(%ebp), %eax
	 # 	LD es una constant  142, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -808(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %esi
	 # 	LD variable local
	movl	-808(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -316(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  144, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -824(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-824(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -828(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-828(%ebp), %eax
	 # 	LD es una constant  148, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -832(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-832(%ebp), %eax
	 # 	LD es una constant  150, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -840(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD es una constant  152, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -856(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-856(%ebp), %eax
	 # 	LD variable local
	movl	-312(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -860(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-860(%ebp), %eax
	 # 	LD es una constant  156, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -864(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-864(%ebp), %eax
	 # 	LD es una constant  158, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -872(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %esi
	 # 	LD variable local
	movl	-872(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -884(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %edi
	 # 	LD variable local
	movl	-840(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-884(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Producte
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD es una constant  161, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -892(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-892(%ebp), %eax
	 # 	LD variable local
	movl	-312(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -896(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-896(%ebp), %eax
	 # 	LD es una constant  165, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -900(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-900(%ebp), %eax
	 # 	LD es una constant  167, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -908(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %edi
	 # 	LD variable local
	movl	-908(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-316(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  169, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -924(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-924(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -928(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-928(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Brancament Incondicional  26
	jmp	_etq_26

	 # 	Etiqueta  27
_etq_27: nop

	 # 	Copia
	 # 	LD es una constant  172, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -936(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-936(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -940(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-940(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Brancament Incondicional  22
	jmp	_etq_22

	 # 	Etiqueta  23
_etq_23: nop

	 # 	Copia
	 # 	LD es una constant  175, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -948(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-948(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Etiqueta  30
_etq_30: nop

	 # 	Copia
	 # 	LD es una constant  177, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -956(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-956(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_52
	jmp	_etq_32
_etq_52: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -960(%ebp)

	 # 	Brancament Incondicional  33
	jmp	_etq_33

	 # 	Etiqueta  32
_etq_32: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -960(%ebp)

	 # 	Etiqueta  33
_etq_33: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-960(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_53
	jmp	_etq_31
_etq_53: nop

	 # 	Copia
	 # 	LD es una constant  180, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -968(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-968(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Etiqueta  34
_etq_34: nop

	 # 	Copia
	 # 	LD es una constant  182, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -976(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-976(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_54
	jmp	_etq_36
_etq_54: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -980(%ebp)

	 # 	Brancament Incondicional  37
	jmp	_etq_37

	 # 	Etiqueta  36
_etq_36: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -980(%ebp)

	 # 	Etiqueta  37
_etq_37: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-980(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_55
	jmp	_etq_35
_etq_55: nop

	 # 	Producte
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  185, %ebx
	movl	$5, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -988(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-988(%ebp), %eax
	 # 	LD variable local
	movl	-308(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -992(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-992(%ebp), %eax
	 # 	LD es una constant  189, %ebx
	movl	$6, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -996(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-996(%ebp), %eax
	 # 	LD es una constant  191, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1004(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-100(%ebp), %eax
	 # 	LD variable local
	movl	-1004(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  193, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1020(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-308(%ebp), %eax
	 # 	LD variable local
	movl	-1020(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1024(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1024(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -308(%ebp)

	 # 	Brancament Incondicional  34
	jmp	_etq_34

	 # 	Etiqueta  35
_etq_35: nop

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  196, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1032(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD variable local
	movl	-1032(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1036(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1036(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Brancament Incondicional  30
	jmp	_etq_30

	 # 	Etiqueta  31
_etq_31: nop

	 # 	Return  9
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	4(%edi)
	ret
