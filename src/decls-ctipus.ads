with Ada.Text_Io,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.Dtsimbols;

use Ada.Text_Io,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.Dtsimbols;


package Decls.Ctipus is

   -- Rutines lexiques
   procedure mt_atom
     (l, c : in natural;
         a : out atribut);

   procedure mt_identificador
     (l, c : in natural;
         s : in string;
         a : out atribut);

   procedure mt_string
     (l, c : in natural;
         s : in string;
         a : out atribut);

   procedure mt_caracter
     (l, c : in natural;
       car : in string;
         a : out atribut);

   procedure mt_numero
     (l, c : in natural;
         s : in string;
         a : out atribut);

   -- Comprovacio de tipus
   procedure Ct_Programa
     (A : in Pnode);

   procedure Ct_M1;

   procedure Ct_Decprocediment
     (A : in Pnode);

   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom);

   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom);

   procedure Ct_Param
     (A : in Pnode);

   procedure Ct_Declaracions
     (A : in Pnode);

   procedure Ct_Decvar
     (A : in Pnode);

   procedure Ct_Declsvar
     (A : in Pnode);

   --procedure Ct_Decconst
   --  (A : in Pnode);

   --procedure Ct_Deccol
   --  (A : in Pnode);

   --procedure Ct_Decregistre
   --  (A : in Pnode);

   --procedure Ct_Decsubrang
   --  (A : in Pnode);

   Identificadors_Diferents : exception;
   Tdeclaracio_Inexistent : exception;

private

   --Provisional
   Ts : Tsimbols;
   Tn : Taula_De_Noms;

end Decls.Ctipus;
