package body semantica.declsc3a is

   --Taula Procediments
   procedure Nouproc
     (Tp  : in out T_Procs;
      Idp :    out num_proc) is
   begin
      Posa(Tp, Info_Proc_Nul, Idp);
   end Nouproc;


   function Consulta
     (Tp  : in  T_Procs;
      Idp : in  num_proc) return Info_Proc is
   begin
      return Tp.Tp(Idp);
   end Consulta;


   --Taula Variables
   function Consulta
     (Tv  : in T_Vars;
      Idv : in num_var) return Info_Var is
   begin
      return Tv.Tv(Idv);
   end Consulta;


   procedure Modif_Descripcio
     (Tv  : in out T_Vars;
      Idv : in num_var;
      Iv  : in Info_Var) is
   begin
      Tv.Tv(Idv):=Iv;
   end Modif_Descripcio;


   procedure Novavar
     (Tv   : in out T_Vars;
      Idpr : in num_proc;
      Idv  : out num_var) is

      Ip        : Info_Proc := Info_Proc_Nul;
      Iv        : Info_Var  := Info_Var_Nul;
      Numvar    : Integer   := Integer (Tv.Nv) + 1;
      Nomvar    : String    := "_var" & Integer'Image(Numvar);
      Idn       : Id_Nom;

   begin
      Nomvar(Nomvar'First + 4) := '_' ;
      Posa_Id(Tn, Idn, Nomvar);
      Ip:=Consulta(Tp, Idpr);
      Iv:=(Id       => Idn,
           Np       => Idpr,
           Ocup     => Integer'Size / 8,
           Desp     => 0,
           Tsub     => Tsent,
           Param    => False,
           Const    => False,
           Valconst => 0);

      Ip.Ocup_Var:=Ip.Ocup_Var+Iv.Ocup;
      Posa(Tv, Iv, Idv);
      Modif_Descripcio(Tp, Idpr, Ip);

   end Novavar;


   procedure Novaconst
     (Tv   : in out T_Vars;
      Vc   : in     Valor;
      Tsub : in     tipussubjacent;
      Idpr : in     num_proc;
      Idc :    out num_var) is

      Idn      : Id_Nom;
      --Ip       : Info_Proc;
      E        : Boolean;
      Iv       : Info_Var;
      D        : Descrip;
      Ocup     : Despl;
      Nconst   : num_var := Tv.Nv + 1;
      Nomconst : String  := "_cnt" & Nconst'img;

   begin

      Nomconst(Nomconst'First + 4):='_';

      if Tsub=Tsarr then
         Ocup:=16*Integer'Size;
         Nomconst(2..4):="str";
      else
         Ocup:=Integer'Size/8;
      end if;

      Posa_Id(Tn, Idn, Nomconst);
      --Ip:=Consulta(Tp, Idpr); -- No se emplea en ningun sitio

      Iv:=(Id       => Idn,
           Np       => Idpr,
           Ocup     => Integer'Size / 8,-- what? Ocup
           Desp     => 0,
           Tsub     => Tsub,
           Param    => False,
           Const    => True,
           Valconst => Vc);

      Posa(Tv, Iv, Idc);

      D:=(Dconst,
          Id_Nul,
          Vc,
                  Nconst);

      Posa(Ts, Idn, D, E);

   end Novaconst;



   --taula d'etiquetes
   function Nova_Etiq return Num_Etiq is
   begin
      Ne := Ne + 1;
      return Ne;
   end Nova_Etiq;


   --  function Consulta
   --    (Te  : in T_Etiqs;
   --     Ide : in num_Etiq) return Info_Etiq is

   --  begin
   --     return Te.Te(Ide);
   --  end Consulta;

   --------
   function Etiqueta
     (Idpr : in num_Proc) return String is

      Nomproc : String := Cons_nom(Tn, Consulta(Tp, Idpr).Idn);

   begin
      return "_" & Nomproc;
   end Etiqueta;
   ---

   function Etiqueta
     (N : in Integer) return String is
      Text : String := "_etq" & Integer'Image (N);
   begin
      Text(Text'First+4):='_';
      return Text;
   end Etiqueta;

   ---

   --  function Etiqueta
   --    (Ide : in Num_Etiq) return String is
   --     Ie : Info_Etiq;
   --  begin
   --     Ie:=Consulta(Te, Ide);
   --     case Ie.TipE is
   --        when Etiq_Num =>
   --           return Etiqueta (Ie.N);
   --        when Etiq_Proc =>
   --           return Etiqueta (Ie.Idpr);
   --     end case;
   --  end Etiqueta;

   function Etiqueta
     (Ipr : in Info_Proc) return String is
   begin
      case Ipr.Tp is
         when Intern =>
            return "_etq_" & Ipr.Etiq'Img;
         when Extern =>
            return "_" & Cons_Nom(Tn, Ipr.Etiq_Extern);
      end case;
   end Etiqueta;


   -----


   --Fitxers
   procedure Crea_Fitxer(Nom_Fitxer: in String) is
   begin
      Create(F3as, Out_File, Nom_Fitxer&".c3as");
      Create(F3at, Out_File, Nom_Fitxer&".c3at");
   end Crea_Fitxer;


   procedure Obrir_Fitxer(Nom_Fitxer: in String) is
   begin
      Open(F3as, In_File, Nom_Fitxer&".c3as");
   end Obrir_Fitxer;


   procedure Tanca_Fitxer is
   begin
      Close(F3as);
   end Tanca_Fitxer;


   procedure Llegir_Fitxer
     (Instruccio : out c3a) is
   begin
      Read(F3as, Instruccio);
   end Llegir_Fitxer;


   procedure Escriure_Fitxer
     (Instruccio : in c3a) is
   begin

      --escriptura a arxiu binari
      Write(F3as, Instruccio);
      --escriptura a arxiu de text
      Put(F3at, Instruccio.Instr'Img & Ascii.Ht);

      if Instruccio.Instr <= Branc_Inc then
         --1 operand
         case Instruccio.Camp1.Tc is
            when Proc =>
               Put_Line(F3at, Instruccio.Camp1.Idp'Img);
            when Var =>
               Put_Line(F3at, Instruccio.Camp1.Idv'Img);
            when Const =>
               Put_Line(F3at, Instruccio.Camp1.Idc'Img);
            when Etiq =>
               Put_Line(F3at, Instruccio.Camp1.Ide'Img);
            when others =>
               null;
         end case;

      elsif Instruccio.Instr <= Paramc then
         -- 2 operands
         case Instruccio.Camp1.Tc is
            when Proc =>
               Put(F3at, Instruccio.Camp1.Idp'Img & Ascii.Ht);
            when Var =>
               Put(F3at, Instruccio.Camp1.Idv'Img & Ascii.Ht);
            when Const =>
               Put(F3at, Instruccio.Camp1.Idc'Img & Ascii.Ht);
            when Etiq =>
               Put(F3at, Instruccio.Camp1.Ide'Img & Ascii.Ht);
            when others =>
               null;
         end case;

         case Instruccio.Camp2.Tc is
            when Proc =>
               Put_Line(F3at, Instruccio.Camp2.Idp'Img);
            when Var =>
               Put_Line(F3at, Instruccio.Camp2.Idv'Img);
            when Const =>
               Put_Line(F3at, Instruccio.Camp2.Idc'Img);
            when Etiq =>
               Put_Line(F3at, Instruccio.Camp1.Ide'Img);--?
            when others =>
               null;
         end case;

      else
         -- 3 operands
         case Instruccio.Camp1.Tc is
            when Proc =>
               Put(F3at, Instruccio.Camp1.Idp'Img & Ascii.Ht);
            when Var =>
               Put(F3at, Instruccio.Camp1.Idv'Img & Ascii.Ht);
            when Const =>
               Put(F3at, Instruccio.Camp1.Idc'Img & Ascii.Ht);
            when Etiq =>
               Put(F3at, Instruccio.Camp1.Ide'Img & Ascii.Ht);
            when others =>
               null;
         end case;

         case Instruccio.Camp2.Tc is
            when Proc =>
               Put(F3at, Instruccio.Camp2.Idp'Img & Ascii.Ht);
            when Var =>
               Put(F3at, Instruccio.Camp2.Idv'Img & Ascii.Ht);
            when Const =>
               Put(F3at, Instruccio.Camp2.Idc'Img & Ascii.Ht);
            when Etiq =>
               Put(F3at, Instruccio.Camp1.Ide'Img & Ascii.Ht); --?
            when others =>
               null;
         end case;

         case Instruccio.Camp3.Tc is
            when Proc =>
               Put_Line(F3at, Instruccio.Camp3.Idp'Img);
            when Var =>
               Put_Line(F3at, Instruccio.Camp3.Idv'Img);
            when Const =>
               Put_Line(F3at, Instruccio.Camp3.Idc'Img);
            when Etiq =>
               Put_Line(F3at, Instruccio.Camp3.Ide'Img); --tocat, abans camp1
            when others =>
               null;
         end case;

      end if;

   end Escriure_Fitxer;


   function Fi_Fitxer return Boolean is
   begin
      return End_Of_File(F3as);
   end Fi_Fitxer;




   procedure imprimeix_Taules is
   begin

      --if Debug then
      Put_Line("");
      Put_Line("-------------------------------------------------");
      Put_Line("Contenido de la tabla de procedimientos:");

      for I in num_Proc range 1..Tp.Np loop
         if Tp.Tp(I).Tp = Intern then
            Put_Line("Procediment: " & I'Img);
            Put_Line("     prof: " & Tp.Tp(I).Prof'Img);
            Put_Line("     ocup varl: " & Tp.Tp(I).Ocup_Var'Img);
            Put_Line("     ocup param: " & Tp.Tp(I).Ocup_Param'Img);
            Put_Line("     etiqueta: " & Tp.Tp(I).Etiq'Img);
         end if;
      end loop;

      Put_Line("-------------------------------------------------");
      Put_Line("Contenido de la tabla de variables:");
      for I in num_Var range 1..Tv.Nv loop
         Put_Line("Variable: " & I'Img);
         Put_Line("     nom:" & Cons_nom(Tn, Tv.Tv(I).Id));
         Put_Line("     proc:" & Tv.Tv(I).Np'Img);
         Put_Line("     ocup:" & Tv.Tv(I).Ocup'Img);
         Put_Line("     dpv:" & Tv.Tv(I).Desp'Img);
         Put_Line("     tsub:" & Tv.Tv(I).Tsub'Img);
         Put_Line("     param:" & Tv.Tv(I).Param'Img);
         Put_Line("     const:" & Tv.Tv(I).Const'Img);
         Put_Line("     valconst:" & Tv.Tv(I).Valconst'Img);

         if Tv.Tv(I).Tsub=TSARR and Tv.Tv(I).Const then
            Put_Line("          " & Cons_str(Tn,  rang_tcar(Tv.Tv(I).Valconst)));
         end if;

      end loop;

      --  Put_Line("-------------------------------------------------");
      --  Put_Line("Contenido de la tabla de etiquetas:");
      --  for I in num_Etiq range 1..Te.Ne loop
      --     Put_Line("etiqueta: " & I'Img);
      --     Put_Line("     " & Etiqueta (Te, I));
      --  end loop;
      --  Put_Line("-------------------------------------------------");

      --end if;

   end imprimeix_Taules;


end semantica.declsc3a;
