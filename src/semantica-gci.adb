
package body Semantica.Gci is

   package Pila_Proc is new Pilas (num_Proc);
   use Pila_Proc;
   Pproc : Pila_proc.Pila;

   package Pila_Param is new Pilas (T_Param);
   use Pila_Param;
   Pparam : Pila_Param.Pila;

   procedure Genera
     (Instr : in tInstruccio;
      C1    : in Camp := Camp_Nul;
      C2    : in Camp := Camp_Nul;
      C3    : in Camp := Camp_Nul) is
   begin
      Escriure_Fitxer((Instr, C1, C2, C3));
   end Genera;


   procedure Gci_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Proc : Id_Nom renames A.Fid5.Id12;

      eip : num_etiq;
      C1 : camp;

      Ipr : Info_Proc;
      dproc : Descrip;

      Idprinvocador,
      Idprinvocat : Num_Proc;

   begin
      Put_line("CT_Decprocediment");
      Gci_Encap(Encap, Id_Proc);

      if Decls.Tipus = Declaracions then
         gci_Declaracions(Decls); --pendent, arrays, vars i constants
      end if;

      --Necesario? PRMB
      eip := Nova_Etiq;
      C1 := (Tc => Etiq, Ide => eip);
      Genera(Etiqueta, C1);

      dproc:=Cons(Ts, Id_Proc); -------------marccuuuuuuuuuuuuuuuuuuuuuuuuuuuusss
      C1:=(
           Tc => Proc,
           Idp => dproc.np);

      Ipr := Consulta(Tp, dproc.np);
      Genera(Preamb, C1);

      --
      gci_Bloc(Bloc);
      --

      --RTN
      Cim(Pproc, Idprinvocat);
      C1:=(
           Tc => Proc,
           Idp => Idprinvocat
          );
      Genera(Rtn, C1);

      Desempilar(Pproc);
      Cim(Pproc, Idprinvocador);

      if Idprinvocador = Proc_Nul then
         C1:=(
              Tc => Etiq,
              Ide => Tp.Tp(Idprinvocat).Etiq
             );
         Genera(Global, C1);
      end if;

   end gci_Decprocediment;


   procedure gci_Programa
     (A : in Pnode) is
   begin
      --tEntrabloc(Ts);
      Tv.nv := nv;
      gci_Decprocediment(A);

      --Surtbloc(Ts);
      Tanca_Fitxer;
   end gci_Programa;


   procedure Gci_Encap
     (A : in Pnode;
      I : in Id_Nom) is
      Dproc : Descrip;
   begin
      Dproc := Cons(TTs(Ts), I); --marcuuuuuuuuuuuuuuuuuuuuuuussssssssssssssssssssss
      Empilar(Pproc, dproc.Np);
   end gci_Encap;


   procedure gci_Declaracions
     (A : in Pnode) is

      Decl : Pnode renames A.Fd1;
      Decls : Pnode renames A.Fe1;
      Tnode : Tipusnode;
      Idrec : Id_Nom;
      Ocup  : Despl;

   begin
      if Decls.Tipus = Declaracions then
         Gci_Declaracions(Decls);
      end if;

      case Decl.Tipus is
         when Dvariable   =>
            gci_Decvar(Decl);
         when Dconstant   =>
            --gci_Decconst(Decl);
			null; -- No utilitzam perque ho farem mes tard
         when Dcoleccio   =>
            null;
         when Dregistre | Dencapregistre | Firecord =>
            -- Ocup := 0;
            -- Ct_Decregistre(Decl, Idrec,Ocup);
            null;
         when Dsubrang    =>
            null;
         when Procediment =>
            gci_Decprocediment(Decl);
         when others =>
            null;
      end case;

   end gci_Declaracions;


   procedure gci_Decvar
     (A : in Pnode) is

      Dvariable : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      Ivar : Info_Var := Info_Var_Nul;
      desc,desctipus : Descrip;
      idproc : num_proc;

   begin
      gci_Declsvar(Dvariable);

      cim(pproc, idproc);
      desc:= cons(Tts(idproc),Id);
      desctipus := cons(Tts(idproc),desc.tr);

      Ivar := (Id,
               idproc,
               Desctipus.Dt.Ocup,
               0,
               Desctipus.Dt.Tt,
               False,
               False,
               0);
      Modif_Descripcio(Tv, Desc.Nv, Ivar);

   end gci_Decvar;

   procedure gci_Declsvar
     (A : in Pnode) is

      Tnode : Tipusnode renames A.Tipus;
      Ivar : Info_Var := Info_Var_Nul;
      desc,desctipus : Descrip;
      idproc : num_proc;

   begin

      if Tnode = Declmultvar then
         gci_Declsvar(A.Fd1);

         cim(pproc, idproc);
         desc:= cons(Tts(idproc),A.Fe1.Id12);

         desctipus := cons(Tts(idproc),desc.tr);

         Ivar := (A.Fe1.Id12,
                  idproc,
                  Desctipus.Dt.ocup,
                  0,
                  Desctipus.Dt.tt,
                  False,
                  False,
                  0);

         modif_descripcio(Tv, Desc.Nv, Ivar);

      end if;

   end gci_Declsvar;

   procedure gci_Decconst
     (A : in Pnode) is

      Id : Id_Nom renames A.Fe2.Id12;
      Val : Pnode renames A.Fd2;
      Iconst : Info_Var := Info_Var_Nul;
      desc, desctipus : Descrip;
      idproc : num_proc;

   begin

      cim(pproc, idproc);
      desc:= cons(Tts(idproc),A.Fd1.Id12);

      desctipus := cons(Tts(idproc),desc.tr);

      Iconst := (Id,
                 idproc,
                 Desctipus.Dt.ocup,
                 0,
                 Desctipus.Dt.tt,
                 False,
                 True,--no n'estic 100% segur
                 Val.Val);
      modif_descripcio(tv, Desc.Nv, Iconst);

   end gci_Decconst;


   procedure gci_Deccol
     (A : in Pnode) is

      Darray : Descrip;
      Fesq : Pnode renames A.Fe1;
      Idarray : Id_Nom;
      base : valor := 0;
	  idproc : num_proc;
	  T1 : num_var;

   begin  --p_dcoleccio s_parentesitancat pc_of id

      gci_Pcoleccio(Fesq,base,Idarray);
	  cim(pproc, idproc);
      Darray := cons(Tts(idproc),Idarray);

      
	  Novaconst(Tv, base, Tsent, idproc, T1);

      Darray.Dt.Base := T1;
      actualitza(Tts(idproc), Idarray, Darray);

   end gci_Deccol;


   procedure gci_Pcoleccio
     (A : in Pnode;
      base: in out Valor;
      Idarray : out Id_nom) is

      Fesq : Pnode renames A.Fe1;
      Id   : Id_Nom renames A.Fd1.Id12;
      Ncomp : Valor;
      Dtcamp : Descrip;

   begin
      if (A.Tipus = Pcoleccio) then--p_dcoleccio s_coma id

         gci_Pcoleccio(Fesq, base, Idarray);

         Dtcamp := cons(Tts(idproc),Id);
         ncomp :=  dtcamp.dt.lsup - dtcamp.dt.linf + 1;
         base := (base * ncomp) + dtcamp.dt.linf;

      elsif (A.Tipus = Pdimcoleccio) then --pc_type id pc_is pc_array s_parentesiobert id

         Dtcamp := cons(Tts(idproc),Id);
         Idarray := Fesq.Id12;
         base := dtcamp.dt.linf;

      end if;

   end Gci_Pcoleccio;


   procedure gci_Bloc
     (A : in Pnode) is

      D : Descrip;
      T : Tipussubjacent;
      Idbase : Num_Proc;
      Idtipus : Id_Nom;

      Tsexp : Tipussubjacent;
      Idexp : Id_Nom;
      Tsvar : Tipussubjacent;
      Idvar : Id_Nom;

      Idres,
      Iddesp,
      Idr,
      Idd: num_var;

   begin
      case (A.Tipus) is
         when Bloc =>
            gci_Bloc(A.Fe1);
            gci_Bloc(A.Fd1);
         when Repeticio =>
            gci_Srep(A);
         when Identificador => --crida a procediment sense parametres
            Put_Line("CT_Bloc : IDENTIFICADOR");
            gci_identificador(A, Idres, Iddesp, Idtipus);
         when Fireferencia =>
            gci_Referencia_Proc(A, Idbase);
         when condicionalS =>
            gci_Sconds(A);
         when condicionalC =>
            gci_Scondc(A);
         when Assignacio =>
            gci_Referencia_Var(A.Fe1, Idr, Idd, Idtipus);
            gci_Expressio(A.Fd1, Idres, Iddesp);
            gci_Assignacio(Idr, Idd, Idres, Iddesp);
         when others => null;
      end case;
   end gci_Bloc;


   procedure Gci_Assignacio
     (Idref, Iddref, Idrexp, Iddexp: in num_var) is
      C1,
      C2,
      C3,
      C4,
      C5 : Camp;
      T : Num_Var;
      Idproc : Num_Proc;
   begin

      C1:=(
           Tc => Var,
           Idv => Idref
          );
      C2:=(
           Tc => Var,
           Idv => Iddref
          );
      C3:=(
           Tc => Var,
           Idv => Idrexp
          );
      C4:=(
           Tc => Var,
           Idv => Iddexp
          );


      cim(pproc, idproc);
      Novavar(Tv, idproc, T);
      C5:=(
           Tc => Var,
           Idv => T
          );


      if Iddref = Var_Nul then
         if Iddexp = Var_Nul then
            Genera(Copia, C1, C3);
         else
            Genera(Consindex, C1, C3, C4);
         end if;
      else
         if Iddexp = Var_Nul then
            Genera(Asigindex, C1, C2, C3);
         else
            Genera(Consindex, C5, C3, C4);
            Genera(Asigindex, C1, C2, C5);
         end if;
      end if;

   end gci_Assignacio;


   --Procediments
   procedure gci_Referencia_Proc --InComplet
     (A : in Pnode;
      Idproc : out num_proc) is

      Tipus : Tipusnode renames A.Tipus;
      dproc : Descrip;

      Prm : T_Param;
      c1, c2 : camp;

   begin
      case Tipus is
         when Identificador => --R -> id

            dproc := cons(ts, A.Fid5.Id12);--marcuuuuuuuuuuuuuuuussssssssssssssssssssss
            Idproc := dproc.np;

         when Fireferencia => -- R -> pri)
            gci_Ref_Pri(A.F6, Idproc);

            while not es_buida(pparam) loop
               cim(pparam, prm);
               Desempilar(Pparam); --Generar desplazamiento
               -- Camviar infovar : argument a TRUE, calcular despl
               C1:=(
                    Tc => Var,
                    Idv => Prm.Base
                   );

               C2:=(
                    Tc => Var,
                    Idv => Prm.Despl
                   );

               if Prm.Despl=Var_Nul then
                  Genera(Params, C1);
               else
                  Genera(Paramc, C1, C2);
               end if;

            end loop;

            c1:=(
                 Tc => Proc,
                 Idp => Idproc
                );
            genera(Call, c1);

         when others =>
            Put_Line("ERROR (DEBUG) gci-referencia: node "&
                       "no reconegut");

      end case;

   end gci_Referencia_Proc;


   procedure gci_Ref_Pri
     (A : in Pnode;
      Idproc : out num_proc) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      Idres, Iddesp : num_var;
      prm:  T_Param;
   begin
      case Tipus is
         when Pri => --pri -> pri,E
            Put_Line("CT-ref_pri: pri");
            gci_Ref_Pri(Fesq,IdProc);
            gci_Expressio(Fdret, Idres, Iddesp);

            prm.base := Idres;
            prm.despl := Iddesp;
            Pila_Buida(pparam);
            empilar(pparam, prm);

         when Encappri => -- pri -> R(E
            Put_Line("CT-ref_pri: encappri");
            gci_Referencia_Proc(Fesq, Idproc);
            gci_Expressio(Fdret, Idres, Iddesp);
            prm.base := Idres;
            prm.despl := Iddesp;
            empilar(pparam, prm);
         when others =>
            Put_Line("ERROR (DEBUG) gci-ref_pri: tipus no "&
                       "reconegut");
      end case;
   end gci_Ref_Pri;


   procedure gci_Identificador -- correcte
     (A : in Pnode;
      Idres, Iddesp: out num_var;
      Idtipus : out Id_Nom) is

      Id : Id_Nom renames A.Id12;
      D : Descrip;
      Desc : Tdescrip renames D.Td;

      Carg : Cursor_Arg;

      idv : num_var := var_nul;
      idproc : num_proc := proc_nul;
      c1, c2: camp;

   begin
	  cim(pproc, idproc);
      D := Cons(Tts(idproc), Id);

      case Desc is
         when Dvar => -- R -> id
            Idres := d.nv;
            Iddesp := var_nul;
            Idtipus := d.tr;

         when Dconst =>
           
            ------Novavar(Tv, idproc, Idv);
			--modifica_var de id
			--Crear var temporal
			--Generar copia de var de id a var temporal

            C1:=(
                 Tc => Var,
                 Idv => Idv
                );

            C2:=(
                 Tc => Const,
                 Idc => 69    ---AACHTUNNG!!!!!! ALARM; ERROR; CORREGIR!
                );

            genera(copia, c1, c2);

            Idres:= idv;
            Iddesp:= var_nul;
            Idtipus:= d.tc;

         when Dproc =>

            D:=cons(Tts(idproc), id);
            c1:=(
                 Tc => Proc,
                 Idp => D.Np
                );
            genera(Call, c1);

         when others =>
            null;

      end case;

      Put_line("gci_id: Tipus: "&Idtipus'img);

   end gci_Identificador;


   procedure gci_Constant
     (A : in Pnode;
      Idres : out Num_var) is

      Tatr : Tipus_Atribut renames A.Tconst;
      idproc : num_proc;
      T : Tipussubjacent;
   begin
      Put_line("CT_CONSTANT");
      cim(pproc, idproc);

      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when others => null;
      end case;

      Novaconst(Tv, A.Val, T, idproc, Idres);

   end gci_Constant;


   procedure gci_Expressio
     (A : in Pnode;
      Idr, Idd: out num_var) is

      Tipus : Tipusnode renames A.Tipus;
      Idtipus : Id_Nom;

   begin
      Idd := var_nul;

      Put_line("CT_EXP: "&Tipus'img );
      case Tipus is
         when Expressio =>
            gci_Expressioc(A, Idr, Idd);
         when ExpressioUnaria =>
            gci_Expressiou(A, Idr, Idd);
         when Identificador =>
            gci_Identificador(A, Idr, Idd, Idtipus); --Idtipus??
         when Const =>
            gci_Constant(A, Idr);

         when Fireferencia | Referencia =>
            gci_Referencia_Var(A, Idr, Idd, Idtipus);
         when others =>
            Put_Line("ERROR (DEBUG) gci-exp: tipus expressio no "&
                       "trobat :S "&Tipus'Img);
      end case;

   end gci_Expressio;


   procedure gci_Expressioc --comprovar parametres
     (A : in Pnode;
      Idres,Idresdesp: out num_var) is

      Fesq : Pnode renames A.Fe3;
      Fdret : Pnode renames A.Fd3;
      Op : Operacio renames A.Op3;

      Idesq,
      Iddret,
      IddespE,
      IddespD : num_var;

   begin
      Put_line("gci_EXPRESSIOC");
      --Analitzam l'operand esquerra
      gci_Expressio(Fesq, Idesq,IddespE);
      --Analitzam l'operand dret
      gci_Expressio(Fdret, Iddret,IddespD);
      -- Comparam els tipus
      case Op is

         when Unio | Interseccio =>
            Gci_Exp_Logica(Idesq, Iddret, IddespE,
                           IddespD, Idres, Idresdesp, Op);

         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            gci_Exp_Relacional(Idesq, Iddret, IddespE,
                               IddespD, Idres, Idresdesp, Op);

         when Suma | Resta | Mult | Div | Modul =>
            gci_Exp_Aritmetica(Idesq, Iddret, IddespE,
                               IddespD, Idres, Idresdesp, Op);

         when others =>
            null;
      end case;

   end gci_Expressioc;



   procedure gci_Exp_Relacional --manca acabar d'entendre el final
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp :   out num_var;
      Op : in Operacio) is

      T1,
      T2,
      T3 : num_Var := Var_Nul;

      Emig,
      Efi : num_Etiq;

      C1,
      C2,
      C3 : Camp;

      idproc : num_proc := proc_nul;

   begin

      if IddespE = Var_Nul then
         T1:= IdResE;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);

         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => IdResE
             );
         C3:=(
              Tc => Var,
              Idv => IddespE
             );
         Genera(Consindex,C1,C2,C3);

      end if;

      if IddespD = Var_Nul then
         T2 := IdResD;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T2);
         C1:=(
              Tc  => Var,
              Idv => T2
             );
         C2:=(
              Tc  => Var,
              Idv => IdResD
             );
         C3:=(
              Tc  => Var,
              Idv => IddespD);
         Genera(Consindex,C1,C2,C3);
      end if;

      Emig:=Nova_Etiq;
      Efi:=Nova_Etiq;

      C1:=(
           Tc => Var,
           Idv => T1
          );
      C2:=(
           Tc => Var,
           Idv => T2
          );
      C3:=( --Al loro, puesto de nuestra manera. C3 va la etiqueta
            Tc => Etiq,
            Ide => Emig
          );

      case Op is
         when Menor => Genera(Menor, C1, C2, C3);
         when Menorig => Genera(Menorigual, C1, C2, C3);
         when Igual => Genera(Igual,C1,C2,C3);
         when Majorig => Genera(Majorigual, C1, C2, C3);
         when Major => Genera(Major, C1, C2, C3);
         when Distint => Genera(Diferent, C1, C2, C3);
         when others => null;
      end case;

      cim(pproc, idproc);
      Novavar(Tv, Idproc, T3);

      C1:=(
           Tc => Var,
           Idv => T3
          );
      C2:=(
           Tc => Const,
           Idc => Zero
          );

      Genera(Copia, C1, C2);

      C3:=(
           Tc => Etiq,
           Ide => Efi
          );
      Genera(Branc_Inc, C3);

      C3.Ide:=Emig;
      Genera(Etiqueta, C3);

      C2.Idc:=MenysU;
      Genera(Copia, C1, C2);

      C3.Ide:=Efi;
      Genera(Etiqueta, C3);

      IdResultExp:=T3;
      IddespExp:=Var_Nul;


   end gci_Exp_Relacional;



   procedure gci_Exp_Logica
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp :   out num_var;
      Op : in Operacio) is

      T1,
      T2,
      T3 : num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      idproc : num_proc := proc_nul;

   begin

      if IddespE = Var_Nul then
         T1:= IdResE;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);

         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => IdResE
             );
         C3:=(
              Tc => Var,
              Idv => IddespE
             );
         Genera(Consindex,C1,C2,C3);

      end if;

      if IddespD = Var_Nul then
         T2 := IdResD;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T2);
         C1:=(
              Tc  => Var,
              Idv => T2
             );
         C2:=(
              Tc  => Var,
              Idv => IdResD
             );
         C3:=(
              Tc  => Var,
              Idv => IddespD);
         Genera(ConsIndex, C1, C2, C3);
      end if;

      cim(pproc, idproc);
      Novavar(Tv, idproc, T3);
      C1:=(
           Tc => Var,
           Idv => T3
          );
      C2:=(
           Tc => Var,
           Idv => T1
          );
      C3:=(
           Tc => Var,
           Idv => T2
          );

      case Op is
         when Unio => Genera(Op_Or,C1,C2,C3);
         when Interseccio => Genera(Op_And,C1,C2,C3);
         when others => null;
      end case;

      IdResultExp := T3;
      IddespExp := Var_Nul;

   end gci_Exp_Logica;


   procedure gci_Exp_Aritmetica
     (IdResE, IdResD, IddespE, IddespD : in num_var;
      IdResultExp, IddespExp : out num_var;
      Op : in Operacio) is

      T1,
      T2,
      T3 : num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      idproc : num_proc := proc_nul;

   begin

      if IddespE = Var_Nul then
         T1:= IdResE;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);

         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => IdResE
             );
         C3:=(
              Tc => Var,
              Idv => IddespE
             );
         Genera(Consindex,C1,C2,C3);

      end if;

      if IddespD = Var_Nul then
         T2 := IdResD;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T2);
         C1:=(
              Tc  => Var,
              Idv => T2
             );
         C2:=(
              Tc  => Var,
              Idv => IdResD
             );
         C3:=(
              Tc  => Var,
              Idv => IddespD);
         Genera(ConsIndex,C1,C2,C3);
      end if;

      cim(pproc, idproc);
      Novavar(Tv, idproc, T3);
      C1:=(
           Tc => Var,
           Idv => T3
          );
      C2:=(
           Tc => Var,
           Idv => T1
          );
      C3:=(
           Tc => Var,
           Idv => T2
          );

      case Op is
         when Suma => Genera(Suma,C1,C2,C3);
         when Resta => Genera(Resta,C1,C2,C3);
         when Mult => Genera(Producte,C1,C2,C3);
         when Div => Genera(Divisio,C1,C2,C3);
         when Modul => Genera(Modul,C1,C2,C3);
         when others => null;
      end case;

      IdResultExp := T3;
      IddespExp := Var_Nul;

   end gci_Exp_Aritmetica;


   procedure gci_Expressiou
     (A : in Pnode;
      Idr, Idd : out num_var) is

      Fdret : Pnode renames A.F4;
      Op : Operacio renames A.Op4;
      Idru, Iddu : Num_Var;

   begin
      gci_Expressio(Fdret, Idru, Iddu);
      case Op is
         when Resta =>
            gci_Exp_Negacio(Idru, Iddu, Idr, Idd);
         when Negacio =>
            gci_Exp_Neglogica(Idru, Iddu, Idr, Idd);
         when others =>
            null;
      end case;

   end gci_Expressiou;


   procedure gci_Exp_Negacio
     (idRes, Iddesp : in num_var;
      IdresultExp, IddespExp : out num_var) is

      T1,
      T2 : num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      idproc : num_proc := proc_nul;

   begin

      if Iddesp = Var_Nul then
         T1:= IdRes;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);

         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => IdRes
             );
         C3:=(
              Tc => Var,
              Idv => Iddesp
             );

         Genera(Consindex, C1, C2, C3);

      end if;

      Novavar(Tv, idproc, T2);
      C1:=(
           Tc => Var,
           Idv => T2
          );
      C2:=(
           Tc => Var,
           Idv => T1
          );


      Genera(Negacio, C1, C2);

      IdResultExp := T2;
      IddespExp := Var_Nul;

   end gci_Exp_Negacio;


   procedure gci_Exp_Neglogica
     (idRes, Iddesp : in num_var;
      IdresultExp, IddespExp : out num_var) is

      T1,
      T2 : num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      idproc : num_proc := proc_nul;

   begin

      if Iddesp = Var_Nul then
         T1:= IdRes;
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);

         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => IdRes
             );
         C3:=(
              Tc => Var,
              Idv => Iddesp
             );

         Genera(Consindex, C1, C2, C3);

      end if;


      Novavar(Tv, idproc, T2);
      C1:=(
           Tc => Var,
           Idv => T2
          );
      C2:=(
           Tc => Var,
           Idv => T1
          );

      Genera(Op_Not, C1, C2);

      IdResultExp := T2;
      IddespExp := Var_Nul;

   end gci_Exp_Neglogica;


   procedure gci_Referencia_Var
     (A : in Pnode;
      Idres, Iddesp: out Num_Var;
      Idtipus : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      --Idbase : Id_Nom;
      Idbase : Num_Var;
      It_Idx : Cursor_Idx;
      Da, Dtc : Descrip;
      T1,T2,T3,T4,T5: num_Var := Var_Nul;
      idproc : num_proc := proc_nul;
      C1, C2, C3: Camp;

   begin
      case Tipus is
         when Identificador =>
            Gci_Identificador(A, Idres, Iddesp, Idtipus);

         when Referencia => -- r -> r.id
            Gci_Ref_Rec(A, Idres, Iddesp, Idtipus);

         when Fireferencia => --r -> ref_pri)
            Gci_Ref_Pri(A.F6, Idres, Iddesp, Idbase, Idtipus, It_Idx);
			 cim(pproc, idproc);
            da := cons(Tts(idproc),Idtipus);
            Idtipus := da.tr;
            dtc := cons(Tts(idproc),da.tr);

            Novavar(Tv, idproc, T1);
            Novavar(Tv, idproc, T2);
            Novaconst(Tv, valor(dtc.dt.ocup), Tsent, idproc, T3);

            C1:=(
                 Tc => Var,
                 Idv => T1
                );
            C2:=(
                 Tc  => Var,
                 Idv => Iddesp
                );
            C3:=(
                 Tc  => Const,
                 Idc => T3
                );
            Genera(Resta, C1, C2, C3);
            C2.Idv := T2;
            C3.Idc := Dtc.Dt.Base;
            Genera(Producte, C2, C1, C3);

            if Idbase = var_nul then
               Iddesp := T2;
            else
               Novavar(Tv, idproc, T4);
               --Novaconst(Tv, Idbase, Tsent, idproc, T5);
			   Novaconst(Tv, valor(dtc.dt.ocup), Tsent, idproc, T5);

               C1:=(
                    Tc => Var,
                    Idv => T4
                   );
               C2:=(
                    Tc  => Const,
                    Idc => T5
                   );
               C3:=(
                    Tc  => Var,
                    Idv => T2
                   );
               Genera(Suma, C1, C2, C3);

            end if;

         when others => null;
      end case;

   end gci_Referencia_Var;


   --Arrays
   procedure gci_Ref_Pri --"Correcte"
     (A : in Pnode;
      Idres, Iddesp, Idbase : out Num_var;
      Idtipus : out Id_Nom;
      It_Idx : out Cursor_Idx) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      IdresE, iddespE : Num_var := Var_Nul;

      T0,T1,T2,T3 : num_Var := Var_Nul;
      C1, C2, C3 : Camp;
      idproc : num_proc := proc_nul;
      di : Id_nom;
      dti: descrip;
      ni : valor;

   begin
      case Tipus is
         when Pri => --pri -> pri ,E
                     --Put_Line("CT-ref_pri: pri");
			cim(pproc, idproc);
            
			Gci_Ref_Pri(Fesq, Idres, Iddesp, Idbase, Idtipus, It_Idx);
            gci_Expressio(Fdret, IdresE, IddespE);

            It_Idx := Succ_Idx(Tts(idproc), It_Idx);

            di := cons_idx(Tts(idproc), It_idx);
            dti := cons(Tts(idproc),di);
            ni := dti.dt.lsup - dti.dt.linf + 1;
            
            Novaconst(Tv, ni, Tsent, idproc, T0);
            Novavar(Tv, idproc, T1);

            C1:=(
                 Tc => Var,
                 Idv => T1
                );
            C2:=(
                 Tc => Var,
                 Idv => Iddesp
                );
            C3:=(
                 Tc  => Const,
                 Idc => T0
                );

            Genera(Producte, C1, C2, C3);
            Novavar(Tv, idproc, T2);
            if IddespE = var_nul then

               C1:=(
                    Tc => Var,
                    Idv => T2
                   );
               C2:=(
                    Tc => Var,
                    Idv => T1
                   );
               C3:=(
                    Tc => Var,
                    Idv => IdresE
                   );

               Genera(Suma, C1, C2, C3);

            else

               Novavar(Tv, idproc, T1);

               C1:=(
                    Tc => Var,
                    Idv => T3
                   );
               C2:=(
                    Tc => Var,
                    Idv => IdresE
                   );
               C3:=(
                    Tc => Var,
                    Idv => IddespE
                   );

               Genera(Suma, C1, C2, C3);

               C1:=(
                    Tc => Var,
                    Idv => T2
                   );
               C2:=(
                    Tc => Var,
                    Idv => T1
                   );
               C3:=(
                    Tc => Var,
                    Idv => T3
                   );

               Genera(Suma, C1, C2, C3);
            end if;
            Iddesp:=T2;

         when Encappri => -- encappri --> R(E
			
			cim(pproc, idproc);

            gci_Referencia_Var(Fesq, Idres, Idbase, Idtipus);
            gci_Expressio(Fdret, IdresE, IddespE);

            It_Idx := primer_idx(Tts(idproc), Idtipus); ------------

            if IddespE = var_nul then
               Iddesp:= idresE;
            else
               
               Novavar(Tv, idproc, T1);

               C1:=(
                    Tc => Var,
                    Idv => T1
                   );
               C2:=(
                    Tc => Var,
                    Idv => IdresE
                   );
               C3:=(
                    Tc => Var,
                    Idv => IddespE
                   );

               Genera(Suma, C1, C2, C3);
               Iddesp:=T1;
            end if;

         when others =>
            Put_Line("ERROR (DEBUG) gci-ref_pri: tipus no "&
                       "reconegut");
      end case;
   end gci_Ref_Pri;



   procedure gci_Ref_Rec --correcte
     (A : in Pnode;
      Idres, Iddesp: out num_var;
      Idtipus : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Tesq : Tipussubjacent;
      Idbase_Esq : Id_Nom;
      Dcamp : Descrip;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames A.Fd1.Id12;

      numconstant : num_var := var_nul;

      T1 :num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;

          Idproc : num_proc;

   begin

      Gci_Referencia_Var(Fesq, Idres, Iddesp, Idtipus);

	  cim(pproc, idproc);

      Dcamp := Conscamp(Tts(idproc), Idtipus, Idcamp);
      Idtipus:= dcamp.tcamp;

      Novaconst(Tv, valor(Dcamp.Dsp), Tsent, Idproc, numconstant);

      if Iddesp = var_nul then
         Iddesp:=numconstant;
      else
         Novavar(Tv, Idproc, T1);

         C1:=(Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => Iddesp
             );
         C3:=(
              Tc => Const, --------
              Idc => numconstant
             );
         Genera (Suma, C1, C2, C3);

         Iddesp:= T1;

      end if;

   end gci_Ref_Rec;


   procedure gci_Sconds
     (A : in Pnode) is

      Cond : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

      Idres, Iddesp : num_var;

      C1, C2, C3 : camp;
      efals: num_etiq;

      idproc : num_proc;
      T1 : num_Var := Var_Nul;

   begin

      efals := nova_etiq;

      gci_Expressio(Cond, Idres, Iddesp);

      if Iddesp = Var_Nul then
         C2:=(
              Tc => Var,
              Idv => Idres
             );
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);
         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => Idres
             );
         C3:=(
              Tc => Var,
              Idv => Iddesp
             );
         Genera(Consindex, C1, C2, C3);
         C2:=(
              Tc => Var,
              Idv => T1
             );
      end if;

      -- if C1 = C2 then Efals
      C3:=(
           Tc => Etiq,
           Ide => Efals
          );
      C1:=(
           Tc => Const,
           Idc => Zero
          );
      Genera(Igual, C2, C1, C3);

      gci_Bloc(Bloc);


      C1:=(
           Tc => Etiq,
           Ide => efals
          );
      Genera(Etiqueta, C1);

   end gci_Sconds;


   procedure gci_Scondc
     (A : in Pnode) is

      Cond : Pnode renames A.Fe2;
      Bloc : Pnode renames A.fc2;
      Blocelse : Pnode renames A.fd2;

      Idres, Iddesp : num_var;

      C1, C2, C3 : camp;
      efals, efinal: num_etiq;

      idproc : num_proc;
      T1 : num_Var := Var_Nul;

   begin

      efals := nova_etiq;
      efinal := nova_etiq;

      Gci_Expressio(Cond, Idres, Iddesp); ----

      if Iddesp = Var_Nul then
         C2:=(
              Tc => Var,
              Idv => Idres
             );
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);
         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => Idres
             );
         C3:=(
              Tc => Var,
              Idv => Iddesp
             );
         Genera(Consindex, C1, C2, C3);
         C2:=(
              Tc => Var,
              Idv => T1
             );
      end if;

      -- if C1 = C2 then Efals
      C3:=(
           Tc => Etiq,
           Ide => Efals
          );
      C1:=(
           Tc => Const,
           Idc => Zero
          );
      Genera(Igual, C2, C1, C3);

      Gci_Bloc(Bloc); ------

      C1:=(
           Tc => Etiq,
           Ide => efinal
          );
      Genera(Branc_Inc, C1);

      C1.Ide:=efals;
      Genera(Etiqueta, C1);

      Gci_Bloc(Blocelse); ----

      C1:=(
           Tc => Etiq,
           Ide => efinal
          );
      Genera(Etiqueta, C1);

   end gci_Scondc;


   procedure gci_Srep
     (A : in Pnode) is

      Exp : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

      Idres, Iddesp : num_var;

      C1, C2, C3 : camp;
      einicial, efinal: num_etiq;

      idproc : num_proc;
      T1 : num_Var := Var_Nul;

   begin
      einicial := nova_etiq;
      efinal := nova_etiq;


      C1:=(
           Tc => Etiq,
           Ide => einicial
          );
      Genera(Etiqueta, C1);

      gci_Expressio(Exp, Idres, Iddesp); ------

      C1:=(
           Tc => Etiq,
           Ide => efinal
          );

      if Iddesp = Var_Nul then
         C2:=(
              Tc => Var,
              Idv => Idres
             );
      else
         cim(pproc, idproc);
         Novavar(Tv, idproc, T1);
         C1:=(
              Tc => Var,
              Idv => T1
             );
         C2:=(
              Tc => Var,
              Idv => idres
             );
         C3:=(
              Tc => Var,
              Idv => iddesp
             );
         Genera(ConsIndex, C1, C2, C3);
         C2:=(
              Tc => Var,
              Idv => T1
             );
      end if;

      C3:=(
           Tc => Const,
           Idc => Zero
          );
      Genera(Igual, C2, C3, C1);  --if exp = 0 then etiqueta

      gci_Bloc(Bloc);  -----------

      C1 := (
             Tc => Etiq,
             Ide => einicial
            );
      Genera(Branc_Inc, C1);
      C1.Ide := efinal;
      Genera(Etiqueta, C1);

   end gci_Srep;

end semantica.gci;

