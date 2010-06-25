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
   procedure Gce_Inicialitza is
   	   Iv : Info_Var;
   begin

   	   Create(Fitxer_Asmbl, Out_File, Nom_Fitxer & ".s");
	   Obrir_Fitxer(Nom_Fitxer); --dc3a

	   --3 pasos a realizar (visto en apuntes):
	     --1º Guardar constantes (.section .data) 
         --2º Guardar Variables comunes (.section .bss)
		 --3º Instrucciones (.section .text)

	   --1º) Constantes
   	   Put_Line(Fitxer_Asmbl, ".section .data");
   	   for I in Num_Var range 1..Tv.Nv loop
          Iv := Consulta(Tv, I);
       	  if Iv.Const then
          	 if Iv.Tsub=Tsarr then
			    --Si es un String
             	--str_x : .asciz "xxx"
            	Put_Line(Fitxer_Asmbl, Tab & 
                	Cons_Nom(Tn, Iv.Id) & " : .asciz """ & --(En los apuntes pone .asciiz)
                	Cons_Nom(Tn, rang_tcar(Iv.Valconst)) & """");
          	 else
				--Si es un entero (en los apuntes pone .long)
             	--nombre_x : .int valor_v
             	Put_Line(Fitxer_Asmbl, Tab & Cons_Nom(Tn, Iv.Id) &
                	" : .int " & Iv.Valconst'Img);
          	 end if;
          end if;

   	   end loop;

	   --2º) Variables comunes
   	   New_Line(Fitxer_Asmbl);
  	   Put_Line(Fitxer_Asmbl, ".section .bss");
   	   Put_Line(Fitxer_Asmbl, Tab & ".common DISP, 100");

	   --3º) Instrucciones
   	   New_Line(Fitxer_Asmbl);
	   Put_Line(Fitxer_Asmbl, ".section .text");

   end Gce_Inicialitza;




   procedure Gce_Genera is
   	  Ic3a : c3a;
   	  Txt : String (1..10);
      Tmp : Integer;
      Ide : Num_Etiq;
      Ipr : Info_Proc;
   begin
      
	  while not Fi_Fitxer loop
	  	 --Para cada instruccion c3a la tratamos
		 Ipr := Info_Proc_Nul;
		 Ide := Etiq_Nul;
		 Llegir_Fitxer(Ic3a);
		 Txt := (others => ' ');
		 Tmp := 0;

		 case Ic3a.Instr is

			-- 1 Operand
		 	when Global => 
				if Ic3a.Camp1.Tc /= Etiq then
				   raise Error_Assemblador;
				end if;
				New_Line(Fitxer_Asmbl);
				Comentari("Global" & Ic3a.Camp1.Ide'Img);
				Ide := Ic3a.Camp1.Ide;
				Put_Line(Fitxer_Asmbl, ".global " & Etiqueta(Te, Ide));

		 	when Rtn => 

		 	when Call => 
				if Ic3a.Camp1.Tc /= Proc then
				   raise Error_Assemblador;
				end if;
				New_Line(Fitxer_Asmbl);
				Comentari("--Call" & Ic3a.Camp1.Idp'Img & " --" & Tab & "#");
				Ipr := Consulta(Tp, Ic3a.Camp1.Idp);
				Instr_1_Op("call", Etiqueta(Te, Ipr.Etiq));
				Instr_2_Op("addl", "$" & Ipr.Ocup_Param'Img, "%esp"); --Mirar el tema de si hay que *4


		 	when Preamb => 
				if Ic3a.Camp1.Tc /= Proc then
				   raise Error_Assemblador;
				end if;
				New_Line(Fitxer_Asmbl);
				Comentari("--Preambulo"& Ic3a.Campo1.Idp'Img & " --" & Tab & "#");
				Dpr:=Consulta (Tp, Ic3a.Campo1.Idp);
				Prof_Actual:=Dpr.Prof;
				Etiqueta (Etiqueta(Te, Dpr.Etiq));
				Instruc2 (
				   Inst => "movl",
				   Oper1 => "$DISP",
				   Oper2 => "%esi"
				   );
				Tmp:=4*Integer(Dpr.Prof);
				Instruc2 (
				   Inst => "addl",
				   Oper1 => "$" & Elimina_Espacio_Inicial (Tmp'Img),
				   Oper2 => "%esi"
				   );
				Instruc1 (
				   Inst => "pushl",
				   Oper1 => "(%esi)"
				   );
				Instruc1 (
				   Inst => "pushl",
				   Oper1 => "%ebp"
				   );
				Instruc2 (
				   Inst => "movl",
				   Oper1 => "%esp",
				   Oper2 => "%ebp"
				   );
				Instruc2 (
				   Inst => "movl",
				   Oper1 => "%ebp",
				   Oper2 => "(%esi)"
				   );
				Tmp:=4*Integer(Dpr.Prof);
				Instruc2 (
				   Inst => "subl",
				   Oper1 => "$" & Elimina_Espacio_Inicial
					  (Dpr.Ocup_Varl'Img),
				   Oper2 => "%esp"
				   );


		 	when Params => 
				New_Line(Fitxer_Asmbl);
				Comentari("Parametre Simple");
				Ldaddr(Ic3a.Camp1, "%eax");
				Instr_1_Op("pushl", "%eax");

		 	when Etiqueta => 

		 	when Branc_Inc => 
				if Ic3a.Camp1.Tc /= Etiq then
				   raise Error_Assemblador;
				end if;
				New_Line(Fitxer_Asmbl);
				Comentari("--Salto Incondicional" & Ic3a.Camp1.Ide'Img & " --" & Tab & "#");
				Instr_1_Op("jmp", Etiqueta(Te, Ic3a.Camp1.Ide));
			
			-- 2 Operands
			when Negacio => 
				--TITO
				New_Line(Fitxer_Asmbl);
				Comentari("--Negacio--"& Tab &"#");
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
				Comentari("--Not--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Instr_1_Op("not", "%eax");
				St("%eax", Ic3a.Camp1);


			when Copia => --a:=b
				New_Line(Fitxer_Asmbl);
		        Comentari("--Copia--"& Tab &"#");
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
				Instr_2_Op("addl", "%ebx", "%eax");
				St("%eax", Ic3a.Camp1);

			when Resta =>
				New_Line(Fitxer_Asmbl);
				Comentari("Resta");
				Ld(Ic3a.Camp2, "%eax");
				Ld(Ic3a.Camp3, "%ebx");
				Instr_2_Op("subl", "%ebx", "%eax");
				St("%eax", Ic3a.Camp1);

			when Producte =>
				New_Line(Fitxer_Asmbl);
				Comentari("--Producto--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Ld(Ic3a.Camp3, "%ebx");
				Instr_2_Op("imull", "%ebx", "%eax");
				St("%eax", Ic3a.Camp1);

			when Divisio =>
				New_Line(Fitxer_Asmbl);
				Comentari("--Divisio--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Instr_2_Op("movl", "%eax", "%edx");
				Instr_2_Op("sarl", "$31", "%edx"); --EL TITO pone eax
				Ld(Ic3a.Camp3, "%ebx");
				Instr_1_Op("idivl", "%ebx");
				St("%eax", Ic3a.Camp1);

			when Modul =>
				New_Line(Fitxer_Asmbl);
				Comentari("--Modul--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Instr_2_Op("movl", "%eax", "%edx");
				Instr_2_Op("sarl", "$31", "%edx"); --EL TITO pone eax
				Ld(Ic3a.Camp3, "%ebx");
				Instr_1_Op("idivl", "%ebx");
				St("%edx", Ic3a.Camp1);

			when Op_And =>
				New_Line(Fitxer_Asmbl);
				Comentari("--AND--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Ld(Ic3a.Camp3, "%ebx");
				Instr_2_Op("and", "%ebx", "%eax");
				St("%eax", Ic3a.Camp1);

			when Op_Or =>
				New_Line(Fitxer_Asmbl);
				Comentari("--OR--"& Tab &"#");
				Ld(Ic3a.Camp2, "%eax");
				Ld(Ic3a.Camp3, "%ebx");
				Instr_2_Op("or", "%ebx", "%eax");
				St("%eax", Ic3a.Camp1);

			when Consindex => 

			when Asigindex => 

			when Menor =>

			when Menorigual =>

			when Igual =>

			when Majorigual =>

			when Major =>

			when Diferent =>


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




   procedure Genera_Assemblador is
   begin
      Put_Line("TODO: genera assemblador");

	  if esem then 
   	  	raise Error_Assemblador;
	  end if;

	  Gce_Inicializa;
	  --Gce_Genera;
      --Gce_Finalitza;

   exception
      when Error_Assemblador =>
         Comentari("Error assemblador");
   end Genera_Assemblador;


end Semantica.Assemblador;
