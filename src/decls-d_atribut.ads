-- ------------------------------------------------
--  Paquet de procediments dels atributs
-- ------------------------------------------------
--  Versio  :   0.2
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      En aquest fitxer tenim implementats les
--  assignacions de cada tipus de token al tipus
--  atribut que li correspon. Cal destacar
--  l'utilitzacio de la taula de noms en els
--  casos d'identificadors i strings.
--
-- ------------------------------------------------

with    Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Decls.Dtnode,
        Decls.Dtdesc;

use     Decls.Dgenerals,
        Decls.D_Taula_De_Noms,
        Decls.Dtnode,
        Decls.Dtdesc;

package decls.d_atribut is

  type atribut (t : tipus_atribut := atom) is record
      lin, col : natural;
      case t is
          when Atom      => null;
          when A_Ident   => idn : id_nom;
          when A_Lit_C | A_Lit_N | A_Lit_S
            => val : valor;
          when others    => a   : pnode;
      end case;
  end record;

end decls.d_atribut;
