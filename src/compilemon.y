-- Tokens
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
%token s_assignacio
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
%token const ---- Sirve para la declaracion de constantes


--Precedència
%left pc_or
%left pc_and
%left pc_not
%nonassoc op_menor op_menorigual op_majorigual op_major op_igual op_distint
%left op_suma
%left op_resta
%left op_multiplicacio
%left op_divisio
%left menys_unitari


--Definició del tipus atribut
%with d_atribut
{
	subtype yystype is d_atribut.atribut;
}


%%


--Produccions de la gramàtica del llenguatge
programa:
	M1 dec_procediment
  ;
  
M1: 
  ;

dec_procediment:
	pc_procediment encap pc_es
		declaracions
	pc_inici
		bloc
	pc_fi id s_final 
  ;
	
encap:
	id
  |
    pencap s_parentesitancat
  ;
  
p_encap:
	pencap s_final param
  |
	id s_parentesiobert param
  ;
  
param:
	id s_dospunts mode id
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
	id c_decl_var
  ;
  
c_decl_var:
	s_dospunts id s_final
  |
    s_coma id c_decl_var
  ;

dec_constant:
	id s_dospunts pc_constant id s_assignacio const s_final
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
	pc_tipus id pc_es pc_nou id pc_rang limit s_dospunts limit s_final
  ;
  
limit:
    const
  | 
    id
  ;
    
  
-- TIPUS REGISTRE
decl_registre:
	p_dregistre pc_fi pc_registre
  ;
  
p_dregistre: 
	p_dregistre id s_dospunts id s_final
  | 
    pc_tipus id pc_es pc_registre id s_dospunts id s_final
  ;

-- TIPUS COLECCIO
decl_coleccio:
	p_dcoleccio s_parentesitancat pc_de id s_final
  ;
  
p_dcoleccio:
	p_dcoleccio s_coma id
  |
	pc_tipus id pc_es pc_coleccio s_parentesiobert id
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
  
srep:
	pc_mentre expressio pc_fer
		bloc
	pc_fi pc_fer
  ;

crida_proc:
	referencia s_final
  ;

referencia:
	id
  |
	referencia s_puntrec id
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
	op_resta expressio   %prec menys_unitari
  |
	s_parentesiobert expressio s_parentesitancat
  |
	referencia
  |
    const
  ;


  
  
%%


package pk_usintactica is

	procedure yyparse;
	
	
end pk_usintactica;



with    pk_usintactica_token,
        pk_usintactica_shift_reduce,
        pk_usintactica_goto,
		compilemon_io,
		u_lexica;
        

use     pk_usintactica_token,
        pk_usintactica_shift_reduce,
        pk_usintactica_goto,
		compilemon_io,
		u_lexica;
		

package body pk_usintactica is

##

-- AQUI PODEMOS AÑADIR EL CONTROL DE ERRORES
--procedure YYError (txt: in String; tk: in token; atr:in Decls.Datributo.atributo) is
--begin
--	text_io.new_line(2);
--	text_io.put_line(txt & ".");
--	text_io.put_line("Ultimo token: " & tk'img);
--	text_io.Put("Atributos: ");
--	Imprime(Atr);
--	text_io.new_line(2);
--end YYError;

end pk_usintactica;
  







