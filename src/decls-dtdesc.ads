-- ------------------------------------------------
--  Paquet de declaracions del tipus descripcio
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      Declaracions del tipus descripcio.
--
-- ------------------------------------------------

with    Decls.Dgenerals,
        Decls.D_Taula_De_Noms;

use     Decls.Dgenerals,
        Decls.D_Taula_De_Noms;

package Decls.Dtdesc is

    --pragma pure;

    -- Representa tambit
    max_nprof : constant integer := 25;
    type nprof is new integer
      range 0 .. max_nprof;
    nul_nprof : constant nprof := 0;

    type despl is new natural;

    -- Representa texpansio
    type rang_despl is new integer
      range 0 .. (max_id * max_nprof);
    nul_despl : constant rang_despl := 0;

    type tdescrip is
      (dnula,
       dconst,
       dvar,
       dtipus,
       dproc,
       dcamp,
       dargc);

    type tipussubjacent is
      (tsbool,
       tscar,
       tsstr,
       tsent,
       tsrec,
       tsarr,
       tsnul);

    type descriptipus (tt: tipussubjacent := tsnul) is
        record
            ocup : despl;
            case tt is
                when tsbool | tscar | tsent =>
                   linf, lsup : valor;
                when tsarr | tsstr => tcamp : id_nom;
                   base : num_var;
                when tsrec | tsnul  => null;
            end case;
        end record;

    type descrip (td : tdescrip := dnula) is
        record
            case td is
                when dnula  => null;
                when dtipus => dt: descriptipus;
                when dvar   => tr: id_nom;
                               nv: num_var;
                when dproc  => np: num_proc;
                when dconst => tc: id_nom;
                               vc: valor;
                               --Nvc: Num_Var;
                when dargc  => nvarg: num_var;
                                targ: id_nom;
                when dcamp  => tcamp: id_nom;
                                 dsp: rang_despl;
            end case;
        end record;


end Decls.Dtdesc;
