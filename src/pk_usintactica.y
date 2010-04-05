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
%with decls.d_atribut, decls.dtnode, decls.dgenerals;
%use decls.d_atribut, decls.dtnode, decls.dgenerals;
{
	subtype yystype is decls.d_atribut.atribut;

}


%%


--Produccions de la gramatica del llenguatge
programa:
    M1 dec_procediment 
	{creaNode_programa($$, $1, $2, programa);}
  ;
  
M1: 
    {creaNode($$, tnul);}
  ;

dec_procediment:
    pc_procedure encap pc_is
        declaracions
    pc_begin
        bloc
    pc_end id s_final 
    {creaNode_ID($8, $8, identificador);
     creaNode($$, $2, $4, $6, $8, procediment);}
  ;


encap:
    id
    {creaNode_ID($$, $1, identificador);}
  |
    pencap s_parentesitancat
    {Remunta($$, $1);}
  ;
  
pencap:
    pencap s_final param
    {creaNode($$, $1, $3, pencap);}
  |
    id s_parentesiobert param
    {creaNode_ID($1, $1, identificador);
     creaNode($$, $1, $3, pencap);}
  ;
  
param:
    id s_dospunts mode id
    {creaNode_ID($1, $1, identificador);
     creaNode_ID($4, $4, identificador);
     creaNode($$, $1, $3, $4, Param);}
  ;

  
mode:
    pc_in
    {creanode_mode($$, entra, mode);}
  |
    pc_out
    {creanode_mode($$, surt, mode);}
  |
    pc_in pc_out
    {creanode_mode($$, entrasurt, mode);}
  ;
  
declaracions:
    declaracions declaracio
    {creaNode($$, $1, $2, declaracions);}
  |
    {creaNode($$, tnul);}
  ;
  

-- DECLARACIONS
declaracio:
    dec_var s_final
    {Remunta($$, $1);}
  |
    dec_constant s_final
    {Remunta($$, $1);}
  |
    dec_tipus s_final
    {Remunta($$, $1);}
  |
    dec_procediment 
    {Remunta($$, $1);}
  ;
  
dec_var:
    id c_decl_var
    {creaNode_ID($1, $1, identificador);
     creaNode($$, $1, $2, dvariable);}
  ;
  
c_decl_var:
    s_dospunts id 
    {creaNode_ID($2, $2, identificador);
     remunta($$, $2);} 
  |
    s_coma id c_decl_var
    {creaNode_ID($2, $2, identificador);
     creaNode($$, $2, $3, declmultvar);}
  ;

dec_constant:
    id s_dospunts pc_constant id s_assignacio val
    {creaNode_ID($1, $1, identificador);
     creaNode_ID($4, $4, identificador);
     creaNode($$, $1, $4, $6, dconstant);}
  ;
 
-- TIPUS
dec_tipus:
    decl_coleccio
    {Remunta($$, $1);}
  |
    decl_registre
    {Remunta($$, $1);}
  | 
    decl_subrang
    {Remunta($$, $1);}
  ;
  
  
-- TIPUS SUBRANG
decl_subrang:
    pc_type id pc_is pc_new id pc_range val
    s_puntsrang val
    {creaNode_ID($2, $2, identificador);
     creaNode_ID($5, $5, identificador);
     creaNode($$, $2, $5, $7, $9, dsubrang);} 
  ;

val:
    const
    {creaNode_VAL($$, $1, const, 1);}
  |
    op_resta const
    {creaNode_VAL($$, $2, const, 0);}
  ;

limit:
    const
    {creaNode_VAL($$, $1, Const, 1);}
  | 
    op_resta const
    {creaNode_VAL($$, $2, const, 0);}
  |
    id
    {creaNode_ID($$, $1, identificador);}
  ;
    
  
-- TIPUS REGISTRE
decl_registre:
    p_dregistre pc_end pc_record
    {Remunta($$, $1);}
  ;
  
p_dregistre: 
    p_dregistre id s_dospunts id s_final
    {creaNode_ID($2, $2, identificador);
     creaNode_ID($4, $4, identificador);
     creaNode($$, $1, $2, $4, dencapregistre);}
  | 
    pc_type id pc_is pc_record id s_dospunts id s_final
    {creaNode_ID($2, $2, identificador);
     creaNode_ID($5, $5, identificador);
     creaNode_ID($7, $7, identificador);
     creaNode($$, $2, $5, $7, Dregistre);}
  ;
  

-- TIPUS COLECCIO
decl_coleccio:
    p_dcoleccio s_parentesitancat pc_of id 
    {creaNode_ID($4, $4, identificador);
     creaNode($$, $1, $4, Dcoleccio);}
  ;
  
p_dcoleccio:
    p_dcoleccio s_coma id
    {creaNode_ID($3, $3, identificador);
     creaNode($$, $1, $3, Pcoleccio);}
  |
    pc_type id pc_is pc_array s_parentesiobert id
    {creaNode_ID($2, $2, identificador);
     creaNode_ID($6, $6, identificador);
     creaNode($$, $2, $6, Pdimcoleccio);}
  ;

  
-- BLOC D'INSTRUCCIO
bloc:
    bloc sentencia s_final
     {creaNode($$, $1, $2, bloc);}
    
  | 
    sentencia s_final
     {Remunta($$, $1);}
  ;
  
  
-- SENTENCIES D'INSTRUCCIONS
sentencia: 
    sassig
    {Remunta($$, $1);}
  |
    scond
    {Remunta($$, $1);} 
  |
    srep
    {Remunta($$, $1);}
  | 
    crida_proc
    {Remunta($$, $1);}
  ; 

-- Sentencia assignacio
sassig:
    referencia s_assignacio expressio
    {creaNode($$, $1, $3, assignacio);}
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
    {Remunta($$, $1);} 
  ;

referencia:
    id
    {creaNode_ID($$, $1, identificador);}
  |
    referencia s_puntrec id
    {creaNode_ID($3, $3, identificador);
     creaNode($$, $1, $3, referencia);}
  |
    pri s_parentesitancat
    {Remunta($$, $1);}
  ;
  
pri:
    referencia s_parentesiobert expressio
    {creaNode($$, $1, $3, encappri);}
    
  |
    pri s_coma expressio
    {creaNode($$, $1,$3,pri);}
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
    s_parentesiobert expressio s_parentesitancat 
    {Remunta($$, $2);}
  |
    referencia
    {Remunta($$, $1);}
  |
    const
    {creaNode_VAL($$, $1, Const, 1);}
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

use	pk_usintactica_tokens,
    	pk_usintactica_shift_reduce,
    	pk_usintactica_goto,
    	pk_ulexica_io,
    	u_lexica,
	decls.d_arbre,
	decls.dtnode,
        ada, --no llevar mai
    	ada.text_io;
        

package body pk_usintactica is
	
    procedure YYError (e : in string) is
    
    begin
        
  -- Aixo ho haurem de millorar un poc
        Put_Line(e);
        raise Syntax_Error;
    
    end YYError;
    
##

end pk_usintactica;
  

