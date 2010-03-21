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
        Decls.D_atribut,
        decls.d_arbre,
  decls.Dtnode,
  Decls.Ctipus;

use     Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.dgenerals,
        decls.dtsimbols,
        decls.dtdesc,
        pk_usintactica_tokens,
        pk_ulexica_io,
        u_lexica,
        Pk_Usintactica,
        decls.d_arbre,
  decls.Dtnode,
  Decls.Ctipus;

procedure compilemon is
   Tk: Token;

begin

   tbuida(Decls.D_Atribut.Tn);
   Open_Input(Argument(1));
   yyparse;
   while(Yylex'Img/="END_OF_INPUT") loop
      Put_Line(""&Yy_Line_Number'Img&"/"&Yy_Begin_Column'Img
              &" Tk: "&Yylex'img);
  end loop;



  -- Tk := Yylex;
--   while Tk/=End_Of_Input loop
--      Put_Line(Yy_Line_Number'Img&"/"&Yy_Begin_Column'Img&":"&Tk'Img);
--      Tk:= Yylex;
--   end loop;

  Ct_Programa(Arbre);

        --if arbre.fd.tn = procediment then
   put_line("tipusnode: "& arbre.fd1.fid5.tipus'img);

   close_Input;

   exception
      when Syntax_Error =>
         Put_Line("ERROR: Error a la linea "
                    &yy_line_number'img&
                    " i columna "&yy_begin_column'img);

end compilemon;
