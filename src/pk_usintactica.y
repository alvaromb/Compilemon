--Token
%token pc_procedure
%token pc_begin
%token pc_while
%token pc_if
%token pc_else
%token pc_end
%token pc_loop
%token pc_constant
%token pc_type
%token pc_array
%token pc_record
%token pc_is
%token pc_then
%token pc_not
%token pc_in
%token pc_out
%token pc_new
%token pc_null
%token pc_of
%token pc_mod
%token pc_range
%token pc_or
%token pc_and
%token s_assignacio
%token s_dospunts 
%token s_final
%token s_coma
%token s_parentesiobert
%token s_parentesitancat
%token s_puntsrang
%token s_puntrec
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
%token const -- Per declarar constants (digit, lletra i string)
			 -- MIRAR d_token.ads: pc_do Quitar??? cadena???

--Precedencia
%left pc_or
%left pc_and
%nonassoc op_menor op_menorigual op_majorigual op_major op_igual op_distint
%left op_suma
%left op_resta
%left op_multiplicacio op_divisio pc_mod
%left pc_not
%left menys_unitari



--Definicio del tipus atribut
%with d_atribut
{
	subtype yystype is d_atribut.atribut;
}


%%


--Produccions de la gramatica del llenguatge
programa:
	M1 dec_procediment
  ;
  
M1: 
  ;

dec_procediment:
	pc_procedure encap pc_is
		declaracions
	pc_begin
		bloc
	pc_end id s_final 
  ;


encap:
	id
  |
    pencap s_parentesitancat
  ;
  
pencap:
	pencap s_final param
  |
	id s_parentesiobert param
  ;
  
param:
	id s_dospunts mode id
  ;

  
mode:
	pc_in
  |
	pc_out
  |
	pc_in pc_out
  ;
  
declaracions:
	declaracions declaracio
  |
  ;
  

-- DECLARACIONS
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
	id s_dospunts pc_constant id s_assignacio const s_final -- ESTE const se refiere en los apuntes a VALOR
  ;
  

-- TIPUS
dec_tipus:
	decl_coleccio
  |
    decl_registre
  | 
	decl_subrang
  ;
  
  
-- TIPUS SUBRANG
decl_subrang:
	pc_type id pc_is pc_new id pc_range limit s_dospunts limit s_final
  ;
  
limit:
    const
  | 
    id
  ;
    
  
-- TIPUS REGISTRE
decl_registre:
	p_dregistre pc_end pc_record
  ;
  
p_dregistre: 
	p_dregistre id s_dospunts id s_final
  | 
    pc_type id pc_is pc_record id s_dospunts id s_final
  ;
  

-- TIPUS COLECCIO
decl_coleccio:
	p_dcoleccio s_parentesitancat pc_of id s_final
  ;
  
p_dcoleccio:
	p_dcoleccio s_coma id
  |
	pc_type id pc_is pc_array s_parentesiobert id
  ;

  
-- BLOC D'INSTRUCCIO
bloc:
	bloc sentencia
  | 
	sentencia
  ;
  
  
-- SENTENCIES D'INSTRUCCIONS
sentencia: 
	sassig
  |
	scond
  |
	srep
  | 
    crida_proc 
  ; --FALTARIA PONER LAMBDA???? En la doc, la pusimos. Tendría sentido un 'bloc' vacio? 

-- Sentencia assignacio
sassig:
	referencia s_assignacio expressio s_final
  ;

-- Sentencia condicional
scond:
	pc_if expressio pc_then 
		bloc 
	pc_end pc_if
  |
    pc_if expressio pc_then 
		bloc 
	pc_else
		bloc
	pc_end pc_if
  ;

-- Sentencia bucle
srep:
	pc_while expressio pc_loop
		bloc
	pc_end pc_loop --CAMBIAR EN LA DOCUMENTACION (PONE end while????)
  ;

-- Sentencia crida a procediment
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
	referencia s_parentesiobert expressio
  |
    pri s_coma expressio
  ;
  
  
-- Expressions
expressio:
	expressio pc_or expressio
  |
	expressio pc_and expressio
  |
	pc_not expressio     %prec pc_not
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
    expressio pc_mod expressio
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



with    pk_usintactica_tokens,
        pk_usintactica_shift_reduce,
        pk_usintactica_goto,
		compilemon_io,
		u_lexica,
		Ada.Text_IO;
        

use     pk_usintactica_tokens,
        pk_usintactica_shift_reduce,
        pk_usintactica_goto,
		compilemon_io,
		u_lexica,
		Ada,
		Ada.Text_IO;
		

package body pk_usintactica is

    procedure YYError (e : in string) is
    
    begin
        
        Put_Line(e);
        raise Syntax_Error;
    
    end YYError;
    
##

end pk_usintactica;
  

