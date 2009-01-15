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
	
		descnula :  descrip( dnula);
		
	begin
		
		ts.nprof := 1;
		ts.tbloc(ts.nprof) := 0;
		
		for i in 1 .. id_nom'Last loop
		
			ts.tdesc(i) := ( 0, descnula, -1);
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
			
			ts.tdespl(idespl) := (ts.tdesc(id).np, ts.tdesc(id).d, id, 0);
			
			ts.tdesc(id) := (ts.nprof, d, 0);
		end if;
	
	end posa;
	
	
	function cons (ts: in tsimbols;
					id: in id_nom) return descrip is
					
	begin
	
		return ts.tdesc(id).d;
	
	end cons;
	
	
	
	-- VERSIO 2: Normal, llenguatge amb blocs estil Pascal.
	procedure entrabloc (ts: in out tsimbols) is
	
	begin
	
		ts.nprof := ts.nprof + 1;
		ts.tbloc(ts.nprof) := ts.tbloc(ts.nprof - 1);
	
	end entrabloc;
	
	
	procedure surtbloc (ts: in out tsimbols) is
	
		idespl1 : rang_despl;
		idespl2 : rang_despl;
		id : id_nom;
		
	begin
	
		idespl1 := ts.tbloc(ts.nprof);
		ts.nprof := ts.nprof - 1;
		idespl2 := ts.tbloc(ts.nprof) + 1;
		
		-- PRUEBA: Si peta mirar aquí
		for idespl in reverse idespl1 .. idespl2 loop
			if ts.tdespl(idespl).np >= 0 then
				id := ts.tdespl(idespl).id;
				ts.tdesc(id).d := ts.tdespl(idespl).d;
				ts.tdesc(id).np := ts.tdespl(idespl).np;
				ts.tdesc(id).s := ts.tdespl(idespl).s;
			end if;
		end loop;
	
	end surtbloc;
	
	
	
	-- VERSIO 3: Blocs més records.
	procedure posacamp (ts: in out tsimbols;
						idr: in id_nom;
						idc: in id_nom;
						  d: in descrip;
						  e: out boolean) is
						  
	   des: descrip;
		td : descriptipus;
		 p : rang_despl;
   itdespl : rang_despl;
	
	begin
	
		des := ts.tdesc(idr).d;
		
		if des.td /= dtipus then e := TRUE; end if;
		
		 td := des.dt;
		
		if td.tt /= tsrec then e := TRUE; end if;
		
		p := ts.tdesc(idr).s;
		while p /= 0 and then ts.tdespl(p).id /= idc loop
			p := ts.tdespl(p).s;
		end loop;
		
		e := (p /= 0);
		if not e then
		
			ts.tbloc(ts.nprof) := ts.tbloc(ts.nprof) + 1;
			itdespl := ts.tbloc(ts.nprof);
			-- ALERTA AMB EL -1 !!!!!
			
			ts.tdespl(itdespl) := (-1, d, idc, ts.tdesc(idr).s);
		end if;
		
	end posacamp;
	
	
	function conscamp (ts: in tsimbols;
					   idr: in id_nom;
					   idc: in id_nom) return descrip is
					   
		 d : descrip;
		td : tdescrip;
		 p : rang_despl;
  descnula :  descrip( dnula);
					   
	begin
	
		d := ts.tdesc(idr).d;
		td := d.td;
		
		p := ts.tdesc(idr).s;
		while p /= 0 and then ts.tdespl(p).id /= idc loop
			p := ts.tdespl(p).s;
		end loop;
		
		if p = 0 then
			return  descnula;
		else
			return ts.tdespl(p).d;
		end if;
	
	end conscamp;
	
	
	
	-- VERSIO 4: Arrays.
	procedure posa_idx (ts: in tsimbols;
						ida: in id_nom;
						idi: in id_nom;
						  e: out boolean) is
						
	     d : descrip;
	    dt : descriptipus;
	     p : rang_despl;
	    pp : rang_despl;
	    idespl : rang_despl;
						
	begin
	
	    d := ts.tdesc(ida).d;
	    if d.td /= dtipus then e := TRUE; end if; -- Introduir control d'errors
	    
        dt := d.dt;
		
        if dt.tt /= ts then e := TRUE; end if; -- Introduir control d'errors   
        
        p := ts.tdesc(ida).s;
		
        while p /= 0 loop -- Comprovar el 0
            pp := p;
            p := ts.tdespl(p).s;
        end loop;
        
        ts.tbloc(ts.nprof) := ts.tbloc(ts.nprof) + 1;
        idespl := ts.tbloc(ts.nprof);
		
        ts.tdespl(idespl) := ( -1, dnula,idi, 0);
        
        if pp = 0 then
            ts.tdesc(ida).s := idespl;
        else
            ts.tdespl(pp).s := idespl;
        end if;        
	
	end posa_idx;
	
	function idx_valid (ci: in cursor_idx) return boolean is
	
	
	begin
	
		return ci > 0; --Esto es asi , porque el rango de cursor va de 0 a rang despl pero el 0 lo utilizamos como nulo 
	
	end idx_valid;
	
	function primer_idx (ts: in tsimbols;
						 ida: in id_nom) return cursor_idx is
	
	begin
	
		return cursor_idx(ts.tdesc(ida).s);
	
	end primer_idx;
	
	function succ_idx (ts: in tsimbols;
						ci: in cursor_idx) return cursor_idx is
	
	begin
	
		if idx_valid(ci) then --Falta saber que pasaria si no es compleix
			return cursor_idx(ts.tdespl(rang_despl(ci)).s);
		else 
			return 0;
		end if;
		
	
	end succ_idx;
	
	function cons_idx (ts: in tsimbols;
						ci: cursor_idx) return id_nom is
	
	
	begin
	
		return  ts.tdespl(rang_despl(ci)).id;
	
	
	end cons_idx;
	
	
	
	
	
	
	

end decls.dtsimbols;
