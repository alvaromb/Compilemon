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
		tn.td(i) := 0;
	end loop;
	
	for i in tn.tid'range loop
		tn.tid(i).pos_tcaracters := 0;
		tn.tid(i).seguent :=0; 
		tn.tid(i).long_paraula := 0;
	end loop;
	
	for i in tn.tc'range loop
		tn.tc(i) := '$';
	end loop;
	
	tn.nid := 0;
	tn. ncar := 0;
	
end tbuida;

procedure posa(tn : in out taula_de_noms;  idn : out id_nom ; nom : in string ) is
	
	p_tid : rang_dispersio := 0;-- apuntador que ens retorna la funcio de dispersio a la taula de identificadors
	idx : id_nom ; -- index per  recorrer la taula d'identificadors;
	jdx : rang_tcaracters; -- index per recorrer la taula de caracters;
begin
	--p_tid :=  
	
	if tn.td(p_tid) = id_nul then -- Si es la primera vegada que la funcio de dispersio ens dona aquest valor
		
		tn.td(p_tid):=tn.nid; -- asignam a aquesta posicio el darrer lloc de la taula d'identificadors.
		
	else
		idx := tn.td(p_tid); 
		
		while tn.tid(idx).seguent /= 0 loop -- cercam la primera posicio buida a través del camp seguent
		
			idx := tn.tid(idx).seguent;
		
		end loop;
		
		tn.tid(idx).seguent := tn.nid;
		
	end if;
	
	idn := tn.nid;
	tn.nid := tn.nid + 1 ; -- actualitzacio de la darrera posicio de  taula de identificadors  fer comprovacions d'erros
	
	--aqui omplim la taula d'identificadors
	
	tn.tid(idn).pos_tcaracters := tn.ncar; --apuntam a la primera posicio buida de la taula de caracters
	tn.tid(idn).long_paraula := nom'LENGTH;
	
	-- omplim la taula de caracters, desde la primera posicio lliure ncar.
	jdx := tn.ncar;
	for i in 1..nom'LENGTH loop
		
		tn.tc(jdx) := nom(i);
		jdx := jdx + 1;
		
	end loop;
	
	tn.ncar := jdx+1; --apuntam a la primera posicio lliure de la taula de caracters mirar si fa falta comprovacio d'errors
	
end posa;
end decls.d_taula_de_noms;



