with decls.dgenerals;
use decls.dgenerals;

package d_atribut is

	type tipus_atribut is (atom,
							a_ident,
							a_lit_num,
							a_lit_car,
							a_lit_string,
							a_operacio
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
							
							
	--type tipus_simbol is ();
							
							
	type atribut (t: tipus_atribut := atom) is record
		
		lin, col: natural;
		
		case t is
		
			when atom 			=> null;
			
			when a_ident 		=> idn: id_nom;
			
			when a_lit_num 		=> int: integer;		-- Dubte aqui
			
			when a_lit_car 		=> val: character;		-- Dubte aqui
			
			when a_lit_string	=> ids: id_nom;
			
			when a_operacio		=> t_op: tipus_operacio;
			
			when a_simbol		=> sim: tipus_simbol;
			
		end case;
		
	end record;