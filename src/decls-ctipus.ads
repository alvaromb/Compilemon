with Ada.Text_Io,
  Decls.Dgenerals,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.Dtsimbols,
  Decls.Dtdesc;

use Ada.Text_Io,
  Decls.Dgenerals,
  Decls.Dtnode,
  Decls.D_Arbre,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.Dtsimbols,
  Decls.Dtdesc;


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

   -- Taula de simbols
   procedure Inicia_Enter;
   procedure Inicia_Boolea;

   -- Comprovacio de tipus
   procedure Inicia_analisi;

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
     (A : in Pnode;
      Idtipus : out Id_nom);

   procedure Ct_Decconst
     (A : in Pnode);

   procedure Ct_Deccol
     (A : in Pnode);

   procedure Ct_Pcoleccio
     (A : in Pnode;
      Idtipus_Array : in Id_Nom;
      Idarray : out Id_Nom);

   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom);

   procedure Ct_Dregistre_Camp
     (Idrecord : in Id_Nom;
      Camp : in Pnode;
      Tcamp : in Pnode);

   procedure Ct_Decsubrang
     (A : in Pnode);

   procedure Ct_Expressio
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom);

   procedure Ct_Expressioc
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom);

   procedure Ct_Expressiou
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom);

   procedure Ct_Constant
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom);

   procedure Ct_Identificador
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom);

   procedure Ct_Bloc
     (A : in Pnode);

   procedure Ct_Srep
     (A : in Pnode);


   Identificadors_Diferents : exception;
   Tdeclaracio_Inexistent : exception;
   Tno_Existent : exception;
   Tassig_Diferent : exception;

private

   --Provisional
   Ts : Tsimbols;
   Tn : Taula_De_Noms;
   nv : num_var;
   np : num_proc;

end Decls.Ctipus;
