-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versió	:	0.2
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Declaracions generals.
--
-- ------------------------------------------------

package decls.dgenerals is

	pragma pure;

	-- TAULA DE NOMS
	max_id : constant integer := 1001;
	
	type id_nom is new integer range -1 .. max_id-1;
	
	longitut : constant integer := 40;
		
	-- La longitud és el nombre de paraules * la longitud de cadascuna
	type rang_tcar is new integer range 0 .. (longitut*max_id)-1;
	
	-- Valor nul per al tipus id_nom
	id_nul : constant id_nom := -1;
	
	-- Taula de dispersió:
	-- Tipus per la taula de dispersió de la taula de noms:
	tam_dispersio : constant integer := 101;
	type rang_dispersio is new integer range -1 .. tam_dispersio;
	
	-- Valor nul per el rang dispersió.
	dispersio_nul : constant rang_dispersio := -1;
	
	-- Declaració de la taula de dispersió
	type taula_dispersio is array (rang_dispersio) of id_nom;
	
	
	-- TAULA DE SIMBOLS
	max_prof : constant integer := 40;
	type nivell_prof is new integer range 0 .. max_prof;
	
	max_despl : constant integer := max_prof*max_id;
	type rang_despl is new integer range 0 .. max_despl;
	

end decls.dgenerals;
