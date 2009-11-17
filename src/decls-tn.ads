-- ------------------------------------------------
--  Paquet de declaracions
-- ------------------------------------------------
--  Versio  :   0.1
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--      En aquest fitxer tenim declarada la
--  taula de noms perque sigui visible.
--
-- ------------------------------------------------

with    decls.d_taula_de_noms;

use     decls.d_taula_de_noms;


package decls.tn is

    --pragma pure;

    tn : taula_de_noms;


end decls.tn;
