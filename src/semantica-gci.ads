with Semantica.Declsc3a,
  Pilas,
  Decls.Dgenerals;

use Semantica.Declsc3a;

package Semantica.gci is

   Camp_Nul : constant Camp := (Tc => Const, Idc => Var_Nul);

   type T_Param is record
      Base, Despl : num_Var;
   end record;

   procedure Genera
     (Instr : in tInstruccio;
      C1    : in Camp := Camp_Nul;
      C2    : in Camp := Camp_Nul;
      C3    : in Camp := Camp_Nul);

   procedure Inicia_Generacio
     (nomFitxer : in String);

   procedure Gci_Decprocediment
     (A : in Pnode);

   procedure gci_Programa
     (A : in Pnode);

   procedure Gci_Encap
     (A : in Pnode;
      I : in Id_Nom);

   procedure gci_Pencap
     (A : in Pnode);

   procedure gci_Param
     (A : in Pnode);

   procedure gci_Declaracions
     (A : in Pnode);

   procedure gci_Decvar
     (A : in Pnode);

   procedure gci_Declsvar
     (A : in Pnode);

   procedure gci_Decconst
     (A : in Pnode);

   procedure gci_Deccol
     (A : in Pnode);

   procedure gci_Pcoleccio
     (A : in Pnode;
      base: in out Valor;
      Idarray : out Id_nom);

   procedure gci_Bloc
     (A : in Pnode);

   procedure Gci_Assignacio
     (Idref, Iddref, Idrexp, Iddexp: in num_var);

   --Procediments
   procedure gci_Referencia_Proc
     (A : in Pnode;
      Idproc : out num_proc);

   procedure gci_Ref_Pri
     (A : in Pnode;
      Idproc : out num_proc);

   procedure gci_Identificador
     (A : in Pnode;
      Idres, Iddesp: out num_var;
      Idtipus : out Id_Nom);

   procedure gci_Constant
     (A : in Pnode;
      Idres : out Num_var);

   procedure gci_Expressio
     (A : in Pnode;
      Idr, Idd: out num_var);

   procedure gci_Expressioc
     (A : in Pnode;
      Idres,Idresdesp: out num_var);

   procedure gci_Exp_Relacional
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp :   out num_var;
      Op : in Operacio);

   procedure gci_Exp_Logica
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp :   out num_var;
      Op : in Operacio);

   procedure gci_Exp_Aritmetica
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp : out num_var;
      Op : in Operacio);

   procedure gci_Expressiou
     (A : in Pnode;
      Idr, Idd : out num_var);

   procedure gci_Exp_Negacio
     (idRes, Iddesp : in num_var;
      IdresultExp, IddespExp : out num_var);

   procedure gci_Exp_Neglogica
     (idRes, Iddesp : in num_var;
      IdresultExp, IddespExp : out num_var);

   procedure gci_Referencia_Var
     (A : in Pnode;
      Idres, Iddesp: out Num_Var;
      Idtipus : out Id_Nom);

   --Arrays
   procedure gci_Ref_Pri
     (A : in Pnode;
      Idres, Iddesp, Idbase : out Num_var;
      Idtipus : out Id_Nom;
      It_Idx : out Cursor_Idx);

   procedure gci_Ref_Rec
     (A : in Pnode;
      Idres, Iddesp: out num_var;
      Idtipus : out Id_Nom);

   procedure gci_Sconds
     (A : in Pnode);

   procedure gci_Scondc
     (A : in Pnode);

   procedure gci_Srep
     (A : in Pnode);

   procedure Calcula_Despls;

private

   Nprofunditat : nprof;

end Semantica.gci;
