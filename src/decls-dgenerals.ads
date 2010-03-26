-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versio  :   0.3
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--  Declaracions generals.
--
-- ------------------------------------------------

package decls.dgenerals is

    --pragma pure;

    max_id : constant integer := 1000;
    long_num_ident : constant integer := 40;

    max_var : constant integer := 1000;
    type num_var is new natural
      range 0 .. max_var;

    max_proc : constant integer := 100;
    type num_proc is new natural
      range 0 .. max_proc;

    type valor is new Integer
      range integer'First.. integer'Last;

    type tipus_atribut is
      (atom,
       a_ident,
       A_Lit_C,
       A_Lit_N,
       A_Lit_S,
       nodeArbre);


end decls.dgenerals;
