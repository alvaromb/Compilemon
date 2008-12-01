-- ------------------------------------------------
--  Paquet de declaracions de les funcions hash
-- ------------------------------------------------
--  Versio	:	0.1
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Especificació de les funcions de hash:
--			- Hash de Pearson per accedir a la 
--			  taula de noms.
--
-- ------------------------------------------------

with	decls.dgenerals;

use	decls.dgenerals;

package decls.d_hash is

	pragma pure;
	
	-- Tipus per la taula de dispersió de la taula de noms:
	num_dispersio : constant integer := 255;
	type rang_dispersio is new integer range -1 .. num_dispersio;
	
	-- Valor nul per el rang dispersió.
	dispersio_nul : constant rang_dispersio := -1;

	function fdisp_tn (nom: in string) return rang_dispersio;
	
	
end decls.d_hash;

