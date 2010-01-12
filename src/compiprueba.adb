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
   e: boolean;
   np1 : num_proc := 5;
   np2 : num_proc := 7;
begin

   tbuida(ts);
   d1.np := np1;
   d2.np := np2;
    posa(ts, id, d1, e);
    id := 7;
    posa(ts, id, d2, e);
    --put("hola");

end compiprueba;
