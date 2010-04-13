

package body decls.d_arbre is

   procedure Abuit
     (P : out pnode) is
   begin
       p := null;
   end abuit;


   procedure creaNode_programa
     (p : out atribut;
      fe, fd : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      --put_line("entram a la merda de creanodeprograma");
      paux := new node(tn);
      paux.fe1 := fe.a;
      paux.fd1 := fd.a;
      p := (nodeArbre, 0, 0, paux); --aixo pot sobrar?
      --put_line("assignam l'arbre arrel");
      arbre := paux;
   end creaNode_programa;


   procedure creaNode
     (p : out atribut;
      fe,fd : in atribut;
      tn : in Tipusnode) is
      paux : pnode;
   begin
      --put_line("tipusnode: "&tn'img);
      paux := new node(tn);
      paux.fe1 := fe.a;
      paux.fd1 := fd.a;
      p := (nodeArbre, 0, 0, paux);
      --Put_Line("tipusnode: "&tn'img);
   end creaNode;


   procedure CreaNode
     (p : out atribut;
      fe,fc,fd : in atribut;
      tn : in Tipusnode) is
        paux : pnode;
   begin
       --put_line("tipusnode: "&tn'img);
       paux := new node(tn);
       paux.fe2 := fe.a;
       paux.fd2 := fd.a;
       paux.fc2 := fc.a;
       p := (nodeArbre, 0, 0, paux);
       --Put_Line("tipusnode: "&tn'img);
   end creaNode;


   procedure creaNode
     (p : out atribut;
     fe, fd : in atribut;
     op : in operacio;
     tn : in Tipusnode) is
       paux : pnode;
   begin
      --put_line("tipusnode: "&tn'img);
      paux := new node(tn);
      paux.fe3 := fe.a;
      paux.fd3 := fd.a;
      paux.op3 := op;
      p := (nodeArbre, 0, 0, paux);
      ---Put_Line("tipusnode: "&tn'img);
   end creaNode;


   procedure CreaNode
     (p : out atribut;
      f : in atribut;
     op : in operacio;
     tn : in Tipusnode) is
       paux : pnode;
   begin
      ---put_line("tipusnode: "&tn'img);
      paux := new node(tn);
      paux.f4 := f.a;
      paux.op4 := op;
      p := (nodeArbre, 0, 0,paux);
      --Put_Line("tipusnode: "&tn'img);
   end creaNode;


   procedure CreaNode
      (p : out atribut;
       fe, fce, fc, fd : in atribut;
       tn : in Tipusnode) is
        paux : pnode;

    begin
        --put_line("tipusnode: "&tn'img);
        paux := new node(tn);
        paux.fe5 := fe.a;
        paux.fc5 := fce.a;
        paux.fd5 := fc.a;
        paux.fid5 := fd.a;
        p := (nodeArbre, 0, 0, paux);
        --Put_Line("tipusnode: "&tn'img);
    end creaNode;
    
    procedure creaNode
     (p : out atribut;
      f : in atribut;
      tn : in Tipusnode) is

        paux : pnode;

    begin
        --put_line("tipusnode: "&tn'img);
        paux := new node(tn);
        paux.f6 := f.a;
        p := (nodeArbre, 0, 0, paux);
        --Put_Line("tipusnode: "&tn'img);
    end creaNode;

    -- Crea node per identificadors
    procedure CreaNode_ID
      (p : out atribut;
      id : in atribut;
      tn : in Tipusnode) is
       paux : pnode;

    begin
       --put_line("tipusnode: "&tn'img);
       paux := new node(tn);
       paux.id12 := id.idn;
       paux.l1 := id.lin;
       paux.c1 := id.col;
       p := (nodeArbre, 0, 0, paux);
       --Put_Line("tipusnode: "&tn'img);
    end CreaNode_ID;


    procedure CreaNode_VAL
      (p : out atribut;
       a : in atribut;
      tn : in Tipusnode;
       S : in Valor) is
       paux : pnode;

    begin
       --put_line("tipusnode: "&tn'img);
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
       --Put_Line("tipusnode: "&tn'img);
    end CreaNode_VAL;


    procedure Creanode_MODE
      (P : out Atribut;
       M : in mmode;
       Tn : in Tipusnode) is

       Paux : Pnode;

    begin
       --put_line("tipusnode: "&tn'img);
       Paux := new Node(Tn);
       Paux.M12 := M;
       P := (NodeArbre, 0, 0, Paux);
       --Put_Line("tipusnode: "&tn'img);
    end Creanode_Mode;


    procedure creaNode
      (P : out Atribut;
      Tn : in Tipusnode) is

      Paux : Pnode;
    begin
      --Put_Line("tipusnode: "&tn'img);
      Paux := new Node(tn);
      P := (NodeArbre, 0, 0, Paux);
      --Put_Line("tipusnode: "&tn'img);
    end creaNode;


    procedure Remunta
      (P : out Atribut;
       A : in Atribut) is
    begin
       --put_line("remuntam");
       P := A;
    end Remunta;


    procedure Cons_Tnode
      (P : in Pnode;
      Tn : out Tipusnode) is
    begin
       Tn := P.Tipus;
    end Cons_Tnode;


end decls.d_arbre;

