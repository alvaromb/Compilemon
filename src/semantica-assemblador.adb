with Semantica.Declsc3a,
  Decls.Dtdesc,
  Decls.Dgenerals;

use Semantica.Declsc3a,
  Decls.Dtdesc,
  Decls.Dgenerals;

package body Semantica.Assemblador is

   -- Caracter TAB per els comentaris
   Tab : constant Character := Ascii.Ht;

   -- Variable per mantenir la profunditat
   Prof_Actual : Nprof;

   -- Procediments per inserir les instruccions
   -- de codi assemblador. Tenim per els tres
   -- tipus de instruccions C3@:
   --    Instruccio amb 0 operadors
   procedure Instr_0_Op
     (Instruccio : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio);
   end Instr_0_Op;

   --    Instruccio amb 1 operador
   procedure Instr_1_Op
     (Instruccio,
        Operand : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio &
                 Tab & Operand);
   end Instr_1_Op;

   --    Instruccio amb 2 operadors
   procedure Instr_2_Op
     (Instruccio,
        Operand1,
        Operand2 : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio &
                 Tab & Operand1 & Tab & ", " &
                 Operand2);
   end Instr_2_Op;

   -- Comentaris
   procedure Comentari
     (Comentari : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & " # " & Tab &
                 Comentari);
   end Comentari;

   -- Etiquetes
   procedure Etiqueta
     (Etiqueta : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Etiqueta & ": nop");
   end Etiqueta;

   -- LD a, %eax
   procedure Ld
     (Org : in Camp; --per ara usam camp
      Dst : in String) is

      Ivar : Info_Var;
      Prof_Var : Nprof;
      Vc : Valor;

      Dpa : Integer;
      Da : Despl renames Ivar.Desp;

   begin
      case Org.Tc is
         when Var =>
            Ivar := Consulta(Tv, Org.Idv);
            Prof_Var := Consulta(Tp, Ivar.Np).Prof;

            -- 'a' es una variable constant
            if Ivar.Const then
               Comentari("LD variable constant" & Org.Idv'Img &
                    ", " & Dst);
               Instr_2_Op("movl", "$" & Ivar.Valconst'Img, Dst);

            -- 'a' es local
            elsif Prof_Var = Prof_Actual then
               -- 'a' es parametre local
               if Ivar.Param then
                  Comentari("LD parametre local");
                  Instr_2_Op("movl", Da'Img & "(%ebp)", "%esi");
                  Instr_2_Op("movl", "(%esi)", Dst);
               -- 'a' es variable local
               else
                  Comentari("LD variable local");
                  Instr_2_Op("movl", Da'Img & "(%ebp)", Dst);
               end if;
            -- 'a' es global
            elsif Prof_Var < Prof_Actual then
               -- 'a' es parametre global
               if Ivar.Param then
                  Comentari("LD parametre global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  Dpa := 4*Integer(Prof_Var);
                  Instr_2_Op("movl", Dpa'Img & "(%esi)", "%esi");
                  Instr_2_Op("movl", Da'Img & "(%esi)", "%esi");
                  Instr_2_Op("movl", "(%esi)", Dst);
               -- 'a' es variable global
               else
                  Comentari("LD variable global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  Dpa := 4*Integer(Prof_Var);
                  Instr_2_Op("movl", Dpa'Img & "(%esi)", "%esi");
                  Instr_2_Op("movl", Da'Img & "(%esi)", Dst);
               end if;
            else
               raise Error_Assemblador;
            end if;

         when Const =>
            -- 'a' es una constant
            Comentari("LD es una constant" & Org.Idc'Img & ", " & Dst);
            Vc := Consulta(Tv, Org.Idc).Valconst;
            Instr_2_Op("movl", "$" & Vc'Img, Dst);
         when others =>
            raise Error_Assemblador;
      end case;
   end Ld;


   -- ST %eax, a
   procedure St
     (Org : in String;
      Dst : in Camp) is

      Prof_Var : Nprof;
      Idst : Info_Var;

      Dpa : Integer;
      Da : Despl renames Idst.Desp;

   begin
      if Dst.Tc /= Var then
         raise Error_Assemblador;
      end if;

      Idst := Consulta(Tv, Dst.Idv);
      Prof_Var := Consulta(Tp, Idst.Np).Prof;
      -- 'a' es local
      if Prof_Var = Prof_Actual then
         -- 'a' es una variable local
         if not Idst.Param then
            Comentari("ST a una variable local");
            Instr_2_Op("movl", Org, Da'Img & "(%ebp)");
         -- 'a' es un parametre local
         else
            Comentari("ST a un parametre local");
            Instr_2_Op("movl", Da'Img & "(%ebp)", "%edi");
            Instr_2_Op("movl", Org, "(%edi)");
         end if;
      -- 'a' es global
      elsif Prof_Var < Prof_Actual then
         -- 'a' es una variable global
         if not Idst.Param then
            Comentari("ST a una variable global");
            Instr_2_Op("movl", "$DISP", "%esi");
            Dpa := 4*Integer(Prof_Var);
            Instr_2_Op("addl", "$" & Dpa'Img, "%esi");
            Instr_2_Op("movl", "(%esi)", "%edi");
            Instr_2_Op("movl", Org, Da'Img & "(%edi)");
         -- 'a' es un parametre global
         else
            Comentari("ST a un parametre global");
            Instr_2_Op("movl", "$DISP", "%esi");
            Dpa := 4*Integer(Prof_Var);
            Instr_2_Op("addl", "$" & Dpa'Img, "%esi");
            Instr_2_Op("movl", "(%esi)", "%esi");
            Instr_2_Op("movl", Da'Img & "(%esi)", "%edi");
            Instr_2_Op("movl", Org, "(%edi)");
         end if;
      else
         raise Error_Assemblador;
      end if;
   end St;


   -- LDA a, %eax
   procedure Ldaddr
     (Org : in Camp;
      Dst : in String) is

      Ivar : Info_Var;
      Prof_Var : Nprof;

      Dpa : Integer;
      Da : Despl renames Ivar.Desp;

   begin
      Ivar := Consulta(Tv, Org.Idv);
      case Org.Tc is
         -- 'a' es constant
         when Const =>
            Comentari("LDADDR amb a constant" & Org.Idc'Img & ", " & Dst);
            Instr_2_Op("movl", "$" & Cons_Nom(Tn, Ivar.Id), Dst);

         -- 'a' es una variable
         when Var =>
            Prof_Var := Consulta(Tp, Ivar.Np).Prof;
            -- 'a' es una variable constant
            if Ivar.Const then
               Comentari("LDADDR amb var. constant" & Org.Idc'Img &
                           ", " & Dst);
               Instr_2_Op("movl", "$" & Cons_Nom(Tn, Ivar.Id), Dst);

            -- 'a' es local
            elsif Prof_Var = Prof_Actual then
               -- 'a' es una variable local
               if not Ivar.Param then
                  Comentari("LDADDR amb variable local");
                  Instr_2_Op("leal", Da'Img & "(%ebp)", Dst);
               -- 'a' es un parametre local
               else
                  Comentari("LDADDR amb parametre local");
                  Instr_2_Op("movl", Da'Img & "(%ebp)", Dst);
               end if;

            -- 'a' es global
            elsif Prof_Var < Prof_Actual then
               -- 'a' es una variable global
               if not Ivar.Param then
                  Comentari("LDADDR amb variable global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  Dpa := 4*Integer(Prof_Var);
                  Instr_2_Op("movl", Dpa'Img & "(%esi)", "%esi");
                  Instr_2_Op("leal", Da'Img & "(%esi)", Dst);
               -- 'a' es un parametre global
               else
                  Comentari("LDADDR amb parametre global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  Dpa := 4*Integer(Prof_Var);
                  Instr_2_Op("movl", Dpa'Img & "(%esi)", "%esi");
                  Instr_2_Op("movl", Da'Img & "(%esi)", Dst);
               end if;
            else
               raise Error_Assemblador;
            end if;

         when others =>
            raise Error_Assemblador;
      end case;
   end Ldaddr;


   --Mirar si cambiar el nombre (Inicialitza) por si no le gusta al Tito
   procedure Gce_Inicialitza
     (Nom_Fitxer : in String) is
      Iv : Info_Var;
   begin
      Create(Fitxer_Asmbl, Out_File, Nom_Fitxer & ".s");
      Obrir_Fitxer(Nom_Fitxer); --dc3a


      --3 pasos a realizar (visto en apuntes):
      --1º Guardar constantes (.section .data)
      --2º Guardar Variables comunes (.section .bss)
      --3º Instrucciones (.section .text)

      --1º) Constants
      Put_Line(Fitxer_Asmbl, ".section .data");
      for I in Num_Var range 1..Tv.Nv loop
         Iv := Consulta(Tv, I);
         if Iv.Const then
            if Iv.Tsub = Tsarr then
               --Si es un String
               --s1 : .asciiz "El nombde de a's es"
               Put_Line(Fitxer_Asmbl, Tab &
                          Cons_Nom(Tn, Iv.Id) & " : .asciz """ &
                          Cons_Str(Tn, rang_tcar(Iv.Valconst)) & """");
            elsif Iv.Tsub = Tsent then
               --Si es un numeric
               --c3 : .long 3
               Put_Line(Fitxer_Asmbl, Tab &
                          Cons_Nom(Tn, Iv.Id) & " : .long " &
                          Iv.Valconst'Img);
            else
               --Si es un caracter
               --cc2 : .ascii "A"
               Put_Line(Fitxer_Asmbl, Tab &
                          Cons_Nom(Tn, Iv.Id) & " : .ascii """ &
                          Iv.Valconst'Img & """");
            end if;
         end if;
      end loop;

      --2º) Variables comunes
      New_Line(Fitxer_Asmbl);
      Put_Line(Fitxer_Asmbl, ".section .bss");
      Put_Line(Fitxer_Asmbl, Tab & ".comm DISP, 100");

      --3º) Instrucciones
      New_Line(Fitxer_Asmbl);
      Put_Line(Fitxer_Asmbl, ".section .text");
      Put_Line(Fitxer_Asmbl, ".global main");
      Put_Line(Fitxer_Asmbl, "main:");
      --jmp a l'etiqueta del programa principal
      --etiqueta del programa principal

   end Gce_Inicialitza;


   procedure Gce_Genera is

      Ic3a : c3a;
      Txt : String (1..10);
      Dpn : Integer;
      Ide : Num_Etiq;
      Ipr : Info_Proc;

   begin
      while not Fi_Fitxer loop
         --Para cada instruccion c3a la tratamos
         Ipr := Info_Proc_Nul;
         Ide := Etiq_Nul;
         Llegir_Fitxer(Ic3a);
         Txt := (others => ' ');
         Dpn := 0;

         case Ic3a.Instr is
            -- 1 Operand
            when Global =>
               if Ic3a.Camp1.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Global " & Ic3a.Camp1.Ide'Img);
               Ide := Ic3a.Camp1.Ide;
               --Put_Line(Fitxer_Asmbl, ".globl " & Etiqueta(Ide));
               Put_Line(Fitxer_Asmbl, ".globl _etq_" & Ide'Img);

            when Rtn =>
               if Ic3a.Camp1.Tc /= Proc then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Return " & Ic3a.Camp1.Idp'Img);
               Np := Np - 1;
               Ipr := Consulta(Tp, Ic3a.Camp1.Idp);
               Instr_2_Op("movl", "%ebp", "%esp");
               Instr_1_Op("popl", "%ebp");
               Instr_2_Op("movl", "$DISP", "%edi");
               Dpn := 4*Integer(Ipr.Prof);
               Instr_1_Op("popl", Dpn'Img & "(%edi)");
               Instr_0_Op("ret");

            when Call =>
               if Ic3a.Camp1.Tc /= Proc then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Call " & Ic3a.Camp1.Idp'Img);
               Ipr := Consulta(Tp, Ic3a.Camp1.Idp);
               Instr_1_Op("call", Etiqueta(Ipr));
               -- Mirar el tema de si hay que *4
               Instr_2_Op("addl", "$" & Ipr.Ocup_Param'Img, "%esp");

            when Preamb =>
               if Ic3a.Camp1.Tc /= Proc then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Preambul "& Ic3a.Camp1.Idp'Img);
               Nproc := Nproc + 1;
               Ipr := Consulta(Tp, Ic3a.Camp1.Idp);
               Prof_Actual := Ipr.Prof;
               Etiqueta(Etiqueta(Ipr));
               Instr_2_Op("movl", "$DISP", "%esi");
               Dpn := 4*Integer(Ipr.Prof);
               Instr_1_Op("pushl", Dpn'Img & "(%esi)");
               Instr_1_Op("pushl", "%ebp");
               Instr_2_Op("movl", "%esp", "%ebp");
               Instr_2_Op("movl", "%ebp", Dpn'Img & "(%esi)");
               Instr_2_Op("subl", "$" & Ipr.Ocup_Var'Img, "%esp");

            when Params =>
               New_Line(Fitxer_Asmbl);
               Comentari("Parametre Simple");
               Ldaddr(Ic3a.Camp1, "%eax");
               Instr_1_Op("pushl", "%eax");

            when Etiqueta =>
               if Ic3a.Camp1.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Etiqueta " & Ic3a.Camp1.Ide'Img);
               Etiqueta("_etq_" & Ic3a.Camp1.Ide'Img);

            when Branc_Inc =>
               if Ic3a.Camp1.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               New_Line(Fitxer_Asmbl);
               Comentari("Brancament Incondicional " & Ic3a.Camp1.Ide'Img);
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp1.Ide'Img);

            -- 2 Operands
            when Negacio =>
               New_Line(Fitxer_Asmbl);
               Comentari("Negacio");
               Instr_2_Op("xorl", "%eax", "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("subl", "%ebx", "%eax");
               St("%eax", Ic3a.Camp1);

               --JUANMA
               --New_Line(Fitxer_Asmbl);
               --Comentari("--Negacio--"& Tab &"#");
               --Ld(Ic3a.Camp2, "%eax");
               --Instr_2_Op("xorl", "%ebx", "%eax");
               --Instr_2_Op("subl", "%eax", "%ebx");
               --St("%ebx", Ic3a.Camp1);

            when Op_Not =>
               New_Line(Fitxer_Asmbl);
               Comentari("Not");
               Ld(Ic3a.Camp2, "%eax");
               --notl per not
               Instr_1_Op("notl", "%eax");
               St("%eax", Ic3a.Camp1);

            when Copia => --a:=b
               New_Line(Fitxer_Asmbl);
               Comentari("Copia");
               Ld(Ic3a.Camp2, "%eax");
               St("%eax", Ic3a.Camp1);

            when Paramc =>
               New_Line(Fitxer_Asmbl);
               Comentari("Parametre Compost");
               Ldaddr(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("addl", "%ebx", "%eax");
               Instr_1_Op("pushl", "%eax");

            -- 3 Operands
            when Suma =>
               New_Line(Fitxer_Asmbl);
               Comentari("Suma");
               Ld(Ic3a.Camp2, "%eax");
               Ld(Ic3a.Camp3, "%ebx");
               Instr_2_Op("addl", "%eax", "%ebx");
               St("%ebx", Ic3a.Camp1);

            when Resta =>
               New_Line(Fitxer_Asmbl);
               Comentari("Resta");
               Ld(Ic3a.Camp2, "%eax");
               Ld(Ic3a.Camp3, "%ebx");
               Instr_2_Op("subl", "%ebx", "%eax");
               St("%eax", Ic3a.Camp1);

            when Producte =>
               New_Line(Fitxer_Asmbl);
               Comentari("Producte");
               Ld(Ic3a.Camp2, "%eax");
               Ld(Ic3a.Camp3, "%ebx");
               Instr_2_Op("imull", "%eax", "%ebx");
               St("%ebx", Ic3a.Camp1);

            when Divisio =>
               New_Line(Fitxer_Asmbl);
               Comentari("Divisio");
               Ld(Ic3a.Camp2, "%eax");
               Instr_2_Op("movl", "%eax", "%edx");
               Instr_2_Op("sarl", "$31", "%edx"); --EL TITO pone eax
               Ld(Ic3a.Camp3, "%ebx");
               Instr_1_Op("idivl", "%ebx");
               St("%eax", Ic3a.Camp1);

            when Modul =>
               New_Line(Fitxer_Asmbl);
               Comentari("Modul");
               Ld(Ic3a.Camp2, "%eax");
               Instr_2_Op("movl", "%eax", "%edx");
               Instr_2_Op("sarl", "$31", "%edx"); --EL TITO pone eax
               Ld(Ic3a.Camp3, "%ebx");
               Instr_1_Op("idivl", "%ebx");
               St("%edx", Ic3a.Camp1);

            when Op_And =>
               New_Line(Fitxer_Asmbl);
               Comentari("AND");
               Ld(Ic3a.Camp2, "%eax");
               Ld(Ic3a.Camp3, "%ebx");
               -- andl per and
               Instr_2_Op("andl", "%ebx", "%eax");
               St("%eax", Ic3a.Camp1);

            when Op_Or =>
               New_Line(Fitxer_Asmbl);
               Comentari("OR");
               Ld(Ic3a.Camp2, "%eax");
               Ld(Ic3a.Camp3, "%ebx");
               Instr_2_Op("orl", "%ebx", "%eax");
               St("%eax", Ic3a.Camp1);

            when Consindex =>
               New_Line(Fitxer_Asmbl);
               Comentari("Consulta index");
               Ldaddr(Ic3a.Camp2, "%esi");
               Ld(Ic3a.Camp3, "%eax");
               Instr_2_Op("addl", "%eax", "%esi");
               Instr_2_Op("movl", "(%esi)", "%eax");
               St("%eax", Ic3a.Camp1);

            when Asigindex =>
               New_Line(Fitxer_Asmbl);
               Comentari("Assignacio d'index");
               Ldaddr(Ic3a.Camp1, "%edi");
               Ld(Ic3a.Camp2, "%eax");
               Instr_2_Op("addl", "%eax", "%edi");
               Ld(Ic3a.Camp3, "%eax");
               Instr_2_Op("movl", "%eax","(%edi)");

            when Menor =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Menor");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("jge", "_etiq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when Menorigual =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Menor o Igual");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("jg", "_etq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when Igual =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Igual");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("jne", "_etq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when Majorigual =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Major o Igual");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("jl", "_etq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when Major =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Major");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("jle", "_etq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when Diferent =>
               if Ic3a.Camp3.Tc /= Etiq then
                  raise Error_Assemblador;
               end if;
               Comentari("IF Diferent");
               Ide := Nova_Etiq;
               Ld(Ic3a.Camp1, "%eax");
               Ld(Ic3a.Camp2, "%ebx");
               Instr_2_Op("cmpl", "%ebx", "%eax");
               Instr_1_Op("je", "_etq_" & Ide'Img);
               --Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp3.Ide));
               Instr_1_Op("jmp", "_etq_" & Ic3a.Camp3.Ide'Img);
               Etiqueta("_etq_" & Ide'Img);

            when others =>
               raise Error_Assemblador;
         end case;
      end loop;

   end Gce_Genera;


   procedure Gce_Finalitza is
   begin
      Tanca_Fitxer; --dc3a
      Close(Fitxer_Asmbl);
   exception
      when others=>
         null; --Mirar si poner alguna excepcion
   end Gce_Finalitza;


   procedure Genera_Assemblador
     (Nom_Fitxer : in String) is
   begin
      if Esem then
         raise Error_Assemblador;
      end if;

      Gce_Inicialitza(Nom_Fitxer);
      Gce_Genera;
      Gce_Finalitza;

   exception
      when Error_Assemblador =>
         Comentari("Error assemblador");
   end Genera_Assemblador;


end Semantica.Assemblador;
