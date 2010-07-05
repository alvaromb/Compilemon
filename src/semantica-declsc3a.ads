with Decls.Dgenerals,
  Semantica,
  Decls.Dtdesc,
  Ada.Sequential_Io,
  Ada.Text_Io,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus,
  Ada.Strings,
  Ada.Strings.Fixed,
  Ada.Strings.Maps;

use Decls.Dgenerals,
  Semantica,
  Decls.Dtdesc,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus,
  Ada.Strings,
  Ada.Strings.Fixed,
  Ada.Strings.Maps;

package Semantica.Declsc3a is

   --taula procediments
   procedure Nouproc
     (Tp  : in out T_Procs;
      Idp : out num_proc);

   function Consulta
     (Tp  : in  T_Procs;
      Idp : in  num_proc) return Info_Proc;

   function Consulta
     (Tv  : in T_Vars;
      Idv : in num_var) return Info_Var;

   procedure Modif_Descripcio
     (Tv  : in out T_Vars;
      Idv : in num_var;
      Iv  : in Info_Var);

   procedure Novavar
     (Tv   : in out T_Vars;
      Idpr : in num_proc;
      Idv  : out num_var);

   procedure Novaconst
     (Tv   : in out T_Vars;
      Vc   : in Valor;
      Tsub : in tipussubjacent;
      Idpr : in num_proc;
      Idc  : out num_var);

   --Taula d'etiquetes
   function Nova_Etiq return num_Etiq;

   function Etiqueta
     (Ipr : in Info_Proc) return String;

   --Fitxers
   procedure Crea_Fitxer
     (Nom_Fitxer : in String);
   procedure Obrir_Fitxer
     (Nom_Fitxer : in String);
   procedure Tanca_Fitxer;
   procedure Llegir_Fitxer
     (Instruccio : out c3a);
   procedure Escriure_Fitxer
     (Instruccio : in c3a);
   function Fi_Fitxer return Boolean;

   --Funcio auxiliar
   procedure Imprimeix_Taules;

private
   package Fitxer_Seq is new Ada.Sequential_Io(c3a);
   use Fitxer_Seq;
   F3as : Fitxer_Seq.File_Type;
   F3at : Ada.Text_Io.File_Type;

end Semantica.Declsc3a;
