.section .data
	_zero : .long 0
	_menysu : .long -1
	true : .long -1
	false : .long 0
	_cnt_14 : .long 0
	_cnt_15 : .long 0
	_cnt_18 : .long 0
	_cnt_20 : .long 4
	_cnt_22 : .long 32
	_cnt_24 : .ascii "110"
	_cnt_26 : .long 0
	_cnt_29 : .long 0
	_cnt_31 : .long 4
	_cnt_33 : .long 48
	_cnt_35 : .asciz "Sencer"
	_cnt_37 : .long 0
	_cnt_40 : .long 0
	_cnt_42 : .long 4
	_cnt_44 : .long 0
	_cnt_46 : .long 0
	_cnt_48 : .long 0
	_cnt_51 : .long 0
	_cnt_53 : .long 4
	_cnt_55 : .long 16
	_cnt_57 : .long 0
	_cnt_59 : .long 1
	_cnt_62 : .long 0
	_cnt_64 : .long 4
	_cnt_66 : .long 32
	_cnt_68 : .ascii "98"
	_cnt_70 : .long 1
	_cnt_73 : .long 0
	_cnt_75 : .long 4
	_cnt_77 : .long 48
	_cnt_79 : .asciz "Boolea"
	_cnt_81 : .long 1
	_cnt_84 : .long 0
	_cnt_86 : .long 4
	_cnt_88 : .long 0
	_cnt_90 : .long 1
	_cnt_93 : .long 1
	_cnt_96 : .long 0
	_cnt_98 : .long 4
	_cnt_100 : .long 16
	_cnt_102 : .long 0
	_cnt_104 : .long 2
	_cnt_107 : .long 0
	_cnt_109 : .long 4
	_cnt_111 : .long 32
	_cnt_113 : .ascii "99"
	_cnt_115 : .long 2
	_cnt_118 : .long 0
	_cnt_120 : .long 4
	_cnt_122 : .long 48
	_cnt_124 : .asciz "Caracter"
	_cnt_126 : .long 2
	_cnt_129 : .long 0
	_cnt_131 : .long 4
	_cnt_133 : .long 0
	_cnt_135 : .long 1
	_cnt_137 : .long 2
	_cnt_140 : .long 0
	_cnt_142 : .long 4
	_cnt_144 : .long 16
	_cnt_146 : .long 4
	_cnt_148 : .long 3
	_cnt_151 : .long 0
	_cnt_153 : .long 4
	_cnt_155 : .long 32
	_cnt_157 : .ascii "115"
	_cnt_159 : .long 3
	_cnt_162 : .long 0
	_cnt_164 : .long 4
	_cnt_166 : .long 48
	_cnt_168 : .asciz "String"
	_cnt_170 : .long 3
	_cnt_173 : .long 0
	_cnt_175 : .long 4
	_cnt_177 : .long 0
	_cnt_179 : .long 4
	_cnt_181 : .long 3
	_cnt_184 : .long 0
	_cnt_186 : .long 4
	_cnt_188 : .long 16
	_cnt_190 : .long 256
	_cnt_192 : .long 0
	_cnt_194 : .long 3
	_cnt_198 : .long 0
	_cnt_200 : .long 4
	_cnt_202 : .long 32
	_cnt_205 : .long 0
	_cnt_207 : .long 4
	_cnt_209 : .long 48
	_cnt_212 : .long 0
	_cnt_214 : .long 4
	_cnt_216 : .long 0
	_cnt_219 : .long 0
	_cnt_221 : .long 4
	_cnt_223 : .long 16
	_cnt_225 : .long 1

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
	subl	$924, %esp

	 # 	Copia
	 # 	LD es una constant  15, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -80(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-80(%ebp), %eax
	 # 	LD es una constant  18, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -84(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-84(%ebp), %eax
	 # 	LD es una constant  20, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -92(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-92(%ebp), %eax
	 # 	LD es una constant  22, %ebx
	movl	$32, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -108(%ebp)

	 # 	Copia
	 # 	LD es una constant  24, %eax
	movl	$110, %eax
	 # 	ST a una variable local
	movl	%eax, -116(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-108(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-116(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  26, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -124(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-124(%ebp), %eax
	 # 	LD es una constant  29, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -128(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-128(%ebp), %eax
	 # 	LD es una constant  31, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -136(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-136(%ebp), %eax
	 # 	LD es una constant  33, %ebx
	movl	$48, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -152(%ebp)

	 # 	Copia
	 # 	LD es una constant string 35, %eax
	movl	$_cnt_35, %eax
	 # 	ST a una variable local
	movl	%eax, -160(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-152(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-160(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  37, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -168(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-168(%ebp), %eax
	 # 	LD es una constant  40, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -172(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-172(%ebp), %eax
	 # 	LD es una constant  42, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -180(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-180(%ebp), %eax
	 # 	LD es una constant  44, %ebx
	movl	$0, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -196(%ebp)

	 # 	Copia
	 # 	LD es una constant  46, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -204(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-196(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-204(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  48, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -212(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-212(%ebp), %eax
	 # 	LD es una constant  51, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -216(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-216(%ebp), %eax
	 # 	LD es una constant  53, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -224(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-224(%ebp), %eax
	 # 	LD es una constant  55, %ebx
	movl	$16, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -240(%ebp)

	 # 	Copia
	 # 	LD es una constant  57, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -248(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-240(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-248(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  59, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -256(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-256(%ebp), %eax
	 # 	LD es una constant  62, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -260(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-260(%ebp), %eax
	 # 	LD es una constant  64, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -268(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-268(%ebp), %eax
	 # 	LD es una constant  66, %ebx
	movl	$32, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -284(%ebp)

	 # 	Copia
	 # 	LD es una constant  68, %eax
	movl	$98, %eax
	 # 	ST a una variable local
	movl	%eax, -292(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-284(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-292(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  70, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -300(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-300(%ebp), %eax
	 # 	LD es una constant  73, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -304(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-304(%ebp), %eax
	 # 	LD es una constant  75, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -312(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-312(%ebp), %eax
	 # 	LD es una constant  77, %ebx
	movl	$48, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -328(%ebp)

	 # 	Copia
	 # 	LD es una constant string 79, %eax
	movl	$_cnt_79, %eax
	 # 	ST a una variable local
	movl	%eax, -336(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-328(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-336(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  81, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -344(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-344(%ebp), %eax
	 # 	LD es una constant  84, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -348(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-348(%ebp), %eax
	 # 	LD es una constant  86, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -356(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-356(%ebp), %eax
	 # 	LD es una constant  88, %ebx
	movl	$0, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -372(%ebp)

	 # 	Copia
	 # 	LD es una constant  90, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -380(%ebp)

	 # 	Negacio
	xorl	%eax, %eax
	 # 	LD variable local
	movl	-380(%ebp), %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -384(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-372(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-384(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  93, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -392(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-392(%ebp), %eax
	 # 	LD es una constant  96, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -396(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-396(%ebp), %eax
	 # 	LD es una constant  98, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -404(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-404(%ebp), %eax
	 # 	LD es una constant  100, %ebx
	movl	$16, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -420(%ebp)

	 # 	Copia
	 # 	LD es una constant  102, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -428(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-420(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-428(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  104, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -436(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-436(%ebp), %eax
	 # 	LD es una constant  107, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -440(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-440(%ebp), %eax
	 # 	LD es una constant  109, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -448(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-448(%ebp), %eax
	 # 	LD es una constant  111, %ebx
	movl	$32, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -464(%ebp)

	 # 	Copia
	 # 	LD es una constant  113, %eax
	movl	$99, %eax
	 # 	ST a una variable local
	movl	%eax, -472(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-464(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-472(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  115, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -480(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-480(%ebp), %eax
	 # 	LD es una constant  118, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -484(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-484(%ebp), %eax
	 # 	LD es una constant  120, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -492(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-492(%ebp), %eax
	 # 	LD es una constant  122, %ebx
	movl	$48, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -508(%ebp)

	 # 	Copia
	 # 	LD es una constant string 124, %eax
	movl	$_cnt_124, %eax
	 # 	ST a una variable local
	movl	%eax, -516(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-508(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-516(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  126, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -524(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-524(%ebp), %eax
	 # 	LD es una constant  129, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -528(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-528(%ebp), %eax
	 # 	LD es una constant  131, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -536(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-536(%ebp), %eax
	 # 	LD es una constant  133, %ebx
	movl	$0, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -552(%ebp)

	 # 	Copia
	 # 	LD es una constant  135, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -560(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-552(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-560(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  137, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -568(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-568(%ebp), %eax
	 # 	LD es una constant  140, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -572(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-572(%ebp), %eax
	 # 	LD es una constant  142, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -580(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-580(%ebp), %eax
	 # 	LD es una constant  144, %ebx
	movl	$16, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -596(%ebp)

	 # 	Copia
	 # 	LD es una constant  146, %eax
	movl	$4, %eax
	 # 	ST a una variable local
	movl	%eax, -604(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-596(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-604(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  148, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -612(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-612(%ebp), %eax
	 # 	LD es una constant  151, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -616(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-616(%ebp), %eax
	 # 	LD es una constant  153, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -624(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-624(%ebp), %eax
	 # 	LD es una constant  155, %ebx
	movl	$32, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -640(%ebp)

	 # 	Copia
	 # 	LD es una constant  157, %eax
	movl	$115, %eax
	 # 	ST a una variable local
	movl	%eax, -648(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-640(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-648(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  159, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -656(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-656(%ebp), %eax
	 # 	LD es una constant  162, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -660(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-660(%ebp), %eax
	 # 	LD es una constant  164, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -668(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-668(%ebp), %eax
	 # 	LD es una constant  166, %ebx
	movl	$48, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -684(%ebp)

	 # 	Copia
	 # 	LD es una constant string 168, %eax
	movl	$_cnt_168, %eax
	 # 	ST a una variable local
	movl	%eax, -692(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-684(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-692(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  170, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -700(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-700(%ebp), %eax
	 # 	LD es una constant  173, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -704(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-704(%ebp), %eax
	 # 	LD es una constant  175, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -712(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-712(%ebp), %eax
	 # 	LD es una constant  177, %ebx
	movl	$0, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -728(%ebp)

	 # 	Copia
	 # 	LD es una constant  179, %eax
	movl	$4, %eax
	 # 	ST a una variable local
	movl	%eax, -736(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-728(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-736(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  181, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -744(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-744(%ebp), %eax
	 # 	LD es una constant  184, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -748(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-748(%ebp), %eax
	 # 	LD es una constant  186, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -756(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-756(%ebp), %eax
	 # 	LD es una constant  188, %ebx
	movl	$16, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -772(%ebp)

	 # 	Copia
	 # 	LD es una constant  190, %eax
	movl	$256, %eax
	 # 	ST a una variable local
	movl	%eax, -780(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %edi
	 # 	LD variable local
	movl	-772(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-780(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  192, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -788(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-788(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -68(%ebp)

	 # 	Etiqueta  2
_etq_2: nop

	 # 	Copia
	 # 	LD es una constant  194, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -796(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD variable local
	movl	-796(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_6
	jmp	_etq_4
_etq_6: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -800(%ebp)

	 # 	Brancament Incondicional  5
	jmp	_etq_5

	 # 	Etiqueta  4
_etq_4: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -800(%ebp)

	 # 	Etiqueta  5
_etq_5: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-800(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_7
	jmp	_etq_3
_etq_7: nop

	 # 	Resta
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD es una constant  198, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -804(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-804(%ebp), %eax
	 # 	LD es una constant  200, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -812(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-812(%ebp), %eax
	 # 	LD es una constant  202, %ebx
	movl	$32, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -828(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %eax
	 # 	LD variable local
	movl	-828(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  3
	call	_putc
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Resta
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD es una constant  205, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -832(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-832(%ebp), %eax
	 # 	LD es una constant  207, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -840(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-840(%ebp), %eax
	 # 	LD es una constant  209, %ebx
	movl	$48, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -856(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %eax
	 # 	LD variable local
	movl	-856(%ebp), %ebx
	addl	%ebx, %eax
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

	 # 	Resta
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD es una constant  212, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -860(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-860(%ebp), %eax
	 # 	LD es una constant  214, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -868(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-868(%ebp), %eax
	 # 	LD es una constant  216, %ebx
	movl	$0, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -884(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %eax
	 # 	LD variable local
	movl	-884(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Resta
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD es una constant  219, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -888(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-888(%ebp), %eax
	 # 	LD es una constant  221, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -896(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-896(%ebp), %eax
	 # 	LD es una constant  223, %ebx
	movl	$16, %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -912(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-64(%ebp), %eax
	 # 	LD variable local
	movl	-912(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  225, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -920(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-68(%ebp), %eax
	 # 	LD variable local
	movl	-920(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -924(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-924(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -68(%ebp)

	 # 	Brancament Incondicional  2
	jmp	_etq_2

	 # 	Etiqueta  3
_etq_3: nop

	 # 	Return  9
	movl	%ebp, %esp
	popl	%ebp
	movl	$DISP, %edi
	popl	4(%edi)
	ret
