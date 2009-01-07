
package decls.dtdesc is

	type tdescrip is (dnula,
					   dconst,
					   dvar,
					   dtipus,
					   dproc);
					   
	type tipusdetipus is (tsbool,
						   tscar,
						   tsent,
						   tsrec,
						   tsarr);
	
	type descriptipus (tt: tipusdetipus) is
		record
			ocup: despl;
			case tt is
--				when tsbool	=>
--				when tscar 	=>
--				when tsent	=>
--				when tsrec	=>
--				when tsarr	=>
			end case;
		end record;
						
	type descrip (td: tdescrip) is
		record
			case td is
				when dnula 	=> null;
--				when dtipus	=> dt: desc_tipus;
--				when dvar 	=>
--				when dproc	=>
--				when dconst	=>

			end case;
		end record;
		
end decls.dtdesc;
	
