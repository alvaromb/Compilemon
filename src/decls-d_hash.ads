-- ------------------------------------------------
--  Paquet de declaracions de les funcions hash
-- ------------------------------------------------
--  Versio  :   0.2
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--  Especificacio de les funcions de hash:
--      - Hash de Pearson per accedir a la
--      taula de noms.
--
-- ------------------------------------------------

with    decls.dgenerals;

use     decls.dgenerals;


package decls.d_hash is

    pragma pure;

    function fdisp_tn (nom : in string)
                      return rang_dispersio;


end decls.d_hash;

