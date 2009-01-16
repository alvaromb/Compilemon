-- ------------------------------------------------
--  Programa de prova
-- ------------------------------------------------
--  Versió	:	0.1
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Programa per comprovar les funcionalitats
--	del lèxic i la taula de noms.
--
-- ------------------------------------------------

with	Ada.Text_IO,
		Ada.Command_Line,
		decls.d_taula_de_noms,
		decls.tn,
		decls.dgenerals,
		decls.dtsimbols,
		decls.dtdesc,
		pk_usintactica_tokens,
		compilemon_io,
		u_lexica,
		pk_usintactica;
		
use		Ada.Text_IO,
		Ada.Command_Line,
		decls.d_taula_de_noms,
		decls.tn,
		decls.dgenerals,
		decls.dtsimbols,
		decls.dtdesc,
		pk_usintactica_tokens,
		compilemon_io,
		u_lexica,
		pk_usintactica;
		

procedure compilemon is

--	Tk : token;
--	id1 : id_nom;
--	id2 : id_nom;
--	id3 : id_nom;
--	
--	ts : tsimbols;
--	
begin

	tbuida(tn);--NECESARIO?!
    
 
    
	Open_Input(Argument(1));
	yyparse;
--	Tk := Yylex;
	
--	while tk /= end_of_input loop
--		Put_Line(Token'Image(Tk));
--		Tk := Yylex;
--	end loop;

 	
   
   Close_Input;
   
   exception
      when E_Tids_Plena => 
         Put_Line("ERROR: La taula d'identificadors és plena.");
         
      when E_Tcar_Plena =>
      	Put_Line("ERROR: La taula de caracters és plena.");
      	
      when Syntax_Error =>
        Put_Line("ERROR: Error a la linea "&yy_line_number'img&" i columna "&yy_begin_column'img);

end compilemon;
