package body decls.missatges is
	
	procedure Obre_Fitxer is
		
	begin
	         
		Create(log_file, out_file,"Fitxer errors.log");
		
	end Obre_Fitxer;
	
	procedure Tanca_Fitxer is
		
	begin
		
		Close(log_file);
	
	end Tanca Fitxer;
	  
    procedure impressio(msj : in string) is
	
	begin
		
		put_line(log_file,msj);
		put_line(msj);
	
	end impressio;  
	
	
	procedure error(te : in terror;l,c : in valor; id : string) is
		
	
	begin
		
		case te is
		
			when tipus_diferents =>
			
			when id_existent => 		
				impressio("l: "&l'img&" c: "&c'img&" La variable "&id&" ja existeix");
			  		
			when idProgDiferents =>
				--Passam com error el primer id!!!  
				--Linia i columna del segon id
				impressio("l: "&l'img&" c: "&c'img&" Possible escritura erronea de "&id); 
			
            when tipusParam => 
	             -- L'id es el del parametre no el del tipus!!!
				 impressio("l: "&l'img&" c: "&c'img&" El tipus del parametre "&
						  id&" es incorrecte"); 
		    when paramRepetit =>    	
				 impressio("l: "&l'img&" c: "&c'img&" El param "&id&
				          " es troba repetit"); 
				
			when tipusInexistent =>
				 impressio("l: "&l'img&" c: "&c'img&" El tipus "&id&" no existeix"&
				           "o no es correcte"); 
				
			when tipusSubIncorrecte =>    
				 
				 --Aqui donam prioritat al tipus que declaram per sobre el tipus assignat
				 -- si son diferents l'erroni es el que assignam
				 impressio("l: "&l'img&" c: "&c'img&" El tipus "&id&
				          " no es correspon amb el tipus de la variable"); 
			
			when tipusSubIncorrecte =>    
                 impressio("l: "&l'img&" c: "&c'img&" El tipus "&id&
							  " no es correspon amb el tipus de la variable");	
			when rang_sobrepassat => 
				 impressio("l: "&l'img&" c: "&c'img&" El valor de la constant "&
		                       id&" surt del rang");	
			
			when idCampRecordExistent => 
            	 impressio("l: "&l'img&" c: "&c'img&"Ja existeix un camp "&
						                       id&" en aquest record"); 
			when TsubjRangDif => 
		       	 impressio("l: "&l'img&" c: "&c'img&"Els Tsubjacents dels limits del "&
		                    " subtipus "&id&" son diferents"); 
		 	when TsubjDifTipus =>
			     -- Passam la id del subtipus que declaram 
			 	 impressio("l: "&l'img&" c: "&c'img&" Els Tsubjacents dels limits"&
			               "del subtipus"&id&" son diferents al tipus assignat");
			when ValEsqMajorDret =>
				-- Passam la id del subtipus que declaram 
			  	 impressio("l: "&l'img&" c: "&c'img&" El valor del limit Esquerra "&
			              "no pot esser major que el Dret en la declaracio"&
			              " del subrang: "&id);
		    when TsubjDifTipus =>
		         -- Passam la id del subtipus que declaram 
			 	 impressio("l: "&l'img&" c: "&c'img&" Els Tsubjacents dels limits"&
			               "del subtipus"&id&" son diferents al tipus assignat"); 
			when TsubjDifTipus =>
			     -- Passam la id del subtipus que declaram 
			 	 impressio("l: "&l'img&" c: "&c'img&" Els Tsubjacents dels limits"&
			               "del subtipus"&id&" son diferents al tipus assignat"); 
		    when ValEsqMenor =>
		 		 -- Passam la id del subtipus que declaram 
				 impressio("l: "&l'img&" c: "&c'img&" El valor esquerra es menor"&
				           "al permes en el subtipus"&id);
			 when ValDretMajor =>
				  -- Passam la id del subtipus que declaram 
				  impressio("l: "&l'img&" c: "&c'img&" El valor dret es major"&
				            "al permes en el subtipus"&id);
			 when TsubNoValid =>
			      -- Passam la id del subtipus que declaram 
				  impressio("l: "&l'img&" c: "&c'img&" Tipus subjacent no valid"&
				            " per al subrang"&id); 		
			when others => null;
				
	    end case;
	
	end error;    
	
	
	procedure error (te : in terror; id : string) is
		
   	begin
			
   		case te is

   			when paramsPprincipal => impressio("El programa principal no pot tenir parametres");     
			when others => null;
				
	
   		end case;
   
   end error;
	

end decls.missatges;
