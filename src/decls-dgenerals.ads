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

	max_id : constant integer := 1001;
	
	type id_nom is new integer range -1 .. max_id-1;
	
	-- Valor nul per al tipus id_nom
	id_nul : constant id_nom := -1;
	
	-- Tipus per la taula de dispersió de la taula de noms:
	tam_dispersio : constant integer := 5519;
	type rang_dispersio is new integer range -1 .. tam_dispersio;
	
	-- Valor nul per el rang dispersió.
	dispersio_nul : constant rang_dispersio := -1;
	
	-- Declaració de la taula de dispersió
	type taula_dispersio is array (rang_dispersio) of id_nom;
	

end decls.dgenerals;
