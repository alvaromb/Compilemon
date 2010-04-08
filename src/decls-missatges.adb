package body decls.missatges is
	
	procedure Obre_Fitxer is
		
	begin
	         
		Create(log_file, out_file,"Fitxer errors.log");
		
	end Obre_Fitxer;
	
	procedure Tanca_Fitxer is
		
	begin
		
		Close(Flog);
	
	end Tanca Fitxer;
	
	procedure error(te : in terror;l,c : in valor; id : id_nom);
		
	
	begin
		
		case te is
		
			when tipus_diferents =>
			
			when id_existent =>
			  		
			when rang_sobrepassat =>
			
			when others => null;
				
	    end case;
	
	end error;

end decls.missatges;