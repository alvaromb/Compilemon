with Ada.Text_Io,
  Decls.Dgenerals,
  Decls.Dtnode,
  Semantica,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.dtsimbols,
  Decls.Dtdesc,
  Semantica.Missatges;

use Ada.Text_Io,
  Decls.Dgenerals,
  Decls.Dtnode,
  Semantica,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.Dtsimbols,
  Decls.Dtdesc,
  Semantica.Missatges;


package Semantica.Ctipus is

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
   procedure Inicia_analisi(nomFitxer: in String);

   procedure Ct_Programa
     (A : in Pnode);

private

   Ts : Tsimbols;
  
   procedure Ct_Decprocediment
     (A : in Pnode);

   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom);

   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom);

   procedure Ct_Param
     (A : in Pnode;
          I : in Id_Nom);

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
      Idarray : out Id_Nom;
      Ncomponents : out Despl);

   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom;
      Ocup: in out despl);

   procedure Ct_Dregistre_Camp
     (Idrecord : in Id_Nom;
      Camp : in Pnode;
      Tcamp : in Pnode;
      Ocup: in out Despl);

   procedure Ct_Decsubrang
     (A : in Pnode);

   procedure Ct_Expressio
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Operand_Exp
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Expressioc
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Exp_Logica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Exp_Relacional
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Exp_Aritmetica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Expressiou
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Exp_Negacio
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Exp_Neglogica
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Constant
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Identificador
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural);

   procedure Ct_Bloc
     (A : in Pnode);

   procedure Ct_Srep
     (A : in Pnode);

   procedure Ct_Sconds
     (A : in Pnode);

   procedure Ct_Scondc
     (A : in Pnode);

   procedure Ct_Referencia_Proc
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom);

   procedure Ct_Referencia_Var
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom);

   procedure Ct_Ref_Rec
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      Idbase : out Id_Nom);

   procedure Ct_Ref_Pri
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom;
      It_Idx : out Cursor_Idx);

   procedure Ct_Ref_Pri
     (A : in Pnode;
      T : out Tipussubjacent;
      It_Arg : out Cursor_Arg);


end Semantica.Ctipus;
