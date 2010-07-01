with Ada.Text_Io,
  Ada.Strings,
  Ada.Strings.Fixed,
  Ada.Strings.Maps;

use Ada.Text_Io,
  Ada.Strings,
  Ada.Strings.Fixed,
  Ada.Strings.Maps;

package Semantica.Assemblador is
   Error_Assemblador : exception;
   procedure Genera_Assemblador
     (Nom_Fitxer : in String);

private
   Nproc : Num_Proc := 0;
   Fitxer_Asmbl : File_Type;
end Semantica.Assemblador;
