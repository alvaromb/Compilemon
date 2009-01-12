--Tokens
%token pc_procediment
%token pc_inici
%token pc_mentre
%token pc_per
%token pc_entre
%token pc_si
%token pc_sino
%token pc_fi
%token pc_fer
%token pc_constant
%token pc_tipus
%token pc_coleccio
%token pc_registre
%token pc_es
%token pc_llavors
%token pc_no
%token pc_entra
%token pc_surt
%token pc_nou
%token pc_nul
%token pc_de
%token pc_modul
%token pc_rang
%token pc_or
%token pc_and
%token s_assignacio --PONERLE UNA S MAS
%token s_dospunts 
%token s_final
%token s_coma
%token s_parentesiobert
%token s_parentesitancat
%token s_puntsrang
%token op_menor
%token op_menorigual
%token op_majorigual
%token op_major
%token op_igual
%token op_distint
%token op_suma
%token op_resta
%token op_multiplicacio
%token op_divisio
%token id
%token cadena ------
%token const ---- Sirve para la declaracion de constantes


--Precedència
--%left pc_or
--%left pc_and
--%left pc_not
--%nonassoc op_menor op_menorigual op_majorigual op_major op_igual op_distint
--%left op_suma
--%left op_resta
--%left op_multiplicacio
--%left op_divisio
--%left menys_unitari


--Definició del tipus atribut
%with d_atribut
{
	subtype yystype is d_atribut.atribut;
}


%%


--Produccions de la gramàtica del llenguatge
programa:
	M1 declaracio_procediment
  ;
  
M1: 
  ;

declaracio_procediment:
	pc_procediment encap pc_es
		declaracions
	pc_inici
		bloc
	pc_fi identificador s_final 
  ;
	
encap:
	identificador
  |
    pencap s_parentesitancat
  ;
  
p_encap:
	pencap s_final param
  |
	identificador s_parentesiobert param
  ;
  
param:
	identificador s_dospunts mode identificador
  ;
	
mode:
	pc_entra
  |
	pc_surt
  |
	pc_entra pc_surt
  ;
  
declaracions:
	declaracions declaracio
  |
  ;
  
declaracio:
	dec_var
  |
	dec_constant
  |
    dec_tipus
  |
    dec_procediment
  ;
  
dec_var:
	identificador c_decl_var
  ;
  
c_decl_var:
	s_dospunts identificador s_final
  |
    s_coma identificador c_decl_var
  ;

dec_constant:
	identificador s_dospunts pc_constant identificador s_assignacio const s_final ---PONEMOS const O valor
  ;
  
dec_tipus:
	decl_coleccio
  |
    decl_registre
  | 
	decl_subrang
  ;
  
-- TIPUS SUBRANG
decl_subrang:
	pc_tipus identificador pc_es pc_nou identificador pc_rang --DISCUTIR s_dospunts ------ s_final
  ;
  
-- TIPUS REGISTRE
decl_registre:
	p_dregistre pc_fi pc_registre
  ;
  
p_dregistre: --LA DE JUANMA ES DISTINTA
	p_dregistre identificador s_dospunts identificador s_final
  | 
    pc_tipus identificador pc_es pc_registre identificador s_dospunts identificador s_final
  ;

-- TIPUS COLECCIO
decl_coleccio:
	p_dcoleccio s_parentesitancat pc_de identificador s_final
  ;
  
p_dcoleccio:
	p_dcoleccio s_coma identificador
  |
	pc_tipus identificador pc_es pc_coleccio s_parentesiobert identificador
  ;



dec_procediment: --CAMBIAR EL NOMBRE O QUITARLA
	declaracio_procediment
  ;
  
bloc:
	bloc sentencia
  | 
	sentencia
  ;
  
sentencia: 
	sassig
  |
	scond
  |
	srep
  | 
    crida_proc
  ;
  
sassig:
	referencia s_assignacio expressio s_final
  ;
  
scond:
	pc_si expressio pc_llavors 
		bloc 
	pc_fi pc_si
  |
    pc_si expressio pc_llavors 
		bloc 
	pc_sino
		bloc
	pc_fi pc_si
  ;
-----------------------------  
--VERSION JUANMA
estr_if:
	encap_else
	instrucciones
	pc_end pc_if s_puntoycoma
  |
	encap_if
		instrucciones
	pc_end pc_if s_puntoycoma
  ;
  
encap_else:
	encap_if
	instrucciones
	pc_else
  ;
  
encap_if:
	pc_if expresion pc_then
  ;
------------------------------------  
  
srep:
	pc_mentre expressio pc_fer
		bloc
	pc_fi pc_fer
  ;

--------------------------------------------  
--VERSION JUANMA
estr_while:
	eloop
		instrucciones
	pc_end pc_loop s_puntoycoma
  ;
  
eloop:
	encap_loop expresion pc_loop
  ;
  
encap_loop:
	pc_while
  ;
--------------------------------------------

crida_proc:
	referencia s_final
  ;

referencia:
	identificador
  |
	referencia s_punto identificador --TENEMOS QUE INCLUIR EL S_PUNTO
  |
	pri s_parentesitancat
  ;
  
pri:
	pri s_coma expressio
  |
    referencia s_parentesiobert expressio
  ;
  
expressio:
	expressio pc_or expressio
  |
	expressio pc_and expressio
  |
	pc_no expressio
  |
	expressio op_menor expressio
  |
	expressio op_menorigual expressio
  |
	expressio op_majorigual expressio
  |
	expressio op_major expressio
  |
	expressio op_igual expressio	
  |
	expressio op_distint expressio
  |
	expressio op_suma expressio
  |
	expressio op_resta expressio
  |
	expressio op_multiplicacio expressio
  |
	expressio op_divisio expressio
  |
	expressio pc_modul expressio
  |
	op_resta expressio   %prec menys_unitari-------------
  |
	s_parentesiobert expressio s_parentesitancat
  |
	referencia
  |
    constant -- JUANMA
  ;


  
  
%%
package pk_usintactica is
	procedure yyparse;
end pk_sintactico;

with text_io, Semantica.Atributo, Decls.Datributo, Pk_Lexico, pk_sintactico_tokens, pk_sintactico_goto, pk_sintactico_shift_reduce,semantica;

use text_io, Semantica.Atributo, Decls.Datributo, Pk_Lexico, pk_sintactico_tokens, pk_sintactico_goto, pk_sintactico_shift_reduce,semantica;

package body pk_sintactico is
	procedure YYError (txt: in String; tk: in token; atr:in Decls.Datributo.atributo) is
begin

	text_io.new_line(2);
	text_io.put_line(txt & ".");
	text_io.put_line("Ultimo token: " & tk'img);
	text_io.Put("Atributos: ");
	Imprime(Atr);
	text_io.new_line(2);
end YYError;

##
end pk_sintactico;
  







