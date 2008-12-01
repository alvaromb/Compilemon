-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versió		:	0.1
--  Autors		:	José Ruiz Bravo
--					Biel Moyà Alcover
--					Álvaro Medina Ballester
-- ------------------------------------------------
--		Implementació dels procediments per al
--	tractament de la taula de noms:
--
--			- Buidat de la taula
--			- Inserció
--			- Inserció d'strings
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
		
		for i in tn.tid'range loop
			tn.tid(i).pos_tcar := 0;
			tn.tid(i).seguent := id_nul; 
			tn.tid(i).long_paraula 	:= 0;
		end loop;
		
		for i in tn.tc'range loop
			tn.tc(i) := '$';
		end loop;
		
		tn.nid := 0;
		tn.ncar := 0;
		
	end tbuida;
	


	procedure posa_id (tn : in out taula_de_noms;  idn : out id_nom; nom : in string) is
		
		-- Variable per el valor de la funció de dispersió.
		p_tid : rang_dispersio := 0;
		
		-- Índex per recorrer la taula d'identificadors.
		idx : id_nom ; 
		
		-- Índex per recorrer la taula de caracters.
		jdx : rang_tcar; 
		
		p_car : rang_tcar := 0;
		rec : Natural:= 1;
		
		iguals : boolean := false;
		seguent : boolean := true;
		
	begin
	
		if tn.nid = id_nul then
			raise E_Tids_Plena;
		end if;
		
		if (tn.ncar + nom'Length) > rang_tcar'Last then
			raise E_Tcar_Plena;
		end if;
	
		p_tid :=  fdisp_tn(nom);
		
		-- Si es la primera vegada que la funcio de dispersió
		-- ens dona aquest valor, asignam a aquesta posició el
		-- darrer lloc de la taula d'identificadors.
		if tn.td(p_tid) = id_nul then 
		
			tn.td(p_tid):=tn.nid; 
			idx:=tn.nid;
			
		-- Sino, cercam la primera posicio buida a través 
		-- del camp seguent.
		else
		
			idx := tn.td(p_tid);
			
			while seguent and not iguals loop
				
				if tn.tid(idx).long_paraula = nom'Length then
				
					p_car := tn.tid(idx).pos_tcar;
						
					while  rec < tn.tid(idx).long_paraula  and tn.tc(p_car) = nom(rec) loop
						p_car := p_car+1;
						rec := rec+1;
					end loop;
					
					if tn.tc(p_car) = nom(rec) then
						idn := idx;
						iguals := true;
					end if;
					
				end if;
				
				if not iguals and tn.tid(idx).seguent = id_nul then
					
					seguent := false;
					tn.tid(idx).seguent := tn.nid;
					idx := tn.nid;
					
				elsif not iguals  and tn.tid(idx).seguent /= id_nul then
				 
					 idx := tn.tid(idx).seguent ;
				 
				end if;
							
			end loop;
			
		end if;
		
		
		if not iguals then
			
			idn := tn.nid;
			
			if tn.nid = id_nom'Last then
				tn.nid := id_nul;
			else 
				tn.nid := tn.nid + 1;
			end if;
			
			-- Apuntam a la primera posicio buida de la taula de caracters
			tn.tid(idn).pos_tcar := tn.ncar; 
			tn.tid(idn).long_paraula := nom'Length;
			
			-- Omplim la taula de caracters, desde la primera 
			-- posicio lliure 'ncar'.
			jdx := tn.ncar;
			
			for i in 1..nom'Length loop
				
				tn.tc(jdx) := nom(i);
				jdx := jdx + 1;
				
			end loop;
			
			-- Apuntam a la primera posicio lliure de la taula 
			-- de caracters.
			tn.ncar := jdx+1; 
		
		end if;
		
	end posa_id;
	
	
	
	procedure posa_str (tn : in out taula_de_noms; idn : out id_nom; s : in string) is
	
		-- Índex per recorrer la taula de caracters.
		jdx : rang_tcar; 
		
	begin
		
		if tn.nid = id_nul then
			raise E_Tids_Plena;
		end if;
		
		if (tn.ncar + s'Length) > rang_tcar'Last then
			raise E_Tcar_Plena;
		end if;
	
		-- Primera posició buida de la taula d'identificadors.
		idn := tn.nid;
		
		tn.nid := tn.nid+1; 
		tn.tid(idn).long_paraula := s'Length;
		tn.tid(idn).pos_tcar := tn.ncar;
		
		
		-- Omplim la taula de caracters, desde la primera 
		-- posicio lliure 'ncar'.
		jdx := tn.ncar;
		
		for i in 1..s'Length loop
				
			tn.tc(jdx) := s(i);
			jdx := jdx + 1;
				
		end loop;
		
		tn.ncar := jdx+1;
		
	end posa_str;
	
	
	
	
	function cons (tn : in taula_de_noms; idn : in id_nom) return string is
		
	begin
	
		return String(tn.tc(tn.tid(idn).pos_tcar .. tn.tid(idn).pos_tcar+rang_tcar(tn.tid(idn).long_paraula)-1));
		
	end cons;				
				

end decls.d_taula_de_noms;
