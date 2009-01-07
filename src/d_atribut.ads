-- ------------------------------------------------
--  Paquet de procediments dels atributs
-- ------------------------------------------------
--  Versió	:	0.1
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		En aquest fitxer tenim implementats les 
--	assignacions de cada tipus de token al tipus
--	atribut que li correspon. Cal destacar 
--	l'utilització de la taula de noms en els
--	casos d'identificadors i strings.
--
-- ------------------------------------------------

with 	decls.dgenerals,
		decls.d_taula_de_noms;
		
use 	decls.dgenerals,
		decls.d_taula_de_noms;


package d_atribut is


	type tipus_atribut is (atom,
							a_ident,
							a_lit_num,
							a_lit_car,
							a_lit_string);
							
							
	type atribut (t : tipus_atribut := atom) is record
		
		lin, col : natural;
		
		case t is
		
			when atom 			=> null;
			
			when a_ident 		=> idn : id_nom;
			
			when a_lit_num 		=> int : integer;
			
			when a_lit_car 		=> val : character;	
			
			when a_lit_string	=> ids : rang_tcar;
			
		end case;
				
	end record;
	
	
	procedure mt_atom		(l, c : in natural; a : out atribut);
	
	procedure mt_identificador	(l, c : in natural; 
									s : in string; 
									a : out atribut);
	
	procedure mt_string	(l, c : in natural; 
								s : in string; 
								a : out atribut);
	
	procedure mt_caracter	(l, c : in natural; 
							  car : in string; 
							  	a : out atribut);
	
	procedure mt_numero	(l, c : in natural; 
								i : in string; 
								a : out atribut);
		
	
end d_atribut;
