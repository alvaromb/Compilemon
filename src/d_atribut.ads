-- ------------------------------------------------
--  Paquet de procediments dels atributs
-- ------------------------------------------------
--  Versió			:	0.1
--  Autors			:	José Ruiz Bravo
--							Biel Moyà Alcover
--							Álvaro Medina Ballester
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
							a_lit_string,
							a_operacio,
							a_simbol);
							
	
	type tipus_operacio is (suma,
							 resta,
							 multiplicacio,
							 divisio,
							 igual,
							 major,
							 menor,
							 major_igual,
							 menor_igual,
							 diferent);
							 
							 						
	type tipus_simbol is (asignacio,
						  dospunts,
						  final,
						  coma,
						  parentesiobert,
						  parentesitancat,
						  puntsrang);
							
							
	type atribut (t: tipus_atribut := atom) is record
		
		lin, col: natural;
		
		case t is
		
			when atom 			=> null;
			
			when a_ident 		=> idn: id_nom;
			
			when a_lit_num 		=> int: integer;
			
			when a_lit_car 		=> val: character;	
			
			when a_lit_string	=> ids: id_nom;
			
			when a_operacio		=> t_op: tipus_operacio;
			
			when a_simbol		=> sim: tipus_simbol;
			
		end case;
				
	end record;
	
	
	procedure mt_operador	(l, c: in natural; op: in tipus_operacio; a: out atribut);
	
	procedure mt_pclau		(l, c: in natural; a: out atribut);
	
	procedure mt_identificador	(l, c: in natural; s: in string; a: out atribut);
	
	procedure mt_string	(l, c: in natural; s: in string; a: out atribut);
	
	procedure mt_caracter	(l, c: in natural; car: in string; a: out atribut);
	
	procedure mt_numero	(l, c: in natural; i: in string; a: out atribut);
	
	procedure mt_simbol	(l, c: in natural; simbol: tipus_simbol; a: out atribut);
	
	
end d_atribut;
