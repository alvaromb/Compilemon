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
      Vconst : Valor;
      Prof_Var : Nprof;
      W : Integer;
      Vc : Valor;

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
                  Instr_2_Op("movl", Ivar.Desp'Img & "(%ebp)", "%esi");
                  Instr_2_Op("movl", "(%esi)", Dst);
               -- 'a' es variable local
               else
                  Comentari("LD variable local");
                  Instr_2_Op("movl", Ivar.Desp'Img & "(%ebp)", Dst);
               end if;
            -- 'a' es global
            elsif Prof_Var < Prof_Actual then
               -- 'a' es parametre global
               if Ivar.Param then
                  Comentari("LD parametre global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  W := 4*Integer(Prof_Var);
                  Instr_2_Op("addl", "$" & W'Img, "%esi");
                  Instr_2_Op("movl", Ivar.Desp'Img & "(%esi)", "%esi");
                  Instr_2_Op("movl", "(%esi)", Dst);
               -- 'a' es variable global
               else
                  Comentari("LD variable global");
                  Instr_2_Op("movl", "$DISP", "%esi");
                  W := 4*Integer(Prof_Var);
                  Instr_2_Op("addl", "$" & W'Img, "%esi");
                  Instr_2_Op("movl", Ivar.Desp'Img & "(%esi)", Dst);
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


   procedure Genera_Assemblador is
   begin
      Put_Line("TODO: genera assemblador");
   exception
      when Error_Assemblador =>
         Comentari("Error assemblador");
   end Genera_Assemblador;


end Semantica.Assemblador;
