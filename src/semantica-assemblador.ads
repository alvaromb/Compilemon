with Ada.Text_Io;

use Ada.Text_Io;

package Semantica.Assemblador is
   Error_Assemblador : exception;
   procedure Genera_Assemblador
     (Nom_Fitxer : in String);

private
   Nproc : Num_Proc := 0;
   Fitxer_Asmbl : File_Type;
end Semantica.Assemblador;
