-- ------------------------------------------------
--  Programa de prova
-- ------------------------------------------------
--  Versio  :   0.2
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
        decls.dgenerals,
        decls.dtsimbols,
        decls.dtdesc,
        pk_usintactica_tokens,
        pk_ulexica_io,
        u_lexica,
        Pk_Usintactica,
        Decls.D_atribut;

use     Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.dgenerals,
        decls.dtsimbols,
        decls.dtdesc,
        pk_usintactica_tokens,
        pk_ulexica_io,
        u_lexica,
        Pk_Usintactica;

procedure compilemon is
begin

   tbuida(Decls.D_Atribut.Tn);
   Open_Input(Argument(1));
   yyparse;
   close_Input;

   exception
      when Syntax_Error =>
         Put_Line("ERROR: Error a la linea "
                    &yy_line_number'img&
                    " i columna "&yy_begin_column'img);

end compilemon;
