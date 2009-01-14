-- ------------------------------------------------
--  Paquet de declaracions del tipus descripcio
-- ------------------------------------------------
--  Versió	:	0.1
--  Autors	:	Jose Ruiz Bravo
--				Biel Moya Alcover
--				Alvaro Medina Ballester
-- ------------------------------------------------
--		Declaracions del tipus descripcio.
--
-- ------------------------------------------------


with	decls.dgenerals;

use		decls.dgenerals;


package decls.dtdesc is

	pragma pure;

	type tdescrip is (dnula,
					   dconst,
					   dvar,
					   dtipus,
					   dproc);
					   --dcamp
					   --darg
	
	type descrip (td : tdescrip := dnula) is
		record
			case td is
				when dnula 	=> null;
				when dtipus	=> dt: descriptipus;
--				when dvar 	=> tr: id_nom;   ALGUN TIPUS
--				               nv: num_var;  NUMERO DE LA VARIABLE
--				when dproc	=> np: num_proc; NUMERO DEL PROCEDIMENT
--				when dconst	=> tc: id_nom; TIPUS CONSTANT
--				               vc: valor;  VALOR CONSTANT
--              when dargc  => nvarg: num_var;  NUMERO DE LA VARIABLE
--                             targ: id_nom;    TIPUS ARGUMENT?
--              when dcampo => tcamp: id_nom;   TIPUS CAMP
--                             dsp: rang_despl; 

			end case;
		end record;
	
					   
	type tipusdetipus is (tsbool,
						   tscar,
						   tsent,
						   tsrec,
						   tsarr,
						   tsnul);
	
	type descriptipus (tt: tipusdetipus := tsnul) is
		record
			ocup : despl;
			case tt is
				when tsbool	| tscar | tsent => linf, lsup : valor; --COMPROVAR EL TIPUS
				when tsarr	=> tcamp : id_nom;
				when tsrec | tsnul	=> null;
			end case;
		end record;
						
	
		
end decls.dtdesc;
	
