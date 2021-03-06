-- DECLS-DTSIMBOLS.ads
-- Declaracions de taula de simbols

with    Decls.Dtdesc,
        Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Ada.Text_IO;

use     Decls.Dtdesc,
        Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Ada.Text_IO;


package Decls.Dtsimbols is

    --pragma pure;

    type Tsimbols is private;
    type Ttsimbols is array
          (Num_Proc) of Tsimbols;

    --Serveix per al joc de proves
    type Cursor_Idx is new Rang_Despl;
    type Cursor_Arg is new Rang_Despl;

    -- Operacions
    -- VERSIO 1: llenguatge simple sense estructura
    -- de blocs estil Fortran.
    procedure Printts
      (Ts : in Tsimbols;
       Tn : in Taula_De_Noms);

    procedure Tbuida
      (Ts : out Tsimbols);

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
      (ts : in out tsimbols;
           tn : in taula_de_noms);

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

   type tsimbols is record
      tdesc : taula_desc;
       texp : taula_expansio;
     tambit : taula_ambits;
       prof : nprof;
   end record;

end Decls.Dtsimbols;
