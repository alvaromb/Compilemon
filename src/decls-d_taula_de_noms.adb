-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versió			:	0.1
--  Autors			:	José Ruiz Bravo
--						Biel Moyà Alcover
--						Álvaro Medina Ballester
-- ------------------------------------------------
--		Aquí una petita descripció.
--
-- ------------------------------------------------

package body decls.d_taula_de_noms is

	procedure tbuida(tn : out taula_de_noms) is
	-- donam els valors per defecte de cada camp, sempre que un camp no sigui utilitzat valdra 0
	
	begin 
		for i in tn.td'range loop
			tn.td(i) := id_nul;
		end loop;
		
		for i in tn.tid'range loop
			tn.tid(i).pos_tcar := 0;
			tn.tid(i).seguent := id_nul; 
			tn.tid(i).long_paraula := 0;
		end loop;
		
		for i in tn.tc'range loop
			tn.tc(i) := '$';
		end loop;
		
		tn.nid := 0;
		tn.ncar := 0;
		
	end tbuida;


	procedure posa(tn : in out taula_de_noms;  idn : out id_nom ; nom : in string ) is
		
		p_tid : rang_dispersio := 0;-- apuntador que ens retorna la funcio de dispersio a la taula de identificadors
		idx : id_nom ; -- index per  recorrer la taula d'identificadors;
		jdx : rang_tcar; -- index per recorrer la taula de caracters;
		p_car : rang_tcar := 0;
		rec : Natural:= 1;
		iguals : boolean := false;
	begin
		
		p_tid :=  fdisp(nom);
		
		
		if tn.td(p_tid) = id_nul then -- Si es la primera vegada que la funcio de dispersio ens dona aquest valor
			
			tn.td(p_tid):=tn.nid; -- asignam a aquesta posicio el darrer lloc de la taula d'identificadors.
			idx:=tn.nid;
		else
			idx := tn.td(p_tid); 
			
			-- cercam la primera posicio buida a través del camp seguent
			while tn.tid(idx).seguent /= id_nul and not iguals loop 
			
				--bucle de comparacio entre paraula nova
				if tn.tid(idx).long_paraula = nom'Length then
				
					p_car := tn.tid(idx).pos_tcar;
					
					 
					while  rec < tn.tid(idx).long_paraula  and tn.tc(p_car) = nom(rec) loop
						

						p_car := p_car+1;
						rec := rec+1;
					end loop;
					
					if tn.tc(p_car) = nom(rec) then
						Put_Line("Son iguals les putes paraules");
						idn := idx;
						iguals := true;
					end if;
				end if;
				
				if not iguals then
					idx := tn.tid(idx).seguent;
				end if;
			
			end loop;
			
		end if;
		
		if not iguals then
			
				
			tn.tid(idx).seguent := tn.nid;
		
			idn := tn.nid;
			tn.nid := tn.nid + 1 ; --actualitzacio de la darrera posicio de taula de identificadors fer comprovacions d'errors
			
			--aqui omplim la taula d'identificadors
			
			tn.tid(idn).pos_tcar := tn.ncar; --apuntam a la primera posicio buida de la taula de caracters
			tn.tid(idn).long_paraula := nom'LENGTH;
			
			-- omplim la taula de caracters, desde la primera posicio lliure ncar.
			jdx := tn.ncar;
			for i in 1..nom'LENGTH loop
				
				tn.tc(jdx) := nom(i);
				jdx := jdx + 1;
				
			end loop;
			
			--apuntam a la primera posicio lliure de la taula de caracters mirar si fa falta comprovacio d'errors
			tn.ncar := jdx+1; 
		
		end if;
		
	end posa;
	
	
	
	function cons(tn : in taula_de_noms; idn : in id_nom) return string is
		
	begin
	
		return String(tn.tc(tn.tid(idn).pos_tcar .. tn.tid(idn).pos_tcar+rang_tcar(tn.tid(idn).long_paraula)-1));
		
	end cons;
	
	
	
	
	
	procedure imprimir_tcar(tn : in taula_de_noms; nparaules : integer) is
		
		begin
			for i in 0.. (nparaules*10)loop
				Put(tn.tc(rang_tcar(i)));
			end loop;
			
	end imprimir_tcar;
				

	function fdisp (nom: in string) return rang_dispersio is
		
		-- Vector generat de forma aleatòria per
		-- executar la funció de hash.	
		type vector is array (0..255) of rang_dispersio;
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
		hash: rang_dispersio := 0;
		
	begin
	
		for i in 1..nom'Length loop
			hash := (hash + character'POS(nom(i))) mod 256;
			hash := v(Integer(hash));
		end loop;
		
		--QUITAR
		Put_Line("Valor Hash: "&hash'img);
		
		return hash;
	
	end fdisp;


end decls.d_taula_de_noms;



