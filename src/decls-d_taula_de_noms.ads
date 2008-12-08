-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio	:	0.1
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--	Especificació de l'estructura necessaria
-- per el maneig de la taula de noms i dels mètodes
-- per tractar-la.
--
-- ------------------------------------------------

with 	decls.dgenerals,
		decls.d_hash; 
		
use 	decls.dgenerals,
		decls.d_hash;


package decls.d_taula_de_noms is

	pragma pure;
	
	-- Excepcions
	E_Tids_Plena : exception;
	E_Tcar_Plena : exception;
	
	type taula_de_noms is limited private;
	
	procedure tbuida	(tn : out taula_de_noms);
	
	procedure posa_id 	(tn : in out taula_de_noms;  
						idn : out id_nom; 
						nom : in string);
	
	procedure posa_str	(tn : in out taula_de_noms;
						idn : out id_nom;
						  s : in string );
						
	function cons		(tn : in taula_de_noms; 
						idn : in id_nom) return string;
								
	
	private
		
		longitut : constant integer := 40;
		
		-- La longitud és el nombre de paraules * la longitud de cadascuna
		type rang_tcar is new integer range 0 .. (longitut*max_id)-1;
		
		type t_identificador is record 
				pos_tcar : rang_tcar;
				 seguent : id_nom;
		  	long_paraula : Natural;
		end record;
		
		type taula_identificadors is array (id_nom) of t_identificador;
		
		type taula_caracters is array (rang_tcar) of character; 
		
		type taula_de_noms is record
			  td : taula_dispersio;
			 tid : taula_identificadors;
			  tc : taula_caracters;
			 nid : id_nom;
			ncar : rang_tcar;
		end record;
		
		
		-- Funció de comparació de dues paraules
		function par_iguals (par1, par2 : in string) return boolean;		
					
			
end decls.d_taula_de_noms;		
