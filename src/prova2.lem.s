.section .data
	_zero : .long 0
	_menysu : .long -1
	true : .long -1
	false : .long 0
	_cnt_19 : .long 0
	_cnt_20 : .long 0
	_cnt_22 : .long 0
	_cnt_24 : .long 3
	_cnt_28 : .long 0
	_cnt_30 : .long 4
	_cnt_32 : .long 1
	_cnt_34 : .long 0
	_cnt_36 : .long 1
	_cnt_38 : .long 3
	_cnt_42 : .long 0
	_cnt_44 : .long 4
	_cnt_46 : .long 3
	_cnt_48 : .long 0
	_cnt_50 : .long 2
	_cnt_52 : .long 3
	_cnt_56 : .long 0
	_cnt_58 : .long 4
	_cnt_60 : .long 2
	_cnt_62 : .long 1
	_cnt_64 : .long 0
	_cnt_66 : .long 3
	_cnt_70 : .long 0
	_cnt_72 : .long 4
	_cnt_74 : .long 1
	_cnt_76 : .long 1
	_cnt_78 : .long 1
	_cnt_80 : .long 3
	_cnt_84 : .long 0
	_cnt_86 : .long 4
	_cnt_88 : .long 0
	_cnt_90 : .long 1
	_cnt_92 : .long 2
	_cnt_94 : .long 3
	_cnt_98 : .long 0
	_cnt_100 : .long 4
	_cnt_102 : .long 0
	_cnt_104 : .long 2
	_cnt_106 : .long 0
	_cnt_108 : .long 3
	_cnt_112 : .long 0
	_cnt_114 : .long 4
	_cnt_116 : .long 1
	_cnt_118 : .long 2
	_cnt_120 : .long 1
	_cnt_122 : .long 3
	_cnt_126 : .long 0
	_cnt_128 : .long 4
	_cnt_130 : .long 2
	_cnt_132 : .long 2
	_cnt_134 : .long 2
	_cnt_136 : .long 3
	_cnt_140 : .long 0
	_cnt_142 : .long 4
	_cnt_144 : .long 2
	_cnt_146 : .long 0
	_cnt_148 : .long 0
	_cnt_150 : .long 3
	_cnt_154 : .long 0
	_cnt_156 : .long 4
	_cnt_158 : .long 1
	_cnt_160 : .long 0
	_cnt_162 : .long 1
	_cnt_164 : .long 3
	_cnt_168 : .long 0
	_cnt_170 : .long 4
	_cnt_172 : .long 0
	_cnt_174 : .long 0
	_cnt_176 : .long 2
	_cnt_178 : .long 3
	_cnt_182 : .long 0
	_cnt_184 : .long 4
	_cnt_186 : .long 5
	_cnt_188 : .long 1
	_cnt_190 : .long 0
	_cnt_192 : .long 3
	_cnt_196 : .long 0
	_cnt_198 : .long 4
	_cnt_200 : .long 7
	_cnt_202 : .long 1
	_cnt_204 : .long 1
	_cnt_206 : .long 3
	_cnt_210 : .long 0
	_cnt_212 : .long 4
	_cnt_214 : .long 5
	_cnt_216 : .long 1
	_cnt_218 : .long 2
	_cnt_220 : .long 3
	_cnt_224 : .long 0
	_cnt_226 : .long 4
	_cnt_228 : .long 0
	_cnt_230 : .long 2
	_cnt_232 : .long 0
	_cnt_234 : .long 3
	_cnt_238 : .long 0
	_cnt_240 : .long 4
	_cnt_242 : .long 2
	_cnt_244 : .long 2
	_cnt_246 : .long 1
	_cnt_248 : .long 3
	_cnt_252 : .long 0
	_cnt_254 : .long 4
	_cnt_256 : .long 1
	_cnt_258 : .long 2
	_cnt_260 : .long 2
	_cnt_262 : .long 3
	_cnt_266 : .long 0
	_cnt_268 : .long 4
	_cnt_270 : .long 1
	_cnt_272 : .long 0
	_cnt_274 : .long 0
	_cnt_276 : .long 2
	_cnt_279 : .long 2
	_cnt_282 : .long 3
	_cnt_286 : .long 0
	_cnt_288 : .long 4
	_cnt_290 : .long 3
	_cnt_294 : .long 0
	_cnt_296 : .long 4
	_cnt_298 : .long 3
	_cnt_302 : .long 0
	_cnt_304 : .long 4
	_cnt_309 : .long 3
	_cnt_313 : .long 0
	_cnt_315 : .long 4
	_cnt_317 : .long 1
	_cnt_320 : .long 0
	_cnt_322 : .long 1

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
	subl	$1348, %esp

	 # 	Copia
	 # 	LD es una constant  20, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -136(%ebp)

	 # 	Copia
	 # 	LD es una constant  22, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -144(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-136(%ebp), %eax
	 # 	LD es una constant  24, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -152(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-152(%ebp), %eax
	 # 	LD variable local
	movl	-144(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -156(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-156(%ebp), %eax
	 # 	LD es una constant  28, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -160(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-160(%ebp), %eax
	 # 	LD es una constant  30, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -168(%ebp)

	 # 	Copia
	 # 	LD es una constant  32, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -184(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-168(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-184(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  34, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -192(%ebp)

	 # 	Copia
	 # 	LD es una constant  36, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -200(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-192(%ebp), %eax
	 # 	LD es una constant  38, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -208(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-208(%ebp), %eax
	 # 	LD variable local
	movl	-200(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -212(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-212(%ebp), %eax
	 # 	LD es una constant  42, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -216(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-216(%ebp), %eax
	 # 	LD es una constant  44, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -224(%ebp)

	 # 	Copia
	 # 	LD es una constant  46, %eax
	movl	$3, %eax
	 # 	ST a una variable local
	movl	%eax, -240(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-224(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-240(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  48, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -248(%ebp)

	 # 	Copia
	 # 	LD es una constant  50, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -256(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-248(%ebp), %eax
	 # 	LD es una constant  52, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -264(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-264(%ebp), %eax
	 # 	LD variable local
	movl	-256(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -268(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-268(%ebp), %eax
	 # 	LD es una constant  56, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -272(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-272(%ebp), %eax
	 # 	LD es una constant  58, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -280(%ebp)

	 # 	Copia
	 # 	LD es una constant  60, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -296(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-280(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-296(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  62, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -304(%ebp)

	 # 	Copia
	 # 	LD es una constant  64, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -312(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-304(%ebp), %eax
	 # 	LD es una constant  66, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -320(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-320(%ebp), %eax
	 # 	LD variable local
	movl	-312(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -324(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-324(%ebp), %eax
	 # 	LD es una constant  70, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -328(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-328(%ebp), %eax
	 # 	LD es una constant  72, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -336(%ebp)

	 # 	Copia
	 # 	LD es una constant  74, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -352(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-336(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-352(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  76, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -360(%ebp)

	 # 	Copia
	 # 	LD es una constant  78, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -368(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-360(%ebp), %eax
	 # 	LD es una constant  80, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -376(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-376(%ebp), %eax
	 # 	LD variable local
	movl	-368(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -380(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-380(%ebp), %eax
	 # 	LD es una constant  84, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -384(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-384(%ebp), %eax
	 # 	LD es una constant  86, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -392(%ebp)

	 # 	Copia
	 # 	LD es una constant  88, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -408(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-392(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-408(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  90, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -416(%ebp)

	 # 	Copia
	 # 	LD es una constant  92, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -424(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-416(%ebp), %eax
	 # 	LD es una constant  94, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -432(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-432(%ebp), %eax
	 # 	LD variable local
	movl	-424(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -436(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-436(%ebp), %eax
	 # 	LD es una constant  98, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -440(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-440(%ebp), %eax
	 # 	LD es una constant  100, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -448(%ebp)

	 # 	Copia
	 # 	LD es una constant  102, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -464(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-448(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-464(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  104, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -472(%ebp)

	 # 	Copia
	 # 	LD es una constant  106, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -480(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-472(%ebp), %eax
	 # 	LD es una constant  108, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -488(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-488(%ebp), %eax
	 # 	LD variable local
	movl	-480(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -492(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-492(%ebp), %eax
	 # 	LD es una constant  112, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -496(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-496(%ebp), %eax
	 # 	LD es una constant  114, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -504(%ebp)

	 # 	Copia
	 # 	LD es una constant  116, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -520(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-504(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-520(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  118, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -528(%ebp)

	 # 	Copia
	 # 	LD es una constant  120, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -536(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-528(%ebp), %eax
	 # 	LD es una constant  122, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -544(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-544(%ebp), %eax
	 # 	LD variable local
	movl	-536(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -548(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-548(%ebp), %eax
	 # 	LD es una constant  126, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -552(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-552(%ebp), %eax
	 # 	LD es una constant  128, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -560(%ebp)

	 # 	Copia
	 # 	LD es una constant  130, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -576(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-560(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-576(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  132, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -584(%ebp)

	 # 	Copia
	 # 	LD es una constant  134, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -592(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-584(%ebp), %eax
	 # 	LD es una constant  136, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -600(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-600(%ebp), %eax
	 # 	LD variable local
	movl	-592(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -604(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-604(%ebp), %eax
	 # 	LD es una constant  140, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -608(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-608(%ebp), %eax
	 # 	LD es una constant  142, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -616(%ebp)

	 # 	Copia
	 # 	LD es una constant  144, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -632(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %edi
	 # 	LD variable local
	movl	-616(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-632(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  146, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -640(%ebp)

	 # 	Copia
	 # 	LD es una constant  148, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -648(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-640(%ebp), %eax
	 # 	LD es una constant  150, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -656(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-656(%ebp), %eax
	 # 	LD variable local
	movl	-648(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -660(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-660(%ebp), %eax
	 # 	LD es una constant  154, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -664(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-664(%ebp), %eax
	 # 	LD es una constant  156, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -672(%ebp)

	 # 	Copia
	 # 	LD es una constant  158, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -688(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-672(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-688(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  160, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -696(%ebp)

	 # 	Copia
	 # 	LD es una constant  162, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -704(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-696(%ebp), %eax
	 # 	LD es una constant  164, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -712(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-712(%ebp), %eax
	 # 	LD variable local
	movl	-704(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -716(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-716(%ebp), %eax
	 # 	LD es una constant  168, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -720(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-720(%ebp), %eax
	 # 	LD es una constant  170, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -728(%ebp)

	 # 	Copia
	 # 	LD es una constant  172, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -744(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-728(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-744(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  174, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -752(%ebp)

	 # 	Copia
	 # 	LD es una constant  176, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -760(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-752(%ebp), %eax
	 # 	LD es una constant  178, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -768(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-768(%ebp), %eax
	 # 	LD variable local
	movl	-760(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -772(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-772(%ebp), %eax
	 # 	LD es una constant  182, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -776(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-776(%ebp), %eax
	 # 	LD es una constant  184, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -784(%ebp)

	 # 	Copia
	 # 	LD es una constant  186, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -800(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-784(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-800(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  188, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -808(%ebp)

	 # 	Copia
	 # 	LD es una constant  190, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -816(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-808(%ebp), %eax
	 # 	LD es una constant  192, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -824(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-824(%ebp), %eax
	 # 	LD variable local
	movl	-816(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -828(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-828(%ebp), %eax
	 # 	LD es una constant  196, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -832(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-832(%ebp), %eax
	 # 	LD es una constant  198, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -840(%ebp)

	 # 	Copia
	 # 	LD es una constant  200, %eax
	movl	$7, %eax
	 # 	ST a una variable local
	movl	%eax, -856(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-840(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-856(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  202, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -864(%ebp)

	 # 	Copia
	 # 	LD es una constant  204, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -872(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-864(%ebp), %eax
	 # 	LD es una constant  206, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -880(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-880(%ebp), %eax
	 # 	LD variable local
	movl	-872(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -884(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-884(%ebp), %eax
	 # 	LD es una constant  210, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -888(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-888(%ebp), %eax
	 # 	LD es una constant  212, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -896(%ebp)

	 # 	Copia
	 # 	LD es una constant  214, %eax
	movl	$5, %eax
	 # 	ST a una variable local
	movl	%eax, -912(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-896(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-912(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  216, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -920(%ebp)

	 # 	Copia
	 # 	LD es una constant  218, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -928(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-920(%ebp), %eax
	 # 	LD es una constant  220, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -936(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-936(%ebp), %eax
	 # 	LD variable local
	movl	-928(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -940(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-940(%ebp), %eax
	 # 	LD es una constant  224, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -944(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-944(%ebp), %eax
	 # 	LD es una constant  226, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -952(%ebp)

	 # 	Copia
	 # 	LD es una constant  228, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -968(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-952(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-968(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  230, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -976(%ebp)

	 # 	Copia
	 # 	LD es una constant  232, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -984(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-976(%ebp), %eax
	 # 	LD es una constant  234, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -992(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-992(%ebp), %eax
	 # 	LD variable local
	movl	-984(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -996(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-996(%ebp), %eax
	 # 	LD es una constant  238, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1000(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1000(%ebp), %eax
	 # 	LD es una constant  240, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1008(%ebp)

	 # 	Copia
	 # 	LD es una constant  242, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1024(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-1008(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-1024(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  244, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1032(%ebp)

	 # 	Copia
	 # 	LD es una constant  246, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1040(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1032(%ebp), %eax
	 # 	LD es una constant  248, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1048(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1048(%ebp), %eax
	 # 	LD variable local
	movl	-1040(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1052(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1052(%ebp), %eax
	 # 	LD es una constant  252, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1056(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1056(%ebp), %eax
	 # 	LD es una constant  254, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1064(%ebp)

	 # 	Copia
	 # 	LD es una constant  256, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1080(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-1064(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-1080(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  258, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1088(%ebp)

	 # 	Copia
	 # 	LD es una constant  260, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1096(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1088(%ebp), %eax
	 # 	LD es una constant  262, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1104(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1104(%ebp), %eax
	 # 	LD variable local
	movl	-1096(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1108(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1108(%ebp), %eax
	 # 	LD es una constant  266, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1112(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1112(%ebp), %eax
	 # 	LD es una constant  268, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1120(%ebp)

	 # 	Copia
	 # 	LD es una constant  270, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1136(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %edi
	 # 	LD variable local
	movl	-1120(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-1136(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Copia
	 # 	LD es una constant  272, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -1144(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1144(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -116(%ebp)

	 # 	Copia
	 # 	LD es una constant  274, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -1152(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1152(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -112(%ebp)

	 # 	Etiqueta  2
_etq_2: nop

	 # 	Copia
	 # 	LD es una constant  276, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1160(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD variable local
	movl	-1160(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_10
	jmp	_etq_4
_etq_10: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -1164(%ebp)

	 # 	Brancament Incondicional  5
	jmp	_etq_5

	 # 	Etiqueta  4
_etq_4: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -1164(%ebp)

	 # 	Etiqueta  5
_etq_5: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-1164(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_11
	jmp	_etq_3
_etq_11: nop

	 # 	Etiqueta  6
_etq_6: nop

	 # 	Copia
	 # 	LD es una constant  279, %eax
	movl	$2, %eax
	 # 	ST a una variable local
	movl	%eax, -1172(%ebp)
	 # 	IF Menor o Igual
	 # 	LD variable local
	movl	-112(%ebp), %eax
	 # 	LD variable local
	movl	-1172(%ebp), %ebx
	cmpl	%ebx, %eax
	jg	_etq_12
	jmp	_etq_8
_etq_12: nop

	 # 	Copia
	 # 	LD es una constant  1, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -1176(%ebp)

	 # 	Brancament Incondicional  9
	jmp	_etq_9

	 # 	Etiqueta  8
_etq_8: nop

	 # 	Copia
	 # 	LD es una constant  2, %eax
	movl	$-1, %eax
	 # 	ST a una variable local
	movl	%eax, -1176(%ebp)

	 # 	Etiqueta  9
_etq_9: nop
	 # 	IF Igual
	 # 	LD variable local
	movl	-1176(%ebp), %eax
	 # 	LD es una constant  1, %ebx
	movl	$0, %ebx
	cmpl	%ebx, %eax
	jne	_etq_13
	jmp	_etq_7
_etq_13: nop

	 # 	Producte
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD es una constant  282, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1184(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1184(%ebp), %eax
	 # 	LD variable local
	movl	-112(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1188(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1188(%ebp), %eax
	 # 	LD es una constant  286, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1192(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1192(%ebp), %eax
	 # 	LD es una constant  288, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1200(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD es una constant  290, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1216(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1216(%ebp), %eax
	 # 	LD variable local
	movl	-112(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1220(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1220(%ebp), %eax
	 # 	LD es una constant  294, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1224(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1224(%ebp), %eax
	 # 	LD es una constant  296, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1232(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD es una constant  298, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1248(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1248(%ebp), %eax
	 # 	LD variable local
	movl	-112(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1252(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1252(%ebp), %eax
	 # 	LD es una constant  302, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1256(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1256(%ebp), %eax
	 # 	LD es una constant  304, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1264(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-108(%ebp), %esi
	 # 	LD variable local
	movl	-1232(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -1276(%ebp)

	 # 	Consulta index
	 # 	LDADDR amb variable local
	leal	-72(%ebp), %esi
	 # 	LD variable local
	movl	-1264(%ebp), %eax
	addl	%eax, %esi
	movl	(%esi), %eax
	 # 	ST a una variable local
	movl	%eax, -1280(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1276(%ebp), %eax
	 # 	LD variable local
	movl	-1280(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1284(%ebp)

	 # 	Assignacio d'index
	 # 	LDADDR amb variable local
	leal	-36(%ebp), %edi
	 # 	LD variable local
	movl	-1200(%ebp), %eax
	addl	%eax, %edi
	 # 	LD variable local
	movl	-1284(%ebp), %eax
	movl	%eax, (%edi)

	 # 	Producte
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD es una constant  309, %ebx
	movl	$3, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1292(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-1292(%ebp), %eax
	 # 	LD variable local
	movl	-112(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1296(%ebp)

	 # 	Resta
	 # 	LD variable local
	movl	-1296(%ebp), %eax
	 # 	LD es una constant  313, %ebx
	movl	$0, %ebx
	subl	%ebx, %eax
	 # 	ST a una variable local
	movl	%eax, -1300(%ebp)

	 # 	Producte
	 # 	LD variable local
	movl	-1300(%ebp), %eax
	 # 	LD es una constant  315, %ebx
	movl	$4, %ebx
	imull	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1308(%ebp)

	 # 	Parametre Compost
	 # 	LDADDR amb variable local
	leal	-36(%ebp), %eax
	 # 	LD variable local
	movl	-1308(%ebp), %ebx
	addl	%ebx, %eax
	pushl	%eax

	 # 	Call  1
	call	_puti
	addl	$4, %esp

	 # 	Copia
	 # 	LD es una constant  317, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1324(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-112(%ebp), %eax
	 # 	LD variable local
	movl	-1324(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1328(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1328(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -112(%ebp)

	 # 	Brancament Incondicional  6
	jmp	_etq_6

	 # 	Etiqueta  7
_etq_7: nop

	 # 	Call  8
	call	_new_line
	addl	$0, %esp

	 # 	Copia
	 # 	LD es una constant  320, %eax
	movl	$0, %eax
	 # 	ST a una variable local
	movl	%eax, -1336(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1336(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -112(%ebp)

	 # 	Copia
	 # 	LD es una constant  322, %eax
	movl	$1, %eax
	 # 	ST a una variable local
	movl	%eax, -1344(%ebp)

	 # 	Suma
	 # 	LD variable local
	movl	-116(%ebp), %eax
	 # 	LD variable local
	movl	-1344(%ebp), %ebx
	addl	%eax, %ebx
	 # 	ST a una variable local
	movl	%ebx, -1348(%ebp)

	 # 	Copia
	 # 	LD variable local
	movl	-1348(%ebp), %eax
	 # 	ST a una variable local
	movl	%eax, -116(%ebp)

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
