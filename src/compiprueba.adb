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
        Decls.D_Taula_De_Noms,
        Decls.Tn,
        Decls.Dgenerals,
        D_Token,
        Pk_Ulexica_Io,
        U_Lexica,
        Semantica.Dtsimbols,
        Delcs.Dtdesc;

use     Ada.Text_IO,
        Ada.Command_Line,
        Decls.D_Taula_De_Noms,
        Decls.Tn,
        Decls.Dgenerals,
        D_Token,
        Pk_Ulexica_Io,
        U_Lexica,
        Semantica.Dtsimbols,
        Decls.Dtdesc;


procedure compiprueba is
   ts: tsimbols;
   id: id_nom := 1;
   d1: descrip(dproc);
   d2: descrip(dproc);
   d3: descrip(dvar);
   d4: descrip(dtipus);
   d5: descrip(dtipus);
   D6: Descrip(Dvar);
   e: boolean;
   np1 : num_proc := 5;
   np2 : num_proc := 7;
   desctip : descriptipus(tsrec);
   descarr : descriptipus(tsarr);
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
   D3.tr := 4;
   d3.nv := 3;
   posa(ts, id, d3, e);

   --Surt bloc
   surtbloc(ts);
   printts(ts);

   --Un altre entra bloc
   --entrabloc(ts);
   --posa(ts, id, d3, e);

   --Comencam amb records
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

   --Comencam amb els arrays
   descarr.ocup := 8;
   d5.dt := descarr;
   posa(ts, 5, d5, e); --Ficam l'array
   posa_idx(ts, 5, 31, e); --Afegim un camp a l'array
   printts(ts);
   posa_idx(ts, 5, 32, e); --Afegim un altre camp
                           --a l'array
   printts(ts);

   --Primer_idx i idx_valid
   Put_Line("PRIMER IDX: "
              &primer_idx(ts, 5)'img);
   Put_Line("IDX VALID: "
              &idx_valid(primer_idx(ts, 5))'img);

   --Provam el successor del camp 1
   Put_Line("SUCCESSOR IDX: "
              &succ_idx(ts, primer_idx(ts, 5))'img);
   Put_Line("SUCCESSOR IDX: "
              &succ_idx(ts, succ_idx(ts,
               primer_idx(ts, 5)))'img);

   --Consultam idx
   Put_Line("CONS IDX: "
              &cons_idx(ts, primer_idx(ts, 5))'img);
   Put_Line("CONS IDX: "
              &cons_idx(ts, succ_idx(ts,
               primer_idx(ts, 5)))'img);

   --Posa_arg
   D6.Tr := 9;
   d6.Nv := 5;
   Posa(Ts, 9, D6, E); --Parametre variable 8 (argument)
   Posa_Arg(Ts, 7, 9, D6, E); --Passam per primera vegada
                              --l'argument
   Posa_Arg(Ts, 7, 9, D6, E); --El passam per segona
                              --vegada
   Printts(Ts);

   --Primer_arg

   --Actualitza
   Put_Line("Antes act: ");
   case cons(ts, 7).td is
      when dnula => Put_Line("dnula");
      when dtipus => Put_Line("dtipus");
      when dvar => Put_Line("dvar");
      when dproc => Put_Line("dproc");
      when dconst => Put_Line("dconst");
      when dargc => Put_Line("dargc");
      when dcamp => Put_Line("dcamp");
   end case;

   Actualitza(Ts, 7, D6);
   Put_Line("Act dvar: ");
   case cons(ts, 7).td is
      when dnula => Put_Line("dnula");
      when dtipus => Put_Line("dtipus");
      when dvar => Put_Line("dvar");
      when dproc => Put_Line("dproc");
      when dconst => Put_Line("dconst");
      when dargc => Put_Line("dargc");
      when dcamp => Put_Line("dcamp");
   end case;

   if e then
      put_line("ERROR");
   end if;


end compiprueba;
