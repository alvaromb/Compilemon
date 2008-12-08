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
		d_token,
		compilemon_io,
		u_lexica;
		
use		Ada.Text_IO,
		Ada.Command_Line,
		decls.d_taula_de_noms,
		decls.tn,
		decls.dgenerals,
		d_token,
		compilemon_io,
		u_lexica;
		

procedure compilemon is

	Tk : token;
	
begin

	tbuida(tn);--NECESARIO?!

	Open_Input(Argument(1));
	Tk := Yylex;
	
	while tk /= end_of_input loop
		Put_Line(Token'Image(Tk));
		Tk := Yylex;
	end loop;
   
   Close_Input;
   
   exception
      when E_Tids_Plena => 
         Put_Line("ERROR: La taula d'identificadors és plena.");
         
      when E_Tcar_Plena =>
      	Put_Line("ERROR: La taula de caracters és plena.");

end compilemon;
