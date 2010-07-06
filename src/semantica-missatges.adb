package body Semantica.Missatges is

   procedure Obre_Fitxer
     (Nomfitxer : in String) is
   begin
      Create(Log_File, Out_File, Nomfitxer&".log");
   end Obre_Fitxer;

   procedure Tanca_Fitxer is
   begin
      Close(log_file);
   end Tanca_Fitxer;

   procedure Impressio
     (Msj : in String) is
   begin
      put_line(log_file, "ERROR CompiLEMON: " & msj);
      put_line("ERROR CompiLEMON: " & msj);
   end Impressio;

   procedure Error
     (Te : in Terror;
      L, C : in Natural;
      Id : String) is
   begin
      case te is
         when id_existent =>
            Impressio("l:"&l'img&" c:"&c'img&
                        " L'identificador '"&id&
                        "' ja existeix");
         when idProgDiferents =>
            Impressio("l:"&l'img&" c:"&c'img&
                        " Possible escritura "&
                        "erronea de '"&Id&"'");
         when tipusParam =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El tipus del parametre "&
                           id&" es incorrecte");
         when enregArg =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Error al enregistrar"&
                        " l'argument");
         when paramRepetit =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El param "&id&
                        " es troba repetit");
         when tipusSubDiferents =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Tipus subjacents "&
                        "diferents "&id);
         when tipusInexistent =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El tipus "&id&" no "&
                        "existeix o no es correcte");
         when tipusSubIncorrecte =>
            --Aqui donam prioritat al tipus que declaram per
            --sobre del tipus. Si son diferents assignam l'erroni
            Impressio("l: "&l'img&" c: "&c'img&
                        " El tipus "&id&
                        " no es correspon amb el tipus"&
                        " de la variable");
         when rang_sobrepassat =>
            Impressio("l: "&l'img&" c: "&c'img&" El "&
                        "valor de la constant "&
                        id&" surt del rang");
         when idCampRecordExistent =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Ja existeix un camp "&
                        id&" en aquest record");
         when TsubjRangDif =>
            Impressio("l: "&l'img&" c: "&c'img&
                        "Els Tsubjacents dels "&
                        "limits del subtipus "&id&
                        " son diferents");
         when ValEsqMajorDret =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El valor del limit "&
                        "Esquerra no pot esser major"&
                        " que el Dret en "&
                        "la declaracio del subrang: "&id);
         when TsubjDifTipus =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Els Tsubjacents dels "&
                        "limits del subtipus"&id&
                        " son diferents al "&
                        "tipus assignat");
         when ValEsqMenor =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El valor esquerra es menor"&
                        "al permes en el subtipus"&id);
         when ValDretMajor =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " El valor dret es major"&
                        "al permes en el subtipus"&id);
         when TsubNoValid =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Tipus subjacent no valid"&
                        " per al subrang"&id);
         when argNoProc =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " L'identificador de "&
                        "l'argument no es un procediment"
                        &id);
         when posaIdxArray =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " Error al enregistrar "&
                        "l'index "&id&" en un array");
         when tipusIdxErroniArray =>
            Impressio("l: "&l'img&" c: "&c'img&
                        " L'index d'un array nomes"&
                        " pot esser d'un tipus, "&
                        "aquest es d' "&Id);
         when Tsub_No_Bool =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " L'operand "&id&" no es de "&
                        "tipus boolea");
         when Tops_Diferents =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Els tipus dels operands son"&
                        " diferents");
         when Tsubs_Diferents =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Els tipus subjacents son "&
                        "diferents");
         when Tsub_No_Escalar =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus subjacent "&id&
                        " no es escalar");
         when Tsub_No_Sencer =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus subjacent "&Id&
                        " no es sencer");
         when Tipus_No_Desc =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus no es una "&
                        "descripcio de tipus "&Id);
         when Id_No_Reconegut =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " L'identificador "&Id&
                        " no es reconegut");
         when Id_No_Cridaproc =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " L'identificador "&Id&
                        " nomes pot representar una"&
                        " crida a procediment"&
                        " sense parametres");
         when Assig_Tipus_Diferents =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " L'assignacio es de tipus "&
                        "diferents");
         when Exp_No_Bool =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " L'expressio per un "&Id&
                        " ha d'esser booleana");
         when Rec_No_Cridaproc =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " No es pot utilitzar un "&
                        "record com una crida a"&
                        " procediment");
         when Falta_Param_Proc =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Falten parametres al "&
                        "procediment");
         when Refvar_No_Proc =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " No pot esser un procediment");
         when Falta_Param_Array =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Falten parametres a l'array");
         when Reccamp_No_Valid =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Camp no valid en l'acces "&
                        "a referencia");
         when Idrec_No_Valid =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " '"&Id&"' no es un nom de "&
                        "camp valid");
         when Sobren_Parametres =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " Sobren parametres");
         when Tparam_No_Coincident =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus del parametre no "&
                        "coincideix amb el tipus "&
                        "demanat "&Id);
         when Tipus_No_Array =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus '"&Id&"' no es un "&
                        "array");
         when Tproc_No_Param =>
            Impressio("l:"&L'Img&" c:"&C'Img&
                        " El tipus no es un "&
                        "procediment amb parametres "&Id);
         when others => null;
      end case;
   end Error;

   procedure Error
     (Te : in Terror;
      Id : String) is
   begin
      case Te is
         when paramsPprincipal =>
            Impressio("El programa principal "&
                        "no pot tenir parametres");
         when id_existent =>
            Impressio("l'identificador ja existeix");
         when others => null;
      end case;
   end Error;

end Semantica.Missatges;
