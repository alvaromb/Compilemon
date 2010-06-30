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
  Semantica.Gci;

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
  Semantica.Gci;


procedure Compilemon is
        --PROVISIONAL PRUEBA TABLAS
        --auxNP :       num_Proc;
        --auxNV :       num_Var;
        --auxNE : num_etiq;
    --Info_Proc_Aux : Info_Proc;
    --Info_Var_Aux : Info_Var := Info_var_NUl;
        --Info_etiq_Aux : Info_Etiq;
begin
   Open_Input(Argument(1));

   --PROVISIONAL
   Inicia_analisi(Argument(1));

   yyparse;
   Ct_Programa(Arbre);
   Close_Input;

---PRUEBAS TABLAS
--      noves_Taules(Tp, tv, te);

--      nouproc(tp, auxNP);
--      Put_Line("AuxNP = " &auxNP'img);


--      Novavar(Tv, Auxnp, Auxnv);
--      Put_Line("AuxNV = " &auxNV'img);


--      Posa(Te,info_Etiq_aux, auxNE);
--      Put_Line("AuxNE = " &auxNE'img);

--      imprimeix_taules;

   exception
      when Syntax_Error =>
         Put_Line("ERROR: Error a la linea "
                    &yy_line_number'img&
                    " i columna "&yy_begin_column'img);

end compilemon;
