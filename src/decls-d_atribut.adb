
-- ------------------------------------------------
--  Paquet de procediments dels atributs
-- ------------------------------------------------
--  Versio  :   0.1
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

with    U_Lexica;
--  Decls.Tn;

use     U_Lexica;
--  Decls.Tn;


package body decls.d_atribut is


   procedure mt_atom
     (l, c : in natural;
         a : out atribut) is
   begin
       a := (atom, l, c);
   end mt_atom;


   procedure mt_identificador
     (l, c : in natural;
         s : in string;
         a : out atribut) is
      id : id_nom;
   begin
       id := id_nul;
       posa_id(tn, id, s);
       a := (a_ident, l, c, id);
   end mt_identificador;


   procedure mt_string
     (l, c : in natural;
         s : in string;
         a : out atribut) is
       id : rang_tcar;
   begin
       posa_str(tn, id, s);
       a := (a_lit, l, c, valor(id));
   end mt_string;


   procedure mt_caracter
     (l, c : in natural;
       car : in string;
         a : out atribut) is
   begin
      a := (a_lit, l, c, valor(car'First+1));
   end mt_caracter;


   procedure mt_numero
     (l, c : in natural;
         s : in string;
         a : out atribut) is
   begin
       a := (a_lit, l, c, valor(Integer'value(s)));
   end mt_numero;


end decls.d_atribut;
