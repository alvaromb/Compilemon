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


   procedure Genera_Assemblador is
   begin
      Put_Line("TODO: genera assemblador");
   exception
      when Error_Assemblador =>
         Comentari("Error assemblador");
   end Genera_Assemblador;


end Semantica.Assemblador;
