-- Macros

lletra [A-Za-z]

digit [0-9]

separadors [\n\b\t\f]

caracter \'[^\'\n\t]\'



%%



-- Paraules clau



procediment		{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_procediment;} 


inici			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_inici;}


mentre			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_mentre;}


per				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_per;}


entre			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_entre;}


si				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_si;}


sino			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_sino;}


fi				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_fi;}


fer				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_fer;}


const			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_constant;}


tipus			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_tipus;}


coleccio		{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_coleccio;}


registre		{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_registre;}


es				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_es;}



llavors			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_llavors;}


no				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_no;}


opcio			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_opcio;}


casos			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_casos;}


entra			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_entra;}


surt			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_surt;}


nou				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_nou;}


nul				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_nul;}


de				{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_de;}


modul			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_modul;}


rang			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_rang;}


"||"			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_or;}


"&&"			{mt_pclau(tok_begin_line, tok_begin_col, yylval); 
				return pc_and;}



--SUBTIPUS

--Simbols 

":="		{mt_simbol(tok_begin_line, tok_begin_col, asignacio, yylval); 
			return s_asignacio;}


":"			{mt_simbol(tok_begin_line, tok_begin_col, dospunts, yylval); 
			return s_dospunts;}


";"			{mt_simbol(tok_begin_line, tok_begin_col, final, yylval); 
			return s_final;}


","			{mt_simbol(tok_begin_line, tok_begin_col, coma, yylval); 
			return s_coma;}


"("			{mt_simbol(tok_begin_line, tok_begin_col, parentesiobert, yylval);
			return s_parentesiobert;}


")"			{mt_simbol(tok_begin_line, tok_begin_col, parentesitancat, yylval);
			return s_parentesitancat;}



".."		{mt_simbol(tok_begin_line, tok_begin_col, puntsrang, yylval); 
			return s_puntsrang;}





--Operadors



"<"			{mt_operador(tok_begin_line, tok_begin_col, menor, yylval); 
			return op_menor;}


"<="		{mt_operador(tok_begin_line, tok_begin_col, menor_igual, yylval);
			return op_menorigual;}


">="		{mt_operador(tok_begin_line, tok_begin_col, major_igual, yylval);
			return op_majorigual;}


">"			{mt_operador(tok_begin_line, tok_begin_col, major, yylval); 
			return op_major;}


"="			{mt_operador(tok_begin_line, tok_begin_col, igual, yylval); 
			return op_igual;}


"/="		{mt_operador(tok_begin_line, tok_begin_col, diferent, yylval); 
			return op_distint;}


"+"			{mt_operador(tok_begin_line, tok_begin_col, suma, yylval); 
			return op_suma;}


"-"			{mt_operador(tok_begin_line, tok_begin_col, resta, yylval); 
			return op_resta;}


"*"			{mt_operador(tok_begin_line, tok_begin_col, multiplicacio, yylval);
			return op_multiplicacio;}


"/"			{mt_operador(tok_begin_line, tok_begin_col, divisio, yylval); 
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

	tn : taula_de_noms;

	function YYLex return token;
	
end u_lexica;



package body u_lexica is

##

begin

	tbuida(tn);

end u_lexica;

