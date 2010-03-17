

package body decls.d_arbre is

    --procedure abuit(p: out node) is

        --nodebuit : node(tbuit);

    --begin

        --p := nodebuit;

    --end abuit;



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



    procedure creaNode(p : out atribut; fe,fc,fd : in atribut; tn : in Tipusnode) is

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
         p := (nodeArbre, 0, 0,paux);
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



    procedure CreaNode
      (p : out atribut;
       fe, fd : in atribut;
       m : in Mmode;
       tn : in Tipusnode) is
        paux : pnode;
    begin
        paux := new node(tn);
        paux.fe10 := fe.a;
        paux.fd10 := fd.a;
        paux.m10 := m;
        p := (nodeArbre, 0, 0, paux);
    end creaNode;


    procedure CreaNode
      (p : out atribut;
       f : in atribut;
       m : in Mmode;
       tn : in Tipusnode) is
        paux : pnode;

    begin
        paux := new node(tn);
        paux.f11 := f.a;
        paux.m11 := m;
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
      tn : in Tipusnode) is
       paux : pnode;

    begin
       paux := new node(tn);
       paux.val := a.val;
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


    procedure Remunta
      (P : out Atribut;
       A : in Atribut) is
    begin
       P := A;
    end Remunta;



end decls.d_arbre;

