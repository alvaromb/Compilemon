lletra [A-Za-z]
digit [0-9]


%%

-- Paraules clau
procediment		{return pc_procediment;}
funcio			{return pc_funcio;}
inici			{return pc_inici;}
mentre			{return pc_mentre;}
per			{return pc_per;}
si			{return pc_si;}
sino			{return pc_sino;}
fi			{return pc_fi;}
fer			{return pc_fer;}
retorna			{return pc_retorna;}
constant		{return pc_constant;}
tipus			{return pc_tipus;}
coleccio		{return pc_coleccio;}
registre		{return pc_registre;}
es			{return pc_es;}
llavors			{return pc_llavors;}
no			{return pc_no;}
opcio			{return pc_opcio;}
casos			{return pc_casos;}
entra			{return pc_entra;}
surt			{return pc_surt;}
nou			{return pc_nou;}
nul			{return pc_nul;}
excepcio		{return pc_excepcio;}
sortida			{return pc_sortida;}
de			{return pc_de;}
caracter		{return pc_caracter;}

-- Subtipus

-- Simbols clau
"||"			{return s_or;}

-- Expressions regulars
{lletra}({digit}|{lletra})*	{put_line("Hem trobat un identificador");}

%%

with compilemon_dfa; use compilemon_dfa;
with compilemon_io;  use compilemon_io;
with d_token;use d_token;
package u_lexica is
	
	function YYLex return token;
	
end u_lexica;

package body u_lexica is
##
end u_lexica;
