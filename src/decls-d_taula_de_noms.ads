-- DECLS-D_TAULA_DE_NOMS.ads
-- Declaracions de la taula de noms

with    Decls.Dgenerals,
        Ada.Text_Io;

use     Decls.Dgenerals,
        Ada.Text_Io;


package Decls.D_Taula_De_Noms is

    --pragma pure;

    --Excepcions
    E_Tids_Plena : exception;
    E_Tcar_Plena : exception;

    type Taula_De_Noms is limited private;

    type Id_Nom is new Integer
      range 0 .. Max_Id;

    type Rang_Dispersio is new Integer
      range 0 .. Max_Id;

    type Rang_Tcar is new Integer
      range 0 .. (Long_Num_Ident*Max_Id);

    -- Valor nul per al tipus id_nom
    Id_Nul : constant Id_Nom := 0;

    procedure Tbuida
      (Tn : out Taula_De_Noms);

    procedure Posa_Id
      (Tn : in out Taula_De_Noms;
      Idn : out Id_Nom;
      Nom : in String);

    procedure Posa_Tc
      (Tn : in out Taula_De_Noms;
      Nom : in String);

    procedure Posa_Str
      (Tn : in out Taula_De_Noms;
      Ids : out Rang_Tcar;
        S : in String);

    function Cons_Nom
      (Tn : in Taula_De_Noms;
      Idn : in Id_Nom)
      return String;

    function Cons_Str
      (Tn : in Taula_De_Noms;
      Ids : in Rang_Tcar)
      return String;

    function Fdisp_Tn
      (Nom : in String)
      return Rang_Dispersio;


private

   type Taula_Dispersio is array
     (Rang_Dispersio) of Id_Nom;

   type T_Identificador is record
           Pos_Tcar : Rang_Tcar;
            Seguent : Id_Nom;
       Long_Paraula : Natural;
   end record;

   type Taula_Identificadors is array
     (1 .. Id_Nom'Last) of T_Identificador;

   type Taula_Caracters is array
     (Rang_Tcar) of Character;

   type taula_de_noms is record
        Td : Taula_Dispersio;
       Tid : Taula_Identificadors;
        Tc : Taula_Caracters;
       Nid : Id_Nom;
      Ncar : Rang_Tcar;
   end record;

end Decls.D_Taula_De_Noms;
