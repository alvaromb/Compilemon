package decls.missatges is

	type terror is (paramsPprincipal, 		
		            id_existent,
					idProgDiferents,
					tipusParam, 
					paramRepetit,
					tipusInexistent,
					tipusSubIncorrecte,
					rang_sobrepassat,
					idCampRecordExistent,
					TsubjRangDif,
					TsubjDifTipus,
					ValEsqMajorDret,
					ValEsqMenor,
					ValDretMajor,
					TsubNoValid);
		
	procedure Obre_Fitxer;
	procedure Tanca_Fitxer;
	                                                  
	procedure error (te : in terror; l,c : in valor; id : string);
	procedure error (te : in terror; id : string);
	
    procedure impressio(sms : in string);

private 

	log_file : File_Type;
end decls.missatges;
