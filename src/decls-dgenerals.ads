-- DECLS-DGENERALS.ads
-- Paquet de declaracions generals

package Decls.Dgenerals is

    --pragma pure;

    Max_Id : constant Integer := 1000;
    Long_Num_Ident : constant Integer := 40;

    Max_Var : constant Integer := 1000;
    type Num_Var is new Natural
      range 0 .. Max_Var;
    Var_Nul : Num_Var := 0;

    Max_Proc : constant Integer := 100;
    type Num_Proc is new Natural
      range 0 .. Max_Proc;
    Proc_Nul : Num_Proc := 0;

    Max_Etiquetes : constant Integer := 4000;
    type Num_Etiq is new Integer
      range 0 .. Max_Etiquetes;
    Etiq_Nul : Num_Etiq := 0;

    type Tipus_Etiq is
      (Etiq_Num,
       Etiq_Proc);

    type valor is new Integer
      range Integer'First..Integer'Last;

    type tipus_atribut is
      (Atom,
       A_Ident,
       A_Lit_C,
       A_Lit_N,
       A_Lit_S,
       NodeArbre);

   Esem : Boolean := False;

end Decls.Dgenerals;
