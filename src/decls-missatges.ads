with decls.dgenerals,
	 Ada.Text_IO;

use decls.dgenerals,
	Ada.Text_IO;

package decls.missatges is

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
	  tipusIdxErroniArray);

   procedure Obre_Fitxer;

   procedure Tanca_Fitxer;

   procedure error
     (te : in terror;
      l,c : in Natural;
      id : string);

   procedure error
     (te : in terror;
      id : string);

   procedure Impressio
     (msj : in string);

private

   log_file : File_Type;

end decls.missatges;
