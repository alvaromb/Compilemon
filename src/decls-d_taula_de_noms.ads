-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio	:	0.1
--  Autors	:	Jose Ruiz Bravo
--				Biel Moya Alcover
--				Alvaro Medina Ballester
-- ------------------------------------------------
--	Aqui una petita descripcio.
--
-- ------------------------------------------------

with decls.dgenerals; 
use decls.dgenerals;
with Ada.Text_IO;
use Ada.Text_IO;

package decls.d_taula_de_noms is

	--pragma(pure);
	
	type taula_de_noms is  private;
	
	procedure tbuida(tn : out taula_de_noms);
	procedure posa(tn : in out taula_de_noms;  idn : out id_nom ; nom : in string);
	--procedure posa(tn : in out taula_de_noms; s : in string; ids : out string);	
	procedure imprimir_tcar(tn : in taula_de_noms; nparaules : integer);
	function cons(tn : in taula_de_noms; idn : in id_nom) return string;
	

	--function cons(tn : in taula_de_noms; ids : in  string) return string;
	
	
	private
		
		longitut :constant integer := 40;
		num_dispersio : constant integer := 255;
		
		type rang_dispersio is new integer range -1..num_dispersio;
		type rang_tcar is  new integer range 0..(longitut*max_id)-1 ;--longitut d'una paraula * nombre paraules
		
		dispersio_nul :  rang_dispersio := -1;
		
		type t_identificador is record 
			pos_tcar: rang_tcar;
			seguent : id_nom;
			long_paraula : Natural;--aixo es logic, a mes es un apao, ja que al recorrer, el string es molt mes senzill!
			
		end record;
		
		type taula_dispersio is array (rang_dispersio) of  id_nom;
		type taula_identificadors is array (id_nom) of t_identificador  ;
		type taula_caracters is array (rang_tcar) of character ; 
		
		
		type taula_de_noms is record
				td : taula_dispersio;
				tid : taula_identificadors;
				tc : taula_caracters;
				nid :  id_nom;
				ncar : rang_tcar;
		end record;
		
		function fdisp (nom: in string) return rang_dispersio;
			
end decls.d_taula_de_noms;		
