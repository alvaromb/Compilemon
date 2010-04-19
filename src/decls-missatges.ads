with decls.dgenerals,
         Ada.Text_IO;

use decls.dgenerals,
        Ada.Text_IO;

package Decls.Missatges is

   type Terror is
     (paramsPprincipal,
      id_existent,
      idProgDiferents,
      tipusParam,
      paramRepetit,
      enregArg,
      tipusInexistent,
      tipusSubIncorrecte,
      rang_sobrepassat,
      idCampRecordExistent,
      TsubjRangDif,
      TsubjDifTipus,
      ValEsqMajorDret,
      ValEsqMenor,
      ValDretMajor,
      TsubNoValid,
      argNoProc,
      tipusSubDiferents,
      posaIdxArray,
      TipusIdxErroniArray,
      Tsub_No_Bool,
      Tops_Diferents,
      Tsubs_Diferents,
      Tsub_No_Escalar,
      Tsub_No_Sencer);

   procedure Obre_Fitxer;

   procedure Tanca_Fitxer;

   procedure Error
     (Te : in Terror;
      L, C : in Natural;
      Id : String);

   procedure Error
     (Te : in Terror;
      Id : String);

   procedure Impressio
     (Msj : in String);

private

   Log_File : File_Type;

end Decls.Missatges;
