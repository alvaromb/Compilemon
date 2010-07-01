package body Semantica is

   procedure Abuit
     (P : out pnode) is
   begin
      p := null;
   end abuit;


   procedure creaNode_programa
     (P : out Atribut;
      A : in Atribut) is
   begin
      P := A;
      arbre := P.A;
   end creaNode_programa;


   procedure creaNode
     (p : out atribut;
      fe,fd : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.fe1 := fe.a;
      paux.fd1 := fd.a;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;


   procedure CreaNode
     (p : out atribut;
      fe,fc,fd : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.fe2 := fe.a;
      paux.fd2 := fd.a;
      paux.fc2 := fc.a;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;


   procedure creaNode
     (p : out atribut;
      fe, fd : in atribut;
      op : in operacio;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.fe3 := fe.a;
      paux.fd3 := fd.a;
      paux.op3 := op;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;


   procedure CreaNode
     (p : out atribut;
      f : in atribut;
      op : in operacio;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.f4 := f.a;
      paux.op4 := op;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;


   procedure CreaNode
     (p : out atribut;
      fe, fce, fc, fd : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.fe5 := fe.a;
      paux.fc5 := fce.a;
      paux.fd5 := fc.a;
      paux.fid5 := fd.a;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;

   procedure creaNode
     (p : out atribut;
      f : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.f6 := f.a;
      p := (nodeArbre, 0, 0, paux);
   end creaNode;

   -- Crea node per identificadors
   procedure CreaNode_ID
     (p : out atribut;
      id : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      paux := new node(tn);
      paux.id12 := id.idn;
      paux.l1 := id.lin;
      paux.c1 := id.col;
      p := (nodeArbre, 0, 0, paux);
   end CreaNode_ID;


   procedure CreaNode_VAL
     (p : out atribut;
      a : in atribut;
      tn : in Tipusnode;
      S : in Valor) is
      paux : pnode;
   begin
      paux := new node(tn);
      if S = 0 then
         paux.val := A.Val*(-1);
      else
         Paux.Val := A.Val;
      end if;
      Paux.Tconst := A.T;
      paux.l2 := a.lin;
      paux.c2 := a.col;
      p := (nodeArbre, 0, 0, paux);
   end CreaNode_VAL;


   procedure Creanode_MODE
     (P : out Atribut;
      M : in mmode;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(Tn);
      Paux.M12 := M;
      P := (NodeArbre, 0, 0, Paux);
   end Creanode_Mode;


   procedure creaNode
     (P : out Atribut;
      Tn : in Tipusnode) is
      Paux : Pnode;
   begin
      Paux := new Node(tn);
      P := (NodeArbre, 0, 0, Paux);
   end creaNode;


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
      --null;
      -- Hem de crear un proc inicialitzador de cada taula on posem l'index
      -- a 0
      --Tbuida(Tp);
      --Tbuida(Tv);
      --Tbuida(Te);
      --TP
      Tp.Np:=0;
      --TV
      Tv.Nv:=0;
   end Noves_taules;

   -- Procediments per Taula de Procediments
   procedure Posa
     (Tp  : in out T_Procs;
      Ip  : in Info_Proc;
      Idp : out num_Proc) is
   begin
      Tp.Np:=Tp.Np+1;
      Tp.Tp(Tp.Np):=Ip;
      Idp:=Tp.Np;
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

   -- Procediments per a la Taula d'Etiquetes
   --  procedure Posa
   --    (Te  : in out T_Etiqs;
   --     Ie  : in Info_Etiq;
   --     Ide : out Num_Etiq) is
   --  begin
   --     Te.Ne := Te.Ne+1;
   --     Ide := Te.Ne;
   --     Te.Te(Ide) := Ie;
   --  end Posa;
   function Nova_Etiq return Num_Etiq is
      --ie : Info_Etiq;
   begin
      Ne := Ne+1;
--      Ie := (TipE => Etiq_Num,
--             N    => Integer (Te.Ne));
--      Te.Te(Te.Ne):=ie;

      return Ne;
   end Nova_Etiq;



end Semantica;
