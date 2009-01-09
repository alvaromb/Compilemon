with	decls.dtdesc,
		decls.dgenerals;
		
use		decls.dtdesc,
		decls.dgenerals;


package decls.dtsimbols is

	pragma pure;

	type tsimbols is limited private;
	type cursor_idx is private;
	type cursor_arg is private;
	
	-- Operacions
	-- VERSIO 1: llenguatge simple sense estructura 
	-- de blocs estil Fortran.
	procedure tbuida (ts: out tsimbols);
	
	procedure posa (ts: in out tsimbols;
					 id: in id_nom;
					  d: in descrip;
					  e: out boolean);
					 
	function cons (ts: in tsimbols;
					id: in id_nom) return descrip;
					
					
	-- VERSIO 2: Normal, llenguatge amb blocs estil Pascal.
	procedure entrabloc (ts: in out tsimbols);
	
	procedure surtbloc (ts: in out tsimbols);
	
	
	-- VERSIO 3: Blocs més records.
	procedure posacamp (ts: in out tsimbols;
						idr: in id_nom;
						idc: in id_nom;
						  d: in descrip;
						  e: out boolean);
						
	function conscamp (ts: in tsimbols;
					   idr: in id_nom;
					   idc: in id_nom) return descrip;
					   
					   
	-- VERSIO 4: Arrays.
	procedure posa_idx (ts: in tsimbols;
						ida: in id_nom;
						idi: in id_nom);
						
	function primer_idx (ts: in tsimbols;
						 ida: in id_nom) return cursor_idx;
						 
	function succ_idx (ts: in tsimbols;
						ci: in cursor_idx) return cursor_idx;
							 
	function idx_valid (ci: in cursor_idx) return boolean;
	
	function cons_idx (ts: in tsimbols;
						ci: cursor_idx) return id_nom;
						 
						 
	-- VERSIO 5: Procediments
	procedure posa_arg (ts: in tsimbols;
						idp: in id_nom;
						ida: in id_nom;
						  d: in descrip;
						  e: out boolean);
						  
--	function primer_arg () return cursor_arg; --OMPLIR
--	
--	function succ_arg () return cursor_arg; --OMPLIR
--	
--	function arg_valid () return boolean; --OMPLIR
	
	procedure cons_arg (ts: in tsimbols;
						 ca: in cursor_arg;
						ida: out id_nom;
						 dn: out descrip);
						 
	procedure actualitza (ts: in out tsimbols;
						   id: in id_nom;
						    d: in descrip);
    
    private
    
		type tipus_descrip is record
			np : nivell_prof;
			 d : descrip;
			 s : rang_despl;
		end record;
		
		type tipus_despl is record
			np : nivell_prof;
			 d : descrip;
		 	id : id_nom;
		 	 s : rang_despl; --afegit per tal d'implementar els records
		end record;
		 
		type taula_blocs is array (1 .. max_prof) of rang_despl;
		type taula_despl is array (1 .. max_despl) of tipus_despl;
		type taula_descrip is array (1 .. id_nom'Last) of tipus_descrip;
			
		type tsimbols is record
			tdesc : taula_descrip;
		   tdespl : taula_despl;
			tbloc : taula_blocs; -- A LO MILLOR EL NOM S'HA DE CAMBIAR PER TAMB
			nprof : nivell_prof;
		end record;

end decls.dtsimbols;
