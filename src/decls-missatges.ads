with    decls.dgenerals,
        Ada.Text_IO;

use     decls.dgenerals,
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
      Tsub_No_Sencer,
      Tipus_No_Desc,
      Id_No_Reconegut,
      Id_No_Cridaproc,
      Assig_Tipus_Diferents,
      Exp_No_Bool,
      Rec_No_Cridaproc,
      Falta_Param_Proc,
      Refvar_No_Proc,
      Falta_Param_Array,
      Reccamp_No_Valid,
      Idrec_No_Valid,
      Sobren_Parametres,
      Tparam_No_Coincident,
      Tipus_No_Array,
      Tproc_No_Param);

   procedure Obre_Fitxer(nom_fitxer: in string);

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
