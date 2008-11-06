--------------------------------------------------------------------------------
--  *  Prog name compilemon.adb
--  *  Project name compilemon
--  *
--  *  Version 1.0
--  *  Last update 22/10/08
--  *
--  *  Created by Biel Moyà Alcover on 22/10/08.
--  *  Copyright (c) 2008 __MyCompanyName__.
--  *  All rights reserved.
--  *    or (keep only one line or write your own)
--  *  GNAT modified GNU General Public License
--  *
--------------------------------------------------------------------------------
with Ada.Text_IO;use Ada.Text_IO;
with decls.d_taula_de_noms; use decls.d_taula_de_noms;
with decls.dgenerals; use decls.dgenerals;
procedure compilemon is

	tn : taula_de_noms;
	id: id_nom;
begin
	
	New_Line(3);
	tbuida(tn);
	posa(tn,id,"nili");
	Put_line("Resultado nili: "&id'img);
	Put_line("__________________");
	posa(tn,id,"bili");
	Put_line("Resultado bili: "&id'img);
	Put_line("__________________");
	posa(tn,id,"pepua");
	Put_line("Resultado pepua : "&id'img);
	Put_line("__________________");
	posa(tn,id,"nili");
	Put_line("Resultado nili : "&id'img);
	Put_line("__________________");
	posa(tn,id,"alvaro");
	Put_line("Resultado alvaro : "&id'img);
	Put_line("__________________");
	posa(tn,id,"bili");
	Put_line("Resultado bili: "&id'img);
	Put_line("__________________");
	Put("Taula de caracters:  ");imprimir_tcar(tn,4);
	
	New_line;
	New_line;
	Put_Line(cons(tn, 0));
	Put_Line(cons(tn, 1));
	
end compilemon;
