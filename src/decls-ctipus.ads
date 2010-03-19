with Ada.Text_Io,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut;

use Ada.Text_Io,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut;


package Decls.Ctipus is

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

   Identificadors_Diferents : exception;

end Decls.Ctipus;
