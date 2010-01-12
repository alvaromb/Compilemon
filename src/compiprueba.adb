-- ------------------------------------------------
--  Programa de prova
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      Programa per comprovar les funcionalitats
--  de la taula de simbols.
--
-- ------------------------------------------------

with    Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.tn,
        decls.dgenerals,
        d_token,
        pk_ulexica_io,
        u_lexica,
    decls.dtsimbols,
    decls.dtdesc;

use     Ada.Text_IO,
        Ada.Command_Line,
        decls.d_taula_de_noms,
        decls.tn,
        decls.dgenerals,
        d_token,
        pk_ulexica_io,
        u_lexica,
    decls.dtsimbols,
    decls.dtdesc;


procedure compiprueba is
   ts: tsimbols;
   id: id_nom := 1;
   d1: descrip(dproc);
   d2: descrip(dproc);
   d3: descrip(dvar);
   d4: descrip(dtipus);
   e: boolean;
   np1 : num_proc := 5;
   np2 : num_proc := 7;
   desctip : descriptipus(tsrec);
begin

   --Tbuida
   tbuida(ts);

   --Posa
   d1.np := np1;
   d2.np := np2;
   id := 1;
   posa(ts, id, d1, e);
   id := 7;
   posa(ts, id, d2, e);

   --Cons
   --New_Line;
   --case cons(ts, 7).td is
   --   when dnula => Put_Line("dnula");
   --   when dtipus => Put_Line("dtipus");
   --   when dvar => Put_Line("dvar");
   --   when dproc => Put_Line("dproc");
   --   when dconst => Put_Line("dconst");
   --   when dargc => Put_Line("dargc");
   --   when dcamp => Put_Line("dcamp");
   --end case;
   --Put_Line("np: "&cons(ts, 7).np'img);

   --Entra bloc
   entrabloc(ts);
   d3.tr := 4;
   d3.nv := 3;
   posa(ts, id, d3, e);

   --Surt bloc
   surtbloc(ts);
   printts(ts);

   --Un altre entra bloc
   --entrabloc(ts);
   --posa(ts, id, d3, e);

   --Començam amb records
   desctip.ocup := 8;
   d4.dt := desctip;
   id := 8;
   posa(ts, id, d4, e);

   --Ficam un posa camp
   posacamp(ts, 8, 1, d3, e);
   printts(ts);
   posacamp(ts,8,7,d3,e);
   printts(ts);

   --Consulta camp
   Put_Line("Cons camp: "&conscamp(ts,8,1).nv'img);
   Put_Line("Cons camp: "&conscamp(ts,8,7).nv'img);
   if e then
      put_line("ERROR");
   end if;



end compiprueba;
