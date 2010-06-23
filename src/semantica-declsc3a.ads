with Decls.Dgenerals,
  Decls.Dtdesc,
  Ada.Sequential_Io,
  Ada.Text_Io,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus;

use Decls.Dgenerals,
  Decls.Dtdesc,
  Decls.D_Taula_De_Noms,
  Semantica.Ctipus;

package Semantica.Declsc3a is

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


--Taula de procediments (es necessari el nprof i despl que es troba decls-dtdesc
--i aixo hauria d'anar a dgenerals)

        type Info_Proc is record
                Idn        : Id_Nom;
        Prof       : nprof;
        Ocup_Var   : Despl;
        Ocup_Param : Despl;
        Etiq       : num_etiq;
        end record;

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
                Tsub     : tipussubjacent;
                Param    : Boolean;
                Const    : Boolean;
                Valconst : valor;
    end record;

        Info_Var_Nul : Info_Var := (Id       => Id_Nul,
                                Np       => proc_nul,
                                                                Ocup     => 0,
                                                                Desp     => 0,
                                                                Tsub     => Tsnul,
                                                                Param    => False,
                                                                Const    => False,
                                                                Valconst => 0);

        type taula_v is array (num_var) of Info_Var;

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

        type Taula_E is array (num_Etiq) of Info_Etiq;

        type T_Etiqs is record
       Te : Taula_E;
       Ne : num_Etiq;
        end record;

        Te : T_Etiqs;




--procediments i funcions

        --Inicializar las tablas
        procedure Noves_taules
                (Tp : out T_Procs;
                 Tv : out T_Vars;
                 Te : out T_Etiqs);

        --taula procediments
        procedure Nouproc
                (Tp  : in out T_Procs;
             Idp : out num_proc);

        procedure Posa
                (Tp  : in out T_Procs;
                 Ip  : in     Info_Proc;
                 Idp :    out num_Proc);

        function Consulta
                (Tp  : in  T_Procs;
             Idp : in  num_proc) return Info_Proc;

        procedure Modif_Descripcio
                (Tp  : in out T_Procs;
                 Idp : in     num_proc;
                 Ip  : in     Info_Proc);


        -- Taula variables
        procedure Posa
                (Tv : in out T_Vars;
                 Iv : in     Info_Var;
                 Idv :   out num_var);

        function Consulta
                (Tv  : in T_Vars;
                 Idv : in num_var) return Info_Var;

        procedure Modifica_Descripcion
                (Tv  : in out T_Vars;
                 Idv : in     num_var;
                 Iv  : in     Info_Var);

        procedure Novavar
                (Tv   : in out T_Vars;
                 Idpr : in     num_proc;
                 Idv  :    out num_var);

        procedure Novaconst
                (Tv   : in out T_Vars;
                 Vc   : in     Valor;
                 Tsub : in     tipussubjacent;
                 Idpr : in     num_proc;
                 Idc  :    out num_var);

        --taula d'etiquetes
        function Nova_Etiq return num_Etiq;

        procedure Posa
                (Te  : in out T_Etiqs;
         Ie  : in     Info_Etiq;
         Ide :    out num_Etiq);

        function Consulta
                (Te  : in     T_Etiqs;
         Ide : in     num_Etiq) return Info_Etiq;

        function Etiqueta
                (Te  : in     T_Etiqs;
         Ide : in     num_Etiq) return String;


        --Fitxers
        procedure Crea_Fitxer(Nom_Fitxer: in String);
        procedure Obrir_Fitxer(Nom_Fitxer: in String);
        procedure Tanca_Fitxer;
        procedure Llegir_Fitxer(Instruccio : out c3a);
        procedure Escriure_Fitxer(Instruccio : in c3a);
        function Fi_Fitxer return Boolean;

        --Función auxiliar para ver el contenido de las tablas
        procedure imprimeix_Taules;

private

        package Fitxer_Seq is new Ada.Sequential_Io(c3a);
        use Fitxer_Seq;
        F3as : Fitxer_Seq.File_Type;
        F3at : Ada.Text_Io.File_Type;

end Semantica.declsc3a;



