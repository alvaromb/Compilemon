package decls.missatges is

	type terror is (tipus_diferents,
		            id_existent,
		            rang_sobrepassat);
		
	procedure Obre_Fitxer;
	procedure Tanca_Fitxer;
	                                                  
	procedure error (te : in terror;l,c : in valor; id : id_nom );
	


private 

	log_file : File_Type;
end decls.missatges;