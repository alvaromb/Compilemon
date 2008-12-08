-- Macros

lletra [A-Za-z]

digit [0-9]

separadors [\n\b\t\f]

caracter \'[^\'\n\t]\'



%%



-- Paraules clau

procediment		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_procediment;} 

inici			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_inici;}

mentre			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_mentre;}

per				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_per;}

entre			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_entre;}

si				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_si;}

sino			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_sino;}

fi				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_fi;}

fer				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_fer;}

const			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_constant;}

tipus			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_tipus;}

coleccio		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_coleccio;}

registre		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_registre;}

es				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_es;}

llavors			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_llavors;}

no				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_no;}

opcio			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_opcio;}

casos			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_casos;}

entra			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_entra;}

surt			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_surt;}

nou				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_nou;}

nul				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_nul;}

de				{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_de;}

modul			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_modul;}

rang			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_rang;}

"||"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_or;}

"&&"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
				return pc_and;}


--SUBTIPUS

--Simbols 

":="		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return s_asignacio;}

":"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return s_dospunts;}

";"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return s_final;}

","			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return s_coma;}

"("			{mt_atom(tok_begin_line, tok_begin_col, yylval);
			return s_parentesiobert;}

")"			{mt_atom(tok_begin_line, tok_begin_col, yylval);
			return s_parentesitancat;}

".."		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return s_puntsrang;}


--Operadors

"<"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_menor;}

"<="		{mt_atom(tok_begin_line, tok_begin_col, yylval);
			return op_menorigual;}

">="		{mt_atom(tok_begin_line, tok_begin_col, yylval);
			return op_majorigual;}

">"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_major;}

"="			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_igual;}

"/="		{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_distint;}

"+"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_suma;}

"-"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_resta;}

"*"			{mt_atom(tok_begin_line, tok_begin_col, yylval);
			return op_multiplicacio;}

"/"			{mt_atom(tok_begin_line, tok_begin_col, yylval); 
			return op_divisio;}



--EXPRESSIONS REGULARS

--Digit

{digit}+	{mt_numero(tok_begin_line, tok_begin_col,yytext, yylval);
			return const;}
			
			
--Lletra

{caracter}	{mt_caracter(tok_begin_line, tok_begin_col,yytext, yylval); 
			return const;}
			

--Identificador

{lletra}({digit}|{lletra})*	{mt_identificador(tok_begin_line, tok_begin_col,
							yytext, yylval); return id;}


--String

\"[^\"\n\t]*\"	{mt_string(tok_begin_line, tok_begin_col, yytext, yylval);
				return cadena;}


--Comentaris

"-""-"[^\n]*	{null;}


--Separadors

" "				{null;}

{separadors}	{null;}


--Error

.			{return error;}



%%



with	decls.d_taula_de_noms,
		d_atribut,
		d_token;
		

use		decls.d_taula_de_noms,
		d_atribut,
		d_token;


package u_lexica is

	yylval : atribut;

	function YYLex return token;
	
end u_lexica;



package body u_lexica is

##

--begin

--	tbuida(tn);

end u_lexica;

