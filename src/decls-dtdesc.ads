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


with    decls.dgenerals,
        decls.d_taula_de_noms;

use     decls.dgenerals,
        decls.d_taula_de_noms;


package decls.dtdesc is

    --pragma pure;

    -- Representa tambit
    max_nprof : constant integer := 10;
    type nprof is new integer
      range 0 .. max_nprof;
    nul_nprof : constant nprof := 0;

    type despl is new natural;

    type valor is new integer
      range 0 .. integer'Last;

    max_var : constant integer := 1000;
    type num_var is new natural
      range 0 .. max_var;

    max_proc : constant integer := 100;
    type num_proc is new natural
      range 0 .. max_proc;

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

    type tipusdetipus is
      (tsbool,
       tscar,
       tsent,
       tsrec,
       tsarr,
       tsnul);

    type descriptipus (tt: tipusdetipus := tsnul) is
        record
            ocup : despl;
            case tt is
                when tsbool | tscar | tsent =>
                   linf, lsup : valor;
                when tsarr  => tcamp : id_nom;
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
                when dargc  => nvarg: num_var;
                                targ: id_nom;
                when dcamp  => tcamp: id_nom;
                                 dsp: rang_despl;
            end case;
        end record;


end decls.dtdesc;
