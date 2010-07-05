-- DECLS-DTDESC.ads
-- Declaracions de descripcio

with    Decls.Dgenerals,
        Decls.D_Taula_De_Noms;

use     Decls.Dgenerals,
        Decls.D_Taula_De_Noms;

package Decls.Dtdesc is

    --pragma pure;

    -- Representa tambit
    Max_Nprof : constant Integer := 25;
    type Nprof is new Integer
      range -1 .. Max_Nprof;
    Nul_Nprof : constant Nprof := 0;
    No_Prof : constant Nprof := -1;

    type Despl is new Integer;

    -- Representa texpansio
    type Rang_Despl is new Integer
      range 0 .. (Max_Id * Max_Nprof);
    Nul_Despl : constant Rang_Despl := 0;

    type Tdescrip is
      (Dnula,
       Dconst,
       Dvar,
       Dtipus,
       Dproc,
       Dcamp,
       Dargc);

    type Tipussubjacent is
      (Tsbool,
       Tscar,
       Tsstr,
       Tsent,
       Tsrec,
       Tsarr,
       Tsnul);

    type Descriptipus (Tt: Tipussubjacent := Tsnul) is
        record
            Ocup : Despl;
            case Tt is
                when Tsbool | Tscar | Tsent =>
                   Linf, Lsup : Valor;
                when Tsarr | Tsstr => Tcamp : Id_Nom;
                   Base : Valor;
                when Tsrec | Tsnul  => null;
            end case;
        end record;

    type Descrip (Td : Tdescrip := Dnula) is
        record
            case Td is
                when Dnula  => null;
                when Dtipus => Dt : Descriptipus;
                when Dvar   => Tr : Id_Nom;
                               Nv : Num_Var;
                when Dproc  => Np : Num_Proc;
                when Dconst => Tc : Id_Nom;
                               Vc : Valor;
                               Nvc : Num_Var;
                when Dargc  => Nvarg : Num_Var;
                                Targ : Id_Nom;
                when Dcamp  => Tcamp : Id_Nom;
                                 Dsp : Despl;
            end case;
        end record;

end Decls.Dtdesc;
