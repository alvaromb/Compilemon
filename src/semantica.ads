with Decls.Dgenerals,
  Decls.Dtnode,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.dtsimbols,
  Ada.Text_Io,
  Decls.dtdesc;

use Decls.Dgenerals,
  Decls.Dtnode,
  Decls.D_Taula_De_Noms,
  Decls.D_Atribut,
  Decls.dtsimbols,
  Ada.Text_Io,
  Decls.dtdesc;

package Semantica is

   --Definicions basiques
   type tInstruccio is
     (--1 operand
      Global, --modificacion sobre los apuntes
      --.global .etiq_principal
      Rtn,
      Call,
      Preamb,
      Params,
      Etiqueta,
      Branc_Inc,
      -- 2 operands
      Negacio,
      Op_Not,
      Copia,
      Paramc,
      --3 operands
      Suma,
      Resta,
      Producte,
      Divisio,
      Modul,
      Op_And,
      Op_Or,
      Consindex,
      Asigindex,
      Menor,
      Menorigual,
      Igual,
      Majorigual,
      Major,
      Diferent);

   type tCamp is
     (Proc,
      Var,
      Etiq,
      Const);

   type Camp(tc : tCamp:=Const) is record
      case Tc is
         when Proc   => Idp : num_Proc;
         when Var    => Idv : num_var;
         when Etiq   => Ide : num_etiq;
         when Const  => Idc : num_var;
         when others => null;
      end case;
   end record;

   type c3a is record
      Instr : tInstruccio;
      Camp1 : Camp;
      Camp2 : Camp;
      Camp3 : Camp;
   end record;


   --Taula de procediments (es necessari el nprof i despl
   --que es troba decls-dtdesc
   --i aixo hauria d'anar a dgenerals)

   type Info_Proc is record
      Idn        : Id_Nom;
      Prof       : nprof;
      Ocup_Var   : Despl;
      Ocup_Param : Despl;
      Etiq       : num_etiq;
   end record;
	--en llamosi diu que hem de distinguir si es un proc intern i extern
	--i en l'extern nomes importa tenir un etiq : Idnom
   Info_Proc_Nul : Info_Proc :=
     (Idn => Id_Nul,
      Prof => 0,
      Ocup_Var   => 0,
      Ocup_Param => 0,
      Etiq => etiq_nul);

   type Taula_P is array
     (Num_Proc) of Info_Proc;

   type T_Procs is record
      Tp : Taula_P;
      Np : Num_Proc;
   end record;

   Tp : T_Procs;


   --Taula de variables
   type Info_Var is record
      Id       : Id_Nom;
      Np       : num_proc;
      Ocup     : Despl;
      Desp     : Despl;
      Tsub     : Tipussubjacent;
      Param    : Boolean;
      Const    : Boolean;
      Valconst : valor;
   end record;

   Info_Var_Nul : Info_Var :=
     (Id       => Id_Nul,
      Np       => proc_nul,
      Ocup     => 0,
      Desp     => 0,
      Tsub     => Tsnul,
      Param    => False,
      Const    => False,
      Valconst => 0);

   type taula_v is array
     (Num_Var) of Info_Var;

   type T_Vars is record
      Tv : taula_v;
      Nv : num_var;
   end record;
   Tv : T_Vars;

   -- Taula d'Etiquetes
   type Info_Etiq (TipE:Tipus_Etiq := Etiq_Num) is record
      case TipE is
         when Etiq_Num =>
            N:Integer;
         when Etiq_Proc =>
            Idpr: num_Proc;
      end case;
   end record;

   type Taula_E is array
     (num_Etiq) of Info_Etiq;

   type T_Etiqs is record
      Te : Taula_E;
      Ne : num_Etiq;
   end record;
   Te : T_Etiqs;

   Arbre : Pnode;

   -- Per els brancaments
   Zero,
   --Uno,
   MenysU : num_Var;



   -- Procediments
   procedure Abuit
     (P : out pnode);

   procedure creaNode_programa
     (P : out Atribut;
      A : in Atribut);

   procedure creaNode
     (p : out atribut;
      fe, fd : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fc, fd : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fce, fc, fd : in atribut;
      tn : in Tipusnode);

     procedure creaNode
     (p : out atribut;
      f : in atribut;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      fe, fd: in atribut;
      op : in operacio;
      tn : in Tipusnode);

   procedure creaNode
     (p : out atribut;
      f : in atribut;
      op : in operacio;
      tn : in Tipusnode);

   procedure CreaNode_ID
     (p : out atribut;
      id : in atribut;
      tn : in Tipusnode);

   procedure CreaNode_VAL
     (p : out atribut;
      a : in atribut;
      tn : in Tipusnode;
      S : in Valor);

   procedure CreaNode_MODE
     (P : out Atribut;
      M : in Mmode;
      Tn : in Tipusnode);

   procedure creaNode
     (P : out Atribut;
      Tn : in Tipusnode);

   procedure Remunta
     (P : out Atribut;
      A : in Atribut);

   procedure Cons_Tnode
     (P : in Pnode;
      Tn : out Tipusnode);

   -- Procediments per a les Taules
   procedure Noves_taules
     (Tp : out T_Procs;
      Tv : out T_Vars;
      Te : out T_Etiqs);

   -- Procediments per Taula de Procediments
   procedure Posa
     (Tp  : in out T_Procs;
      Ip  : in Info_Proc;
      Idp : out num_Proc);

   procedure Modif_Descripcio
     (Tp  : in out T_Procs;
      Idp : in num_proc;
      Ip  : in Info_Proc);

   -- Procediments per Taula de Variables
   procedure Posa
     (Tv : in out T_Vars;
      Iv : in Info_Var;
      Idv : out num_var);

   -- Procediments per a la Taula d'Etiquetes
   procedure Posa
     (Te  : in out T_Etiqs;
      Ie  : in Info_Etiq;
      Ide : out num_Etiq);

private

   Ts : Tsimbols;
   Tts: Ttsimbols;
   Tn : Taula_De_Noms;
   Nv : Num_Var;
   Np : Num_Proc;

end Semantica;
