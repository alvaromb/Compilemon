-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio	:	0.2
--  Autors	:	Jose Ruiz Bravo
--				Biel Moya Alcover
--				Alvaro Medina Ballester
-- ------------------------------------------------
--		Implementacio dels procediments per al
--	tractament de la taula de noms:
--
--			- Buidat de la taula
--			- Insercio
--			- Insercio d'strings
--			- Consulta
--
-- ------------------------------------------------


package body decls.d_taula_de_noms is

	-- Donam els valors per defecte de cada camp, sempre 
	-- que un camp no sigui utilitzat valdra 0.
	procedure tbuida (tn : out taula_de_noms) is
	
	begin 
	
		for i in tn.td'range loop
			tn.td(i) := id_nul;
		end loop;
		
		tn.nid := 1;
		tn.ncar := 0;
		
		tn.tid(1).seguent := id_nul;
		
	end tbuida;
	
	
	
	function par_iguals (par1, par2 : in string) return boolean is
	
		it_p1 : integer;
		it_p2 : integer;
		
	begin
			
		if par1'Length = par2'Length then
			
			it_p1 := par1'First;
			it_p2 := par2'First;
						
			while it_p1 < par2'Length and par2(it_p2) = par1(it_p1) loop
				it_p1 := it_p1 + 1;
				it_p2 := it_p2 + 1;
			end loop;
	
			if par1(it_p1) = par2(it_p2) then
				return true;
			end if;
			
		end if;
		
		return false;
	
	end par_iguals;
		


	procedure posa_id 	(tn : in out taula_de_noms; 
					   	idn : out id_nom; 
					   	nom : in string) is
		
		-- Variable per el valor de la funcio de dispersio.
		p_tid : rang_dispersio;
		
		-- Índexos per recorrer la taula d'identificadors.
		idx : id_nom;
		idx_ant: id_nom; 
		
		-- Índex per recorrer la taula de caracters.
		jdx : rang_tcar; 
		
		p : taula_identificadors renames tn.tid;
		
	begin
	
		p_tid := fdisp_tn(nom);
		
		-- Control d'errors
		if tn.nid = id_nul then
			raise E_Tids_Plena;
		end if;
		
		if (tn.ncar + nom'Length) > rang_tcar'Last then
			raise E_Tcar_Plena;
		end if;

		if tn.td(p_tid) = id_nul then
			tn.td(p_tid) := tn.nid;
		end if;
		
		idx := tn.td(p_tid);

		while idx /= id_nul and then not par_iguals(nom, cons_nom(tn, idx)) loop
			 
			 if p(idx).seguent = id_nul then
				idx_ant := idx;
			 end if;
			 
			 idx := p(idx).seguent;	 
			
		end loop;
		
		if idx = id_nul then

			idn := tn.nid;
			tn.tid(idx_ant).seguent := idn;
			
			-- Apuntam a la primera posicio buida de la taula de caracters
			tn.tid(idn).pos_tcar := tn.ncar; 
			tn.tid(idn).long_paraula := nom'Length;
			tn.tid(idn).seguent := id_nul;
			tn.nid := tn.nid + 1;
			-- Omplim la taula de caracters, desde la primera 
			-- posicio lliure 'ncar'.
			jdx := tn.ncar;
			
			for i in 1..nom'Length loop
				tn.tc(jdx) := nom(i);
				jdx := jdx + 1;
			end loop;
			
			jdx := jdx + 1;
			tn.tc(jdx) := '$';
			
			-- Apuntam a la primera posicio lliure de la taula 
			-- de caracters.
			tn.ncar := jdx + 1; 
			
		else
			idn := idx;
			
		end if;
		
	end posa_id;
	
	
	
	procedure posa_str 	(tn : in out taula_de_noms; 
							ids : out rang_tcar; 
							  s : in string) is
	
		-- Index per recorrer la taula de caracters.
		jdx : rang_tcar; 
		
	begin

		-- Excepcio per a controlar tc plena
		if (tn.ncar + s'Length) > rang_tcar'Last then
			raise E_Tcar_Plena;
		end if;
	
		-- Omplim la taula de caracters, desde la primera 
		-- posicio lliure 'ncar'.
		jdx := tn.ncar;
		ids := tn.ncar;
		
		for i in 1..s'Length loop
				
			tn.tc(jdx) := s(i);
			jdx := jdx + 1;
				
		end loop;
		
		tn.ncar := jdx + 1;
		tn.tc(jdx) := '$';

	
	end posa_str;
	
	
	
	function cons_nom (tn : in taula_de_noms; idn : in id_nom) return string is
		
	begin
	
		return string(tn.tc(tn.tid(idn).pos_tcar .. tn.tid(idn).pos_tcar+rang_tcar(tn.tid(idn).long_paraula)-1));
		
	end cons_nom;	
	
	
	
	function cons_str	(tn : in taula_de_noms; ids : in rang_tcar) return string is
	
		idx : rang_tcar;
		
	begin
		
		idx := ids;
	
		while (tn.tc(idx) /= '$') loop
			
			idx := idx+1;
		end loop;
		
		return string(tn.tc(ids..idx-1));
		
	end cons_str;
				

end decls.d_taula_de_noms;
