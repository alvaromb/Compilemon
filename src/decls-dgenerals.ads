-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versió			:	0.1
--  Autors			:	José Ruiz Bravo
--						Biel Moyà Alcover
--						Álvaro Medina Ballester
-- ------------------------------------------------
--		Aquí una petita descripció.
--
-- ------------------------------------------------

package decls.dgenerals is

	max_id : constant integer := 1000;
	
	type id_nom is new  natural range 0 .. max_id-1;
	id_nul : constant id_nom := 0;

end decls.dgenerals;
