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

with    decls.Dgenerals,
        decls.D_Taula_De_Noms;

use     decls.Dgenerals,
        decls.D_Taula_De_Noms;


package decls.d_atribut is

   type tipus_atribut is
     (atom,
      a_ident,
      a_lit);

   type valor is new integer;

   type atribut (t : tipus_atribut := atom) is record
       lin, col : natural;
       case t is
           when atom           => null;
           when a_ident        => idn : id_nom;
           when a_lit          => val : valor;
       end case;
   end record;


   procedure mt_atom
     (l, c : in natural;
         a : out atribut);

   procedure mt_identificador
     (l, c : in natural;
         s : in string;
         a : out atribut);

   procedure mt_string
     (l, c : in natural;
         s : in string;
         a : out atribut);

   procedure mt_caracter
     (l, c : in natural;
       car : in string;
         a : out atribut);

   procedure mt_numero
     (l, c : in natural;
         s : in string;
         a : out atribut);

   --Provisional
   Tn : Taula_De_Noms;


end decls.d_atribut;
