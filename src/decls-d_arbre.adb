

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
      p := (nodeArbre, 0, 0,paux);
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


    procedure creaNode(p : out atribut; fe,fd: in atribut; op : in operacio; tn : in Tipusnode) is

        paux : pnode;

    begin

         paux := new node(tn);
         paux.fe3 := fe.a;
         paux.fd3 := fd.a;
         paux.op3 := op;

         p := (nodeArbre, 0, 0, paux);

    end creaNode;


    procedure creaNode(p : out atribut; f : in atribut; op : in operacio; tn : in Tipusnode) is

        paux : pnode;

    begin

         paux := new node(tn);
         paux.f4 := f.a;
         paux.op4 := op;

         p := (nodeArbre, 0, 0,paux);

    end creaNode;


    procedure creaNode(p : out atribut; fe,fce,fc,fd : in atribut; tn : in Tipusnode) is

        paux : pnode;

    begin

        paux := new node(tn);

        paux.fe5 := fe.a;
        paux.fc5 := fce.a;
        paux.fd5 := fc.a;
        paux.fid5 := fd.a;

        p := (nodeArbre, 0, 0, paux);

    end creaNode;



    procedure creaNode(p : out atribut; fe, fd : in atribut; m : in Mmode; tn : in Tipusnode) is

        paux : pnode;

    begin

        paux := new node(tn);

        paux.fe10 := fe.a;
        paux.fd10 := fd.a;
        paux.m10 := m;

        p := (nodeArbre, 0, 0, paux);

    end creaNode;


    procedure creaNode(p : out atribut; f : in atribut; m : in Mmode; tn : in Tipusnode) is

        paux : pnode;

    begin

        paux := new node(tn);

        paux.f11 := f.a;
        paux.m11 := m;

        p := (nodeArbre, 0, 0, paux);

    end creaNode;


    procedure creaNode(p : out atribut; id : in id_nom; tn : in Tipusnode) is

        paux : pnode;

    begin

        paux := new node(tn);

        paux.id12 := id;

        p := (nodeArbre, 0, 0, paux);

    end creaNode;


    procedure creaNode(p : out atribut; a: in atribut; tn : in Tipusnode) is

        paux : pnode;

    begin

        paux := new node(tn);

        paux.val := a.val;

        p := (nodeArbre, 0, 0, paux);

    end creaNode;


end decls.d_arbre;

