with    Decls.Dgenerals,
        Decls.Dtnode,
        decls.D_Taula_De_Noms,
        decls.d_atribut,
        Ada.text_io;

use     Decls.Dgenerals,
        Decls.Dtnode,
        decls.D_Taula_De_Noms,
        decls.d_atribut,
        Ada.text_io;

package decls.d_arbre is

   Arbre : Pnode;

   procedure Abuit
     (P : out pnode);

   procedure creaNode_programa
     (P : out Atribut;
      A : in Atribut);

   procedure creaNode
     (p : out atribut;
      fe, fd : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fc, fd : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fce, fc, fd : in atribut;
      tn : in Tipusnode);

     procedure creaNode
     (p : out atribut;
      f : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fd: in atribut;
      op : in operacio;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      f : in atribut;
      op : in operacio;
      tn : in Tipusnode);

   procedure CreaNode_ID
     (p : out atribut;
      id : in atribut;
      tn : in Tipusnode);

   procedure CreaNode_VAL
     (p : out atribut;
      a : in atribut;
      tn : in Tipusnode;
      S : in Valor);

   procedure CreaNode_MODE
     (P : out Atribut;
      M : in Mmode;
      Tn : in Tipusnode);

   procedure creaNode
     (P : out Atribut;
      Tn : in Tipusnode);

   procedure Remunta
     (P : out Atribut;
      A : in Atribut);

   procedure Cons_Tnode
     (P : in Pnode;
     Tn : out Tipusnode);

end decls.d_arbre;
