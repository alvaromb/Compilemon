-- COMPILEMON.adb
-- Programa per compilar el compilador

with Ada.Text_IO,
  Ada.Command_Line,
  Decls.D_Taula_De_Noms,
  Decls.Dgenerals,
  Decls.Dtdesc,
  Pk_Usintactica_Tokens,
  Pk_Ulexica_Io,
  U_Lexica,
  Pk_Usintactica,
  Decls.D_Atribut,
  Semantica,
  Decls.Dtnode,
  Semantica.Ctipus,
  Semantica.Declsc3a,
  Semantica.Gci,
  Semantica.Assemblador;

use Ada.Text_IO,
  Ada.Command_Line,
  Decls.D_Taula_De_Noms,
  Decls.Dgenerals,
  Decls.Dtdesc,
  Pk_Usintactica_Tokens,
  Pk_Ulexica_Io,
  U_Lexica,
  Pk_Usintactica,
  Decls.D_Atribut,
  Semantica,
  Decls.Dtnode,
  Semantica.Ctipus,
  Semantica.Declsc3a,
  Semantica.Gci,
  Semantica.Assemblador;


procedure Compilemon is

begin
   Open_Input(Argument(1));
   Inicia_analisi(Argument(1));
   yyparse;

   --Comprovacio de tipus
   Ct_Programa(Arbre);

   if not esem then
      -- Generacio de codi intermedi
      Inicia_Generacio(Argument(1));
      Gci_Programa(Arbre);

      -- Generacio de codi assemblador
      Genera_Assemblador(Argument(1));
   end if;

   Close_Input;

exception
   when Syntax_Error =>
      Put_Line("ERROR CompiLEMON: Error a la linea "
                 &yy_line_number'img&
                 " i columna "&yy_begin_column'img);
end compilemon;
