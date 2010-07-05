-- DECLS-D_ATRIBUT.ads
-- Paquet de declaracions d'atributs

with    Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Decls.Dtnode,
        Decls.Dtdesc;

use     Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Decls.Dtnode,
        Decls.Dtdesc;

package Decls.D_Atribut is

  type Atribut (T : Tipus_Atribut := Atom) is record
      Lin, Col : Natural;
      case T is
          when Atom      => null;
          when A_Ident   => Idn : Id_Nom;
          when A_Lit_C | A_Lit_N | A_Lit_S
            => Val : Valor;
          when others    => A : Pnode;
      end case;
  end record;

end Decls.D_Atribut;
