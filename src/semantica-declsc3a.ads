with Decls.Dgenerals,
  Semantica,
  Decls.Dtdesc,
  Ada.Sequential_Io,
  Ada.Text_Io,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus;

use Decls.Dgenerals,
  Semantica,
  Decls.Dtdesc,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus;

package Semantica.Declsc3a is

   --procediments i funcions
   --Inicializar las tablas --OJO A ESTE NOMBRE!!!!
   --procedure Noves_taules
   --  (Tp : out T_Procs;
   --   Tv : out T_Vars;
   --   Te : out T_Etiqs);

   --taula procediments
   procedure Nouproc
     (Tp  : in out T_Procs;
      Idp : out num_proc);

   --procedure Posa
   --  (Tp  : in out T_Procs;
   --   Ip  : in Info_Proc;
   --   Idp : out num_Proc);

   function Consulta
     (Tp  : in  T_Procs;
      Idp : in  num_proc) return Info_Proc;

   --procedure Modif_Descripcio
   --  (Tp  : in out T_Procs;
   --   Idp : in num_proc;
   --   Ip  : in Info_Proc);

   -- Taula variables
   --procedure Posa
   --  (Tv : in out T_Vars;
   --   Iv : in Info_Var;
   --   Idv : out num_var);

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

   --taula d'etiquetes
   function Nova_Etiq return num_Etiq;

   --procedure Posa
   --  (Te  : in out T_Etiqs;
   --   Ie  : in Info_Etiq;
   --   Ide : out num_Etiq);

   function Consulta
     (Te  : in T_Etiqs;
      Ide : in num_Etiq) return Info_Etiq;

   function Etiqueta
     (Te  : in T_Etiqs;
      Ide : in num_Etiq) return String;

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

   --Funcion auxiliar para ver el contenido de las tablas
   procedure imprimeix_Taules;

private
   package Fitxer_Seq is new Ada.Sequential_Io(c3a);
   use Fitxer_Seq;
   F3as : Fitxer_Seq.File_Type;
   F3at : Ada.Text_Io.File_Type;

end Semantica.declsc3a;



