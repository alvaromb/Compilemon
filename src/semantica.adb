package body Semantica is

   procedure Abuit
     (P : out Pnode) is
   begin
      P := null;
   end Abuit;


   procedure Creanode_Programa
     (P : out Atribut;
      A : in Atribut) is
   begin
      P := A;
      Arbre := P.A;
   end Creanode_Programa;


   procedure Creanode
     (P : out Atribut;
      Fe, Fd : in Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.Fe1 := Fe.A;
      Paux.Fd1 := Fd.A;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;


   procedure Creanode
     (P : out Atribut;
      Fe, Fc, Fd : in Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.Fe2 := Fe.A;
      Paux.Fd2 := Fd.A;
      Paux.Fc2 := Fc.A;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;


   procedure Creanode
     (P : out Atribut;
      Fe, Fd : in Atribut;
      Op : in Operacio;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.Fe3 := Fe.A;
      Paux.Fd3 := Fd.A;
      Paux.Op3 := Op;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;


   procedure Creanode
     (P : out Atribut;
      F : in Atribut;
      Op : in Operacio;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.F4 := F.A;
      Paux.Op4 := Op;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;


   procedure Creanode
     (P : out Atribut;
      Fe, Fce, Fc, Fd : in Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.Fe5 := Fe.A;
      Paux.Fc5 := Fce.A;
      Paux.Fd5 := Fc.A;
      Paux.Fid5 := Fd.A;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;

   procedure Creanode
     (P : out atribut;
      F : in atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.F6 := F.A;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode;

   -- Crea node per identificadors
   procedure Creanode_Id
     (P : out Atribut;
      Id : in Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.Id12 := Id.Idn;
      Paux.L1 := Id.Lin;
      Paux.C1 := Id.Col;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode_Id;


   procedure Creanode_Val
     (P : out Atribut;
      A : in Atribut;
      Tn : in Tipusnode;
      S : in Valor) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      if S = 0 then
         Paux.Val := A.Val*(-1);
      else
         Paux.Val := A.Val;
      end if;
      Paux.Tconst := A.T;
      Paux.L2 := A.Lin;
      Paux.C2 := A.Col;
      P := (Nodearbre, 0, 0, Paux);
   end Creanode_Val;


   procedure Creanode_Mode
     (P : out Atribut;
      M : in mmode;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.M12 := M;
      P := (NodeArbre, 0, 0, Paux);
   end Creanode_Mode;


   procedure Creanode
     (P : out Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(tn);
      P := (NodeArbre, 0, 0, Paux);
   end Creanode;


   procedure Remunta
     (P : out Atribut;
      A : in Atribut) is
   begin
      P := A;
   end Remunta;


   procedure Cons_Tnode
     (P : in Pnode;
      Tn : out Tipusnode) is
   begin
      Tn := P.Tipus;
   end Cons_Tnode;

   -- Procediments per a les Taules
   procedure Noves_taules
     (Tp : out T_Procs;
      Tv : out T_Vars) is
   begin
      Tp.Np := 0;
      Tv.Nv := 0;
   end Noves_taules;


   -- Procediments per Taula de Procediments
   procedure Posa
     (Tp  : in out T_Procs;
      Ip  : in Info_Proc;
      Idp : out num_Proc) is
   begin
      Tp.Np := Tp.Np+1;
      Tp.Tp(Tp.Np) := Ip;
      Idp := Tp.Np;
   end Posa;


   procedure Modif_Descripcio
     (Tp  : in out T_Procs;
      Idp : in Num_Proc;
      Ip  : in Info_Proc) is
   begin
      Tp.Tp(Idp) := Ip;
   end Modif_Descripcio;


   -- Procediments per a la Taula de Variables
   procedure Posa
     (Tv : in out T_Vars;
      Iv : in Info_Var;
      Idv : out Num_Var) is
   begin
      Tv.Nv := Tv.Nv+1;
      Tv.Tv(Tv.Nv) := Iv;
      Idv := Tv.Nv;
   end Posa;


   function Nova_Etiq return Num_Etiq is
   begin
      Ne := Ne+1;
      return Ne;
   end Nova_Etiq;

end Semantica;
