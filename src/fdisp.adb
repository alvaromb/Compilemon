-- ------------------------------------------------
--  Funció de hash de Pearson
-- ------------------------------------------------
--  Versió			:	0.1
--  Autors			:	José Ruiz Bravo
--						Biel Moyà Alcover
--						Álvaro Medina Ballester
-- ------------------------------------------------
--		El hash de Pearson és una funció molt
--	simple que s'executa ràpidament. S'utilitza
--	un array de 256 posicions emplenat amb
--	nombres aleatoris de 0 a 255. En aquest 
--	algoritme no s'empren ni instruccions SHIFT 
--  ni XOR.
--
-- ------------------------------------------------

with Ada.Integer_text_io;
use Ada.Integer_text_io;

function fdisp (nom: in string) return integer is
	
	-- Vector generat de forma aleatòria per
	-- executar la funció de hash.	
	type vector is array (0..255) of integer;
	v: constant vector := (240,208,16,192,129,5
							,2,0,184,9,10,11,4,13
							,90,15,80,17,137,19,20
							,7,22,23,140,25,26,27
							,180,29,6,31,160,33,34
							,35,18,37,38,39,152,41
							,14,43,44,45,46,47,176
							,49,50,51,52,53,54,55
							,8,57,58,59,12,61,62
							,21,200,65,66,67,108
							,69,70,71,120,73,74
							,75,76,77,78,79,84,81
							,82,83,42,85,86,87,232
							,89,30,91,92,93,94,95
							,32,97,98,99,204,101
							,102,103,88,105,106,107
							,36,109,110,111,136,113
							,114,115,116,117,118
							,119,188,121,122,123
							,124,125,63,127,128,1
							,130,3,132,133,134,135
							,56,131,138,139,28,141
							,142,143,40,145,146,147
							,220,149,150,151,168
							,153,154,155,156,157
							,158,159,96,161,162
							,163,164,165,166,167
							,104,169,170,171,172
							,173,174,175,112,177
							,178,179,60,181,182
							,183,248,185,186,187
							,148,189,190,191,64
							,193,194,195,196,197
							,198,199,100,201,202
							,203,68,205,206,207,48
							,209,210,211,212,213
							,214,215,24,217,218
							,219,244,221,222,223
							,224,225,226,227,228
							,229,230,231,216,233
							,234,235,236,237,238
							,239,144,241,242,243
							,252,245,246,247,72
							,249,250,251,126,253
							,254,255);
							
	-- Variable amb la clau de hash que hem de retornar
	hash: integer := 0;
	
	-- Variable per recollir el valor del caràcter
	val: integer := 0;
	
begin

	for i in 0..nom'Length-1 loop
		hash := (hash + character'POS(nom(i))) mod 256;
		hash := v(hash);
	end loop;
	
	hash := hash mod 111;
	
	return hash;

end fdisp;	