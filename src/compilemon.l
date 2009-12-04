-- Macros

lletra		[A-Za-z]
digit		[0-9]
separadors	[\n\b\t\f]
caracter	\'[^\n\t]\'


%%


-- Paraules clau

procedure	{mt_atom(tok_begin_line, tok_begin_col,
		yylval); return pc_procedure;} 

begin		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_begin;}

while		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_while;}

if	   	{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_if;}

else		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_else;}

end		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_end;}

loop		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_loop;}

constant	{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_constant;}

type		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_type;}

array		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_array;}

record		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_record;}

is		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_is;}

then		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_then;}

not		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_not;}

in		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_in;}

out		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_out;}

new		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_new;}

null		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_null;}

of		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_of;}

mod		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_mod;}

range  		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_range;}

and		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_or;}

or		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return pc_and;}


--Simbols 

":="		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_assignacio;}

":"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_dospunts;}

";"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_final;}

","		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_coma;}

"("		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_parentesiobert;}

")"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_parentesitancat;}

".."		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_puntsrang;}
		
"."		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return s_puntrec;}


--Operadors

"<"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_menor;}

"<="		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_menorigual;}

">="		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_majorigual;}

">"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_major;}

"="		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_igual;}

"/="		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_distint;}

"+"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_suma;}

"-"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_resta;}

"*"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_multiplicacio;}

"/"		{mt_atom(tok_begin_line, tok_begin_col, 
		yylval); return op_divisio;}


--Digit

{digit}+	{mt_numero(tok_begin_line, tok_begin_col,
		yytext, yylval); return const;}
			
			
--Lletra

{caracter}	{mt_caracter(tok_begin_line, tok_begin_col,
		yytext, yylval); return const;}


--String

\"[^\"\n\t]*\"	{mt_string(tok_begin_line, tok_begin_col, 
		yytext, yylval); return const;}


--Identificador

{lletra}({digit}|{lletra})* 
		{mt_identificador(tok_begin_line, 
                tok_begin_col, yytext, yylval);
                return id;}



--Comentaris

"--"[^\n]*	{null;}


--Separadors

" "		{null;}

{separadors}*	{null;}


--Error

.	{return error;}



%%



with	decls.d_taula_de_noms,
	d_token,
	decls.d_atribut;


use	decls.d_taula_de_noms,
	d_token,
	decls.d_atribut;


package u_lexica is

	yylval: atribut;
	tn : taula_de_noms;
	function YYLex return token;

end u_lexica;



package body u_lexica is

##

begin

	tbuida(tn);

end u_lexica;

