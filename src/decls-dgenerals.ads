-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versió		:	0.1
--  Autors		:	José Ruiz Bravo
--					Biel Moyà Alcover
--					Álvaro Medina Ballester
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

end decls.dgenerals;
