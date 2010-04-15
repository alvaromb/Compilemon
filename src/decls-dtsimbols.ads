-- ------------------------------------------------
--  Declaracions taula de simbols
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      Declaracions dels procediments de la
--  taula de simbols.
--
-- ------------------------------------------------


with    decls.dtdesc,
        decls.dgenerals,
        decls.d_taula_de_noms,
        Ada.Text_IO;

use     decls.dtdesc,
        decls.dgenerals,
        decls.d_taula_de_noms,
        Ada.Text_IO;


package decls.dtsimbols is

    --pragma pure;

    type tsimbols is limited private;

    --Serveix per al joc de proves
    type cursor_idx is new Rang_despl;
    type cursor_arg is new Rang_despl;

    -- Operacions
    -- VERSIO 1: llenguatge simple sense estructura
    -- de blocs estil Fortran.
    procedure printts
      (ts : in tsimbols);

    procedure tbuida
      (ts : out tsimbols);

    procedure posa
      (ts : in out tsimbols;
       id : in id_nom;
        d : in descrip;
        e : out boolean);

    function cons
      (ts : in tsimbols;
       id : in id_nom) return descrip;

    -- VERSIO 2: Normal, llenguatge amb blocs
    -- estil Pascal.
    procedure entrabloc
      (ts : in out tsimbols);

    procedure surtbloc
      (ts : in out tsimbols);

    -- VERSIO 3: Blocs mes records.
    procedure posacamp
      (ts : in out tsimbols;
      idr : in id_nom;
      idc : in id_nom;
        d : in descrip;
        e : out boolean);

    function conscamp
      (ts : in tsimbols;
      idr : in id_nom;
      idc : in id_nom) return descrip;

    -- VERSIO 4: Arrays.
    procedure posa_idx
      (ts : in out tsimbols;
      ida : in id_nom;
      idi : in id_nom;
        e : out boolean);

    function primer_idx
      (ts : in tsimbols;
      ida : in id_nom) return cursor_idx;

    function idx_valid
      (ci : in cursor_idx) return boolean;

    function succ_idx
      (ts : in tsimbols;
       ci : in cursor_idx) return cursor_idx;

    function cons_idx
      (ts : in tsimbols;
       ci : in cursor_idx) return id_nom;

    -- VERSIO 5: Procediments
    procedure posa_arg
      (ts : in out tsimbols;
      idp : in id_nom;
      ida : in id_nom;
       da : in descrip;
        e : out boolean);

    function primer_arg
      (ts : in tsimbols;
       idp : in id_nom) return cursor_arg;

    function Succ_Arg
      (ts : in tsimbols;
       ca : in cursor_arg) return cursor_arg;

    function arg_valid
      (Ca : in Cursor_arg) return boolean;

    procedure cons_arg
      (ts : in tsimbols;
       ca : in cursor_arg;
      ida : out id_nom;
       dn : out descrip);

    procedure actualitza
      (ts : in out tsimbols;
       id : in id_nom;
        d : in descrip);

private


   type tipus_descripcio is record
      np : nprof;
       d : descrip;
       s : rang_despl;
   end record;

   type tipus_expansio is record
      np : nprof;
       d : descrip;
      id : id_nom;
       s : rang_despl;
   end record;

   type taula_ambits is array
     (1 .. nprof'Last) of rang_despl;

   type taula_expansio is array
     (1 .. rang_despl'Last) of tipus_expansio;

   type taula_desc is array
     (1 .. id_nom'Last) of tipus_descripcio;


   --type cursor_idx is new rang_despl;
   --type cursor_arg is new rang_despl;

   type tsimbols is record
      tdesc : taula_desc;
       texp : taula_expansio;
     tambit : taula_ambits;
       prof : nprof;
   end record;


end decls.dtsimbols;
