-- ------------------------------------------------
--  Paquet de declaracions generals
-- ------------------------------------------------
--  Versio  :   0.2
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--  Declaracions generals.
--
-- ------------------------------------------------

package decls.dgenerals is

    pragma pure;

    -- TAULA DE NOMS
    max_id : constant integer := 1000;
    type id_nom is new integer
      range 0 .. max_id;

    -- Valor nul per al tipus id_nom
    id_nul : constant id_nom := 0;

    long_num_ident : constant integer := 40;
    type rang_tcar is new integer
      range 0 .. (long_num_ident*max_id);

    -- Taula de dispersio:
    tam_dispersio : constant integer := 101;
    type rang_dispersio is new integer
      range -1 .. tam_dispersio;

    -- Valor nul per el rang dispersio
    dispersio_nul : constant rang_dispersio := -1;

    type taula_dispersio is array (rang_dispersio)
      of id_nom;


end decls.dgenerals;
