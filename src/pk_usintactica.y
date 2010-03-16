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
%token const 


--Precedencia
%left pc_or
%left pc_and
%left pc_not
%nonassoc op_menor op_menorigual op_majorigual 
op_major op_igual op_distint
%left op_suma
%left op_resta
%left op_multiplicacio op_divisio pc_mod
%left menys_unitari



--Definicio del tipus atribut
%with decls.d_atribut, decls.dtnode;
%use decls.d_atribut, decls.dtnode;
{
	subtype yystype is decls.d_atribut.atribut;

}


%%


--Produccions de la gramatica del llenguatge
programa:
    M1 dec_procediment 
	{creaNode($$, $1, $2, programa);}
  ;
  
M1: 
  ;

dec_procediment:
    pc_procedure encap pc_is
        declaracions
    pc_begin
        bloc
    pc_end id s_final 
	{creaNode($$, $2, $4, $6, $8, procediment);}
  ;


encap:
    id
  |
    pencap s_parentesitancat
  ;
  
pencap:
    pencap s_final param
	--{creaNode($$, $1, $3, );}
  |
    id s_parentesiobert param
	--{creaNode($$, $1, $3, );}
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
	{creaNode($$, $1, $2, declaracions);}
  |
  ;
  

-- DECLARACIONS
declaracio:
    dec_var s_final
  |
    dec_constant s_final
  |
    dec_tipus s_final
  |
    dec_procediment 
  ;
  
dec_var:
    id c_decl_var
	{creaNode($$, $1, $2, dvariable);}
  ;
  
c_decl_var:
    s_dospunts id c_decl_ass 
	{creaNode($$, $2, $3, asigvalvar);}
  |
    s_coma id c_decl_var
	{creaNode($$, $2, $3, declmultvar);}
  ;

dec_constant:
    id s_dospunts pc_constant id s_assignacio expressio
	{creaNode($$, $1, $4, $6, dconstant);}
  ;
  
c_decl_ass:
    s_assignacio limit
  |
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
    pc_type id pc_is pc_new id pc_range limit 
    s_puntsrang limit
	{creaNode($$, $2, $5, $7, $9, dsubrang);} 
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
	{creaNode($$, $1, $2, $4, dencapregistre);}
  | 
    pc_type id pc_is pc_record id s_dospunts id s_final
	{creaNode($$, $2, $5, $7, Dregistre);}
  ;
  

-- TIPUS COLECCIO
decl_coleccio:
    p_dcoleccio s_parentesitancat pc_of id 
	{creaNode($$, $1, $4, Dcoleccio);}
  ;
  
p_dcoleccio:
    p_dcoleccio s_coma id
	{creaNode($$, $1, $3, Pcoleccio);}
  |
    pc_type id pc_is pc_array s_parentesiobert id
	{creaNode($$, $2, $6, Pdimcoleccio);}
  ;

  
-- BLOC D'INSTRUCCIO
bloc:
    bloc sentencia s_final
  | 
    sentencia s_final
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
  ; 

-- Sentencia assignacio
sassig:
    referencia s_assignacio expressio 
  ;

-- Sentencia condicional
scond:
    pc_if expressio pc_then 
        bloc 
    pc_end pc_if
	{creaNode($$, $2, $4, CondicionalS);}
  |
    pc_if expressio pc_then 
        bloc 
    pc_else
        bloc
    pc_end pc_if
	{creaNode($$, $2, $4, $6, CondicionalC);}
  ;

-- Sentencia bucle
srep:
    pc_while expressio pc_loop
        bloc
    pc_end pc_loop
	{creaNode($$, $2, $4, Repeticio);}
  ;

-- Sentencia crida a procediment
crida_proc:
    referencia 
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
	{creaNode($$, $1, $3, Unio, Expressio);}
  |
    expressio pc_and expressio
	{creaNode($$, $1, $3, Interseccio, Expressio);}
  |
    pc_not expressio     %prec pc_not
	{creaNode($$, $2, Negacio, ExpressioUnaria);}
  |
    expressio op_menor expressio
	{creaNode($$, $1, $3, Menor, Expressio);}
  |
    expressio op_menorigual expressio
	{creaNode($$, $1, $3, Menorig, Expressio);}
  |
    expressio op_majorigual expressio
	{creaNode($$, $1, $3, Majorig, Expressio);}
  |
    expressio op_major expressio
	{creaNode($$, $1, $3, Major, Expressio);}
  |
    expressio op_igual expressio    
	{creaNode($$, $1, $3, Igual, Expressio);}
  |
    expressio op_distint expressio
	{creaNode($$, $1, $3, Distint, Expressio);}
  |
    expressio op_suma expressio
	{creaNode($$, $1, $3, Suma, Expressio);}
  |
    expressio op_resta expressio
	{creaNode($$, $1, $3, Resta, Expressio);}
  |
    expressio op_multiplicacio expressio
	{creaNode($$, $1, $3, Mult, Expressio);}
  |
    expressio op_divisio expressio
	{creaNode($$, $1, $3, Div, Expressio);}
  |
    expressio pc_mod expressio
	{creaNode($$, $1, $3, Modul, Expressio);}
  |
    op_resta expressio   %prec menys_unitari
	{creaNode($$, $2, Resta, ExpressioUnaria);} 
  |
    s_parentesiobert expressio s_parentesitancat -- Hacer funcion que implique paso de punteros 
  |
    referencia
	{creaNode($$, $1, Referencia);}
  |
    const
	{creaNode($$, $1, Const);}
  ;
  
  
%%


package pk_usintactica is

    procedure yyparse;
    

end pk_usintactica;



with	pk_usintactica_tokens,
        pk_usintactica_shift_reduce,
        pk_usintactica_goto,
    	pk_ulexica_io,
    	u_lexica,
		decls.d_arbre,
		decls.dtnode,
      	Ada.text_IO;

use		pk_usintactica_tokens,
    	pk_usintactica_shift_reduce,
    	pk_usintactica_goto,
    	pk_ulexica_io,
    	u_lexica,
		decls.d_arbre,
		decls.dtnode,
    	Ada,
    	ada.text_io;
        

package body pk_usintactica is
	
    procedure YYError (e : in string) is
		
			
    
    begin
        
        Put_Line(e);
        raise Syntax_Error;
    
    end YYError;
    
##

end pk_usintactica;
  

