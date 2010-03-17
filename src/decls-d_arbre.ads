

with Decls.Dtnode,
     decls.D_Taula_De_Noms,
     decls.d_atribut,
     Ada.text_io;

use Decls.Dtnode,
     decls.D_Taula_De_Noms,
     decls.d_atribut,
     Ada.text_io;


package decls.d_arbre is

    --procedure abuit(p: out node);

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
      fe, fd: in atribut;
     op : in operacio;
     tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      f : in atribut;
     op : in operacio;
     tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fd : in atribut;
      m : in Mmode;
     tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
     id : in atribut;
     tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      a : in atribut;
     tn : in Tipusnode);

    --Se ha pensado crear un 'creanode' por cada 'when':
        -- 1º parametro servira para el linkaje
        -- 2º parametro servira para el tipo de nodo
        -- Siguientes parametros informacion y nodos hijos

--  procedure posa(r: in out arbre; e: in character);
--  function consulta(i: in arbre) return character;
--  function existeix(r: in arbre) return boolean;
--  function fe(r: in arbre) return arbre;
--  function fc(r: in arbre) return arbre;
--  function fd(r: in arbre) return arbre;
--  function empelta(op: in character; fe: in arbre; fd: in arbre) return arbre;
--  procedure inordre_r(r: in arbre);



end decls.d_arbre;
