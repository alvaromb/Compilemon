-- ------------------------------------------------
--  Procediments taula de simbols
-- ------------------------------------------------
--  Versio	:	0.1
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Procediments per tractar la taula de
--      símbols:
--			- Taula buida
--			- Posa
--			- Consulta
--			- Entra bloc
--			- Surt bloc
--			- Posa camp
--			- Consulta camp
--			- Posa índex
--			- Primer índex
--			- Successor índex
--			- Índex vàlid?
--			- Consulta índex
--			- Posa argument
--			- Primer argument
--			- Successor argument
--			- Argument vàlid?
--			- Consulta argument
--			- Actualitza
--
-- ------------------------------------------------

package body decls.dtsimbols is

	-- VERSIO 1: llenguatge simple sense estructura 
	-- de blocs estil Fortran.
	procedure tbuida (ts: out tsimbols) is
	
	begin
		
		ts.nprof := 1;
		ts.tbloc(ts.nprof) := 0;
		
		for i in id_nom'Range loop
			ts.tdesc(i).np := 0;
			ts.tdesc(i).d := dnula;
		end loop;
	
	end tbuida;
	
	
	procedure posa (ts: in out tsimbols;
					 id: in id_nom;
					  d: in descrip;
					  e: out boolean) is
					  
		idespl: rang_despl;
	
	begin
	
		e := (ts.tdesc(id).np = ts.nprof);
		
		if not e then
			ts.tbloc(ts.nprof) := ts.tbloc(ts.nprof) + 1;
			idespl := ts.tbloc(ts.nprof);
			
			ts.tdespl(idespl).np := id;
			ts.tdespl(idespl).d := ts.tdesc(id).np;
			ts.tdespl(idespl).id := ts.tdesc(id).d;
			
			ts.tdesc(id).np := ts.nprof;
			ts.tdesc(id).d := d;
		end if;
	
	end posa;
	
	
	function cons (ts: in tsimbols;
					id: in id_nom) return descrip is
					
	begin
	
		return ts.tdesc(id).d;
	
	end cons;
	

end decls.dtsimbols;
