-- ------------------------------------------------
--  Programa de prova
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      Programa per comprovar les funcionalitats
--  del lexic i la taula de noms.
--
-- ------------------------------------------------

with    Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.tn,
        decls.dgenerals,
        d_token,
        pk_ulexica_io,
        u_lexica;

use     Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.tn,
        decls.dgenerals,
        d_token,
        pk_ulexica_io,
        u_lexica;


procedure compilemon is
    Tk:Token;
begin

    --tbuida(tn);

    Open_Input(Argument(1));
    tk := Yylex;

  while tk /= end_of_input loop
      Put(tok_begin_line'Img);
      Put_Line(Token'Image(Tk));
      tk := Yylex;
  end loop;

   close_Input;

--   exception
--     when E_Tids_Plena =>
--     Put_Line("ERROR: La taula d'identificadors
--               es plena.");

--      when E_Tcar_Plena =>
--      Put_Line("ERROR: La taula de caracters
--                es plena.");

--      when Syntax_Error =>
--      Put_Line("ERROR: Error a la linea
--      "&yy_line_number'img&" i columna
--      "&yy_begin_column'img);

end compilemon;
