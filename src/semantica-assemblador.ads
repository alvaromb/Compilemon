with Ada.Text_Io;

use Ada.Text_Io;

package Semantica.Assemblador is
   Error_Assemblador : exception;
   procedure Genera_Assemblador
     (Nom_Fitxer : in String);

private
   Fitxer_Asmbl : File_Type;
end Semantica.Assemblador;
