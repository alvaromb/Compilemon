-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--  Especificacio de l'estructura necessaria
-- per el maneig de la taula de noms i dels metodes
-- per tractar-la.
--
-- ------------------------------------------------

with    decls.dgenerals,
        decls.d_hash;

use     decls.dgenerals,
        decls.d_hash;


package decls.d_taula_de_noms is

    --pragma pure;

    -- Excepcions
    E_Tids_Plena : exception;
    E_Tcar_Plena : exception;

    type taula_de_noms is limited private;

    procedure tbuida    (tn : out taula_de_noms);

    procedure posa_id   (tn : in out taula_de_noms;
                        idn : out id_nom;
                        nom : in string);

    procedure posa_str  (tn : in out taula_de_noms;
                        ids : out rang_tcar;
                          s : in string);

    function cons_nom   (tn : in taula_de_noms;
                        idn : in id_nom) return string;

    function cons_str   (tn : in taula_de_noms;
                        ids : in rang_tcar) return string;


private

    type t_identificador is record
            pos_tcar : rang_tcar;
             seguent : id_nom;
        long_paraula : Natural;
    end record;

    type taula_identificadors is array
      (1 .. id_nom'Last) of t_identificador;

    type taula_caracters is array (rang_tcar)
      of character;

    type taula_de_noms is record
         td : taula_dispersio;
        tid : taula_identificadors;
         tc : taula_caracters;
        nid : id_nom;
       ncar : rang_tcar;
    end record;


end decls.d_taula_de_noms;
