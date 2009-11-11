-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versio	:	0.2
--  Autors	:	Jose Ruiz Bravo
--				Biel Moya Alcover
--				Alvaro Medina Ballester
-- ------------------------------------------------
--		Declaracions generals.
--
-- ------------------------------------------------

package decls.dgenerals is

	pragma pure;

	-- TAULA DE NOMS
	max_id : constant integer := 1000;
	type id_nom is new integer range 0 .. max_id;
	
	-- Valor nul per al tipus id_nom
	id_nul : constant id_nom := 0;
		
	-- La longitud es el nombre de paraules * la longitud de cadascuna
	longitut : constant integer := 40;
	type rang_tcar is new integer range 0 .. (longitut*max_id);
	
	-- Taula de dispersio:
	-- Tipus per la taula de dispersio de la taula de noms
	tam_dispersio : constant integer := 101;
	type rang_dispersio is new integer range -1 .. tam_dispersio;
	
	-- Valor nul per el rang dispersio
	dispersio_nul : constant rang_dispersio := -1;
	
	-- Declaracio de la taula de dispersio
	type taula_dispersio is array (rang_dispersio) of id_nom;
	
	
	-- TAULA DE SIMBOLS
	type despl is new integer;
	
	max_prof : constant integer := 20;
	type nivell_prof is new integer range 0 .. max_prof;
	nul_nprof : constant nivell_prof := 0;
	
	max_despl : constant integer := max_prof*max_id;
	type rang_despl is new integer range 0 .. max_despl;
	nul_despl : constant rang_despl := 0;
	
	-- Nombre de variables
	max_var : constant integer := 1000;
	type num_var is new integer range 0 .. max_var;
	
	-- Nombre de procediments
	max_proc : constant integer := 100;
	type num_proc is new integer range 0 .. max_proc;
	
	-- Tipus constant
	type valor is new integer range 0 .. integer'Last;


end decls.dgenerals;
