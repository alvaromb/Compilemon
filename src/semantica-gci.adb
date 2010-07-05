package body Semantica.Gci is

   package Pila_Proc is new Pilas (Num_Proc);
   use Pila_Proc;
   Pproc : Pila_Proc.Pila;

   package Pila_Param is new Pilas (T_Param);
   use Pila_Param;
   Pparam : Pila_Param.Pila;

   procedure Genera
     (instr : in Tinstruccio;
      C1    : in Camp := Camp_Nul;
      C2    : in Camp := Camp_Nul;
      C3    : in Camp := Camp_Nul) is
   begin
      Escriure_Fitxer((instr, C1, C2, C3));
   end Genera;


   procedure inicia_Generacio
     (Nomfitxer : in String) is
   begin
      if not Esem then
         Crea_Fitxer(Nomfitxer);
         Pila_Buida(Pproc);
         Pila_Buida(Pparam);
         Empilar(Pproc, Proc_Nul);
      end if;
   end inicia_Generacio;


   procedure Gci_Programa
     (A : in Pnode) is
   begin
      Nprofunditat := 1;
      Empilar(Pproc, Proc_Nul);
      Tv.Nv := Nv;
      Gci_Decprocediment(A);
      Calcula_Despls;
      Tanca_Fitxer;
   end Gci_Programa;


   procedure Gci_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Proc : Id_Nom renames A.Fid5.Id12;

      Eip : Num_Etiq;
      C1 : Camp;

      Ipr : info_Proc;
      Dproc : Descrip;

      Idprinvocador,
      Idprinvocat,
      Nproc : Num_Proc;

   begin

      Gci_Encap(Encap, Id_Proc);
      Eip := Nova_Etiq;
      Cim(Pproc, Nproc);
      Dproc := Cons(Tts(Nproc), Id_Proc);

      Ipr := (intern, 0, Id_Proc, Nprofunditat, 0, Eip);
      Nprofunditat := Nprofunditat + 1;
      Modif_Descripcio(Tp, Dproc.Np, Ipr);

      if Decls.Tipus = Declaracions then
         Gci_Declaracions(Decls);
      end if;

      C1 := (Etiq, Eip);
      Genera(Etiqueta, C1);
      C1:=(Proc, Dproc.Np);
      Genera(Preamb, C1);
      Gci_Bloc(Bloc);
      Nprofunditat := Nprofunditat - 1;

      --Rtn
      Cim(Pproc, Idprinvocat);
      C1:=(Proc, Idprinvocat);
      Genera(Rtn, C1);

      Desempilar(Pproc);
      Cim(Pproc, Idprinvocador);

   end Gci_Decprocediment;


   procedure Gci_Encap
     (A : in Pnode;
      I : in Id_Nom) is
      Dproc : Descrip;
      Idproc : Num_Proc;
   begin
      if A.Tipus = Pencap then
         Gci_Pencap(A);
      else
         Cim(Pproc, Idproc);
         Dproc := Cons(Tts(Idproc), I);
         Empilar(Pproc, Dproc.Np);
      end if;

   end Gci_Encap;


   procedure Gci_Pencap
     (A : in Pnode) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      Dproc : Descrip;
      Idproc : Num_Proc;

   begin
      if Fesq.Tipus = Identificador then
         Cim(Pproc, Idproc);
         Dproc := Cons(Tts(Idproc), Fesq.Id12);
         Empilar(Pproc, Dproc.Np);
         Gci_Param(Param);
      else
         Gci_Pencap(Fesq);
         Gci_Param(Param);
      end if;
   end Gci_Pencap;


   procedure Gci_Param
     (A : in Pnode) is

      Idpar : Id_Nom renames A.Fe2.Id12;
      D, Dtipus: Descrip;
      Idproc : Num_Proc;
      Iv : info_Var;

   begin
      Cim(Pproc, Idproc);
      D := Cons(Tts(Idproc), Idpar);

      case D.Td is
         when Dvar =>
            Dtipus:=Cons(Tts(Idproc),D.Tr);
            Iv := (Idpar,
                   Idproc,
                   Dtipus.Dt.Ocup,
                   0,
                   Dtipus.Dt.Tt,
                   True,
                   False,
                   0);
            Modif_Descripcio(Tv, D.Nv, Iv);

         when Dargc =>
            Dtipus:=Cons(Tts(Idproc),D.Targ);
            Iv := (Idpar,
                   Idproc,
                   Dtipus.Dt.Ocup,
                   0,
                   Dtipus.Dt.Tt,
                   True,
                   False,
                   0);
            Modif_Descripcio(Tv, D.Nvarg, Iv);
         when others =>
            Put_Line("Argsgci - No Es Un Misterio Carmen??");
      end case;
   end Gci_Param;


   procedure Gci_Declaracions
     (A : in Pnode) is

      Decl : Pnode renames A.Fd1;
      Decls : Pnode renames A.Fe1;

   begin
      if Decls.Tipus = Declaracions then
         Gci_Declaracions(Decls);
      end if;

      case Decl.Tipus is
         when Dvariable   =>
            Gci_Decvar(Decl);
         when Dconstant   =>
            Null;
         when Dcoleccio   =>
            Gci_Deccol(Decl);
         when Dregistre | Dencapregistre | Firecord =>
            Null;
         when Dsubrang    =>
            Null;
         when Procediment =>
            Gci_Decprocediment(Decl);
         when others =>
            Null;
      end case;
   end Gci_Declaracions;


   procedure Gci_Decvar
     (A : in Pnode) is

      Dvariable : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      Ivar : info_Var := info_Var_Nul;
      Desc,Desctipus : Descrip;
      Idproc : Num_Proc;

   begin
      Gci_Declsvar(Dvariable);
      Cim(Pproc, Idproc);
      Desc:= Cons(Tts(Idproc),Id);
      Desctipus := Cons(Tts(Idproc),Desc.Tr);
      Ivar := (Id,
               Idproc,
               Desctipus.Dt.Ocup,
               0,
               Desctipus.Dt.Tt,
               False,
               False,
               0);
      Modif_Descripcio(Tv, Desc.Nv, Ivar);
   end Gci_Decvar;

   procedure Gci_Declsvar
     (A : in Pnode) is

      Tnode : Tipusnode renames A.Tipus;
      Ivar : info_Var := info_Var_Nul;
      Desc,Desctipus : Descrip;
      Idproc : Num_Proc;

   begin
      if Tnode = Declmultvar then
         Gci_Declsvar(A.Fd1);
         Cim(Pproc, Idproc);
         Desc:= Cons(Tts(Idproc),A.Fe1.Id12);
         Desctipus := Cons(Tts(Idproc),Desc.Tr);
         Ivar := (A.Fe1.Id12,
                  Idproc,
                  Desctipus.Dt.Ocup,
                  0,
                  Desctipus.Dt.Tt,
                  False,
                  False,
                  0);
         Modif_Descripcio(Tv, Desc.Nv, Ivar);
      end if;
   end Gci_Declsvar;


   procedure Gci_Decconst
     (A : in Pnode) is

      Id : Id_Nom renames A.Fe2.Id12;
      Val : Pnode renames A.Fd2;
      Iconst : info_Var := info_Var_Nul;
      Desc, Desctipus : Descrip;
      Idproc : Num_Proc;

   begin
      Cim(Pproc, Idproc);
      Desc:= Cons(Tts(Idproc),A.Fd1.Id12);
      Desctipus := Cons(Tts(Idproc),Desc.Tr);
      Iconst := (Id,
                 Idproc,
                 Desctipus.Dt.Ocup,
                 0,
                 Desctipus.Dt.Tt,
                 False,
                 True,
                 Val.Val);
      Modif_Descripcio(Tv, Desc.Nv, Iconst);
   end Gci_Decconst;


   procedure Gci_Deccol
     (A : in Pnode) is

      Darray : Descrip;
      Fesq : Pnode renames A.Fe1;
      Idarray : Id_Nom;
      Base : Valor := 0;
      Idproc : Num_Proc;
      T1 : Num_Var;

   begin
      Gci_Pcoleccio(Fesq,Base,Idarray);
      Cim(Pproc, Idproc);
      Darray := Cons(Tts(Idproc),Idarray);
      Novaconst(Tv, Base, Tsent, Idproc, T1);
      Darray.Dt.Base := Base;
      Actualitza(Tts(Idproc), Idarray, Darray);
   end Gci_Deccol;


   procedure Gci_Pcoleccio
     (A : in Pnode;
      Base: in out Valor;
      Idarray : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Id   : Id_Nom renames A.Fd1.Id12;
      Ncomp : Valor;
      Dtcamp : Descrip;
      Idproc : Num_Proc;

   begin

      Cim(Pproc, Idproc);
      if (A.Tipus = Pcoleccio) then
         Gci_Pcoleccio(Fesq, Base, Idarray);
         Dtcamp := Cons(Tts(Idproc),Id);
         Ncomp :=  Dtcamp.Dt.Lsup - Dtcamp.Dt.Linf + 1;
         Base := (Base * Ncomp) + Dtcamp.Dt.Linf;

      elsif (A.Tipus = Pdimcoleccio) then
         Dtcamp := Cons(Tts(Idproc),Id);
         Idarray := Fesq.Id12;
         Base := Dtcamp.Dt.Linf;
      end if;
   end Gci_Pcoleccio;


   procedure Gci_Bloc
     (A : in Pnode) is

      D : Descrip;
      Idbase : Num_Proc;
      Idtipus : Id_Nom;
      Idres,
      Iddesp,
      Idr,
      Idd: Num_Var;

   begin
      case (A.Tipus) is
         when Bloc =>
            Gci_Bloc(A.Fe1);
            Gci_Bloc(A.Fd1);
         when Repeticio =>
            Gci_Srep(A);
         when Identificador =>
            Gci_Identificador(A, Idres, Iddesp, Idtipus);
         when Fireferencia =>
            Gci_Referencia_Proc(A, Idbase);
         when Condicionals =>
            Gci_Sconds(A);
         when Condicionalc =>
            Gci_Scondc(A);
         when Assignacio =>
            Gci_Referencia_Var(A.Fe1, Idr, Idd, Idtipus);
            Gci_Expressio(A.Fd1, Idres, Iddesp);
            Gci_Assignacio(Idr, Idd, Idres, Iddesp);
         when others => null;
      end case;
   end Gci_Bloc;


   procedure Gci_Assignacio
     (Idref, Iddref, Idrexp, Iddexp: in Num_Var) is
      C1,
      C2,
      C3,
      C4,
      C5 : Camp;
      T : Num_Var;
      Idproc : Num_Proc;

   begin
      C1:=(Var, Idref);
      C2:=(Var, Iddref);
      C3:=(Var, Idrexp);
      C4:=(Var, Iddexp);
      Cim(Pproc, Idproc);

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
            Novavar(Tv, Idproc, T);
            C5:=(Var, T);
            Genera(Consindex, C5, C3, C4);
            Genera(Asigindex, C1, C2, C5);
         end if;
      end if;
   end Gci_Assignacio;


   --Procediments
   procedure Gci_Referencia_Proc
     (A : in Pnode;
      Idproc : out Num_Proc) is

      Tipus : Tipusnode renames A.Tipus;
      Dproc : Descrip;
      Prm : T_Param;
      C1, C2 : Camp;

   begin
      case Tipus is
         when Identificador => --R -> Id
            Idproc:= Proc_Nul;
            Cim(Pproc,Idproc);
            Dproc := Cons(Tts(Idproc), A.Id12);
            Idproc := Dproc.Np;

         when Fireferencia => -- R -> Pri)
            Gci_Ref_Pri(A.F6, Idproc);

            while not Es_Buida(Pparam) loop
               Cim(Pparam, Prm);
               C1:=(Var, Prm.Base);
               C2:=(Var, Prm.Despl);

               if Prm.Despl=Var_Nul then
                  Genera(Params, C1);
               else
                  Genera(Paramc, C1, C2);
               end if;
               Desempilar(Pparam);
            end loop;

            C1:=(Proc, Idproc);
            Genera(Call, C1);

         when others =>
            Put_Line("Error (Debug)");
      end case;
   end Gci_Referencia_Proc;


   procedure Gci_Ref_Pri
     (A : in Pnode;
      Idproc : out Num_Proc) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      Idres, Iddesp : Num_Var;
      Prm:  T_Param;

   begin
      case Tipus is
         when Pri => --Pri -> Pri,E
            Gci_Ref_Pri(Fesq,Idproc);
            Gci_Expressio(Fdret, Idres, Iddesp);
            Prm.Base := Idres;
            Prm.Despl := Iddesp;
            Empilar(Pparam, Prm);

         when Encappri => -- Pri -> R(E
            Gci_Referencia_Proc(Fesq, Idproc);
            Gci_Expressio(Fdret, Idres, Iddesp);
            Prm.Base := Idres;
            Prm.Despl := Iddesp;
            Empilar(Pparam, Prm);

         when others =>
            Put_Line("Error (Debug)");
      end case;
   end Gci_Ref_Pri;


   procedure Gci_Identificador
     (A : in Pnode;
      Idres, Iddesp: out Num_Var;
      Idtipus : out Id_Nom) is

      D , Descconst: Descrip;
      Id : Id_Nom renames A.Id12;
      Desc : Tdescrip renames D.Td;

      Idv, T1 : Num_Var := Var_Nul;
      Idproc : Num_Proc := Proc_Nul;
      C1, C2: Camp;

      Iv : info_Var;

   begin
      Cim(Pproc, Idproc);
      D := Cons(Tts(Idproc), Id);
      case Desc is
         when Dvar => -- R -> Id
            Idres := D.Nv;
            Iddesp := Var_Nul;
            Idtipus := D.Tr;

         when Dconst =>
            Descconst := Cons(Tts(Idproc), D.Tc);
            Iv := (Id,
                   Idproc,
                   Descconst.Dt.Ocup,
                   0,
                   Descconst.Dt.Tt,
                   False,
                   True,
                   D.Vc);
            Modif_Descripcio(Tv, D.Nvc, Iv);
            Novavar(Tv, Idproc, T1);

            C1:=(Var, T1);
            C2:=(Const, D.Nvc);
            Genera(Copia, C1, C2);
            Idres:= T1;
            Iddesp:= Var_Nul;
            Idtipus:= D.Tc;

         when Dargc =>
            Novavar(Tv, Idproc, T1);
            C1:=(Var, T1);
            C2:=(Var, D.Nvarg);
            Genera(Copia, C1, C2);
            Idres := T1;
            Iddesp := Var_Nul;
            Idtipus := D.Targ;

         when Dproc =>
            D:=Cons(Tts(Idproc), Id);
            C1:=(Proc, D.Np);
            Genera(Call, C1);

         when others =>
            Put_Line("Es Un Altre Tipus Al Gci Identificador");

      end case;
   end Gci_Identificador;


   procedure Gci_Constant
     (A : in Pnode;
      Idres : out Num_Var) is

      Tatr : Tipus_Atribut renames A.Tconst;
      Idproc : Num_Proc;
      T : Tipussubjacent;
      T1 : Num_Var;
      C1,
      C2 : Camp;

   begin
      Cim(Pproc, Idproc);
      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when A_Lit_S =>
            T := Tsstr;
         when others => Null;
      end case;

      Novaconst(Tv, A.Val, T, Idproc, T1);
      Novavar(Tv, Idproc, Idres);
      C1:=(Const, T1);
      C2:=(Var, Idres);
      Genera(Copia, C2, C1);
   end Gci_Constant;


   procedure Gci_Expressio
     (A : in Pnode;
      Idr, Idd: out Num_Var) is

      Tipus : Tipusnode renames A.Tipus;
      Idtipus : Id_Nom;
      Desc : Descrip;

   begin
      Idd := Var_Nul;
      case Tipus is
         when Expressio =>
            Gci_Expressioc(A, Idr, Idd);
         when Expressiounaria =>
            Gci_Expressiou(A, Idr, Idd);
         when Identificador =>
            Gci_Identificador(A, Idr, Idd, Idtipus);
         when Const =>
            Gci_Constant(A, Idr);
         when Fireferencia | Referencia =>
            Gci_Referencia_Var(A, Idr, Idd, Idtipus);
         when others =>
            Put_Line("Error (Debug)");
      end case;
   end Gci_Expressio;


   procedure Gci_Expressioc
     (A : in Pnode;
      Idres,Idresdesp: out Num_Var) is

      Fesq : Pnode renames A.Fe3;
      Fdret : Pnode renames A.Fd3;
      Op : Operacio renames A.Op3;
      Idesq,
      Iddret,
      Iddespe,
      Iddespd : Num_Var;

   begin
      --Analitzam L'Operand Esquerra
      Gci_Expressio(Fesq, Idesq,Iddespe);
      --Analitzam L'Operand Dret
      Gci_Expressio(Fdret, Iddret,Iddespd);
      -- Comparam Els Tipus
      case Op is
         when Unio | interseccio =>
            Gci_Exp_Logica(Idesq, Iddret, Iddespe,
                           Iddespd, Idres, Idresdesp, Op);
         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            Gci_Exp_Relacional(Idesq, Iddret, Iddespe,
                               Iddespd, Idres, Idresdesp, Op);
         when Suma | Resta | Mult | Div | Modul =>
            Gci_Exp_Aritmetica(Idesq, Iddret, Iddespe,
                               Iddespd, Idres, Idresdesp, Op);
         when others =>
            Null;
      end case;
   end Gci_Expressioc;


   procedure Gci_Exp_Relacional
     (Idrese, Idresd, Iddespe, Iddespd : in Num_Var;
      Idresultexp, Iddespexp : out Num_Var;
      Op : in Operacio) is

      T1,
      T2,
      T3 : Num_Var := Var_Nul;

      Emig,
      Efi : Num_Etiq;

      C1,
      C2,
      C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;

   begin
      if Iddespe = Var_Nul then
         T1:= Idrese;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1:=(Var, T1);
         C2:=(Var, Idrese);
         C3:=(Var, Iddespe);
         Genera(Consindex,C1,C2,C3);
      end if;

      if Iddespd = Var_Nul then
         T2 := Idresd;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T2);
         C1:=(Var, T2);
         C2:=(Var, Idresd);
         C3:=(Var, Iddespd);
         Genera(Consindex,C1,C2,C3);
      end if;

      Emig:=Nova_Etiq;
      Efi:=Nova_Etiq;
      C1:=(Var, T1);
      C2:=(Var, T2);
      C3:=(Etiq, Emig);

      case Op is
         when Menor => Genera(Menor, C1, C2, C3);
         when Menorig => Genera(Menorigual, C1, C2, C3);
         when Igual => Genera(Igual,C1,C2,C3);
         when Majorig => Genera(Majorigual, C1, C2, C3);
         when Major => Genera(Major, C1, C2, C3);
         when Distint => Genera(Diferent, C1, C2, C3);
         when others => Null;
      end case;

      Cim(Pproc, Idproc);
      Novavar(Tv, Idproc, T3);
      C1 := (Var, T3 );
      C2 := (Const, Zero);
      Genera(Copia, C1, C2);
      C3 := (Etiq, Efi);
      Genera(Branc_inc, C3);
      C3.Ide := Emig;
      Genera(Etiqueta, C3);
      C2.Idc := Menysu;
      Genera(Copia, C1, C2);
      C3.Ide := Efi;
      Genera(Etiqueta, C3);
      Idresultexp := T3;
      Iddespexp := Var_Nul;
   end Gci_Exp_Relacional;


   procedure Gci_Exp_Logica
     (Idrese, Idresd, Iddespe, Iddespd : in Num_Var;
      Idresultexp, Iddespexp :   out Num_Var;
      Op : in Operacio) Is

      T1,
      T2,
      T3 : Num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;

   begin
      if Iddespe = Var_Nul then
         T1:= Idrese;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idrese);
         C3 := (Var, Iddespe);
         Genera(Consindex,C1,C2,C3);
      end if;

      if Iddespd = Var_Nul then
         T2 := Idresd;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T2);
         C1 := (Var, T2);
         C2 := (Var, Idresd);
         C3 := (Var, Iddespd);
         Genera(Consindex, C1, C2, C3);
      end if;

      Cim(Pproc, Idproc);
      Novavar(Tv, Idproc, T3);
      C1 := (Var, T3);
      C2 := (Var, T1);
      C3 := (Var, T2);

      case Op is
         when Unio => Genera(Op_Or,C1,C2,C3);
         when interseccio => Genera(Op_And,C1,C2,C3);
         when others => Null;
      end case;

      Idresultexp := T3;
      Iddespexp := Var_Nul;
   end Gci_Exp_Logica;


   procedure Gci_Exp_Aritmetica
     (Idrese, Idresd, Iddespe, Iddespd : in Num_Var;
      Idresultexp, Iddespexp : out Num_Var;
      Op : in Operacio) is

      T1,
      T2,
      T3 : Num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;

   begin
      if Iddespe = Var_Nul then
         T1:= Idrese;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idrese);
         C3 := (Var, Iddespe);
         Genera(Consindex,C1,C2,C3);
      end if;

      if Iddespd = Var_Nul then
         T2 := Idresd;
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T2);
         C1 := (Var, T2);
         C2 := (Var, Idresd);
         C3 := (Var, Iddespd);
         Genera(Consindex,C1,C2,C3);
      end if;

      Cim(Pproc, Idproc);
      Novavar(Tv, Idproc, T3);
      C1 := (Var, T3);
      C2:=(Var, T1);
      C3:=(Var, T2);

      case Op is
         when Suma => Genera(Suma, C1, C2, C3);
         when Resta => Genera(Resta, C1, C2, C3);
         when Mult => Genera(Producte, C1, C2, C3);
         when Div => Genera(Divisio, C1, C2, C3);
         when Modul => Genera(Modul, C1, C2, C3);
         when others => Null;
      end case;

      Idresultexp := T3;
      Iddespexp := Var_Nul;

   end Gci_Exp_Aritmetica;


   procedure Gci_Expressiou
     (A : in Pnode;
      Idr, Idd : out Num_Var) is

      Fdret : Pnode renames A.F4;
      Op : Operacio renames A.Op4;
      Idru, Iddu : Num_Var;

   begin
      Gci_Expressio(Fdret, Idru, Iddu);
      case Op is
         when Resta =>
            Gci_Exp_Negacio(Idru, Iddu, Idr, Idd);
         when Negacio =>
            Gci_Exp_Neglogica(Idru, Iddu, Idr, Idd);
         when others =>
            Null;
      end case;
   end Gci_Expressiou;


   procedure Gci_Exp_Negacio
     (Idres, Iddesp : in Num_Var;
      Idresultexp, Iddespexp : out Num_Var) is

      T1,
      T2 : Num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;

   begin
      Cim(Pproc, Idproc);
      if Iddesp = Var_Nul then
         T1:= Idres;
      else
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idres);
         C3 := (Var, Iddesp);
         Genera(Consindex, C1, C2, C3);
      end if;

      Novavar(Tv, Idproc, T2);
      C1 := (Var, T2);
      C2 := (Var, T1);

      Genera(Negacio, C1, C2);
      Idresultexp := T2;
      Iddespexp := Var_Nul;
   end Gci_Exp_Negacio;


   procedure Gci_Exp_Neglogica
     (Idres, Iddesp : in Num_Var;
      Idresultexp, Iddespexp : out Num_Var) is

      T1,
      T2 : Num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;

   begin
      Cim(Pproc, Idproc);
      if Iddesp = Var_Nul then
         T1:= Idres;
      else
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idres);
         C3 := (Var, Iddesp);
         Genera(Consindex, C1, C2, C3);
      end if;

      Novavar(Tv, Idproc, T2);
      C1 := (Var, T2);
      C2 := (Var, T1);

      Genera(Op_Not, C1, C2);
      Idresultexp := T2;
      Iddespexp := Var_Nul;

   end Gci_Exp_Neglogica;


   procedure Gci_Referencia_Var
     (A : in Pnode;
      Idres, Iddesp: out Num_Var;
      Idtipus : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      Idbase : Num_Var;
      It_Idx : Cursor_Idx;
      Da, Dtc : Descrip;
      T1,T2,T3,T4,T5,T6,T7: Num_Var := Var_Nul;
      Idproc : Num_Proc := Proc_Nul;
      C1, C2, C3: Camp;

   begin
      case Tipus is
         when Identificador =>
            Gci_Identificador(A, Idres, Iddesp, Idtipus);

         when Referencia => -- R -> R.Id
            Gci_Ref_Rec(A, Idres, Iddesp, Idtipus);

         when Fireferencia => --R -> Ref_Pri)
            Gci_Ref_Pri(A.F6, Idres, Iddesp, Idbase, Idtipus, It_Idx);

            Cim(Pproc, Idproc);
            Dtc := Cons(Tts(Idproc),Idtipus);
            Idtipus := Dtc.Dt.Tcamp;
            Novavar(Tv,Idproc, T7);
            Novaconst(Tv, Valor(Dtc.Dt.Base), Tsent, Idproc, T3);

            C1 := (Var, T7);
            C2 := (Var, Iddesp);
            C3 := (Const, T3);
            Genera(Resta, C1, C2, C3);
            Novavar(Tv, Idproc, T1);
            Novaconst(Tv, Valor(integer'Size/8), Tsent, Idproc, T6);

            C1 := (Var, T1);
            C2 := (Var, T7);
            C3 := (Const, T6);
            Genera(Producte, C1, C2, C3);
            Novavar(Tv, Idproc, T2);

            if Idbase = Var_Nul then
               Iddesp := T1;
            else
               Novavar(Tv, Idproc, T4);
               Novaconst(Tv, Valor(Dtc.Dt.Ocup), Tsent, Idproc, T5);

               C1 := (Var, T4);
               C2 := (Const, T5);
               C3 := (Var, T2);
               Genera(Suma, C1, C2, C3);
            end if;
         when others => Null;
      end case;

   end Gci_Referencia_Var;


   --Arrays
   procedure Gci_Ref_Pri
     (A : in Pnode;
      Idres, Iddesp, Idbase : out Num_Var;
      Idtipus : out Id_Nom;
      It_Idx : out Cursor_Idx) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      Idrese, Iddespe : Num_Var := Var_Nul;

      T0,T1,T2,T3 : Num_Var := Var_Nul;
      C1, C2, C3 : Camp;
      Idproc : Num_Proc := Proc_Nul;
      Di : Id_Nom;
      Dti: Descrip;
      Ni : Valor;

   begin
      case Tipus is
         when Pri => --Pri -> Pri ,E
                     --Put_Line("Ct-Ref_Pri: Pri");
            Cim(Pproc, Idproc);

            Gci_Ref_Pri(Fesq, Idres, Iddesp, Idbase, Idtipus, It_Idx);
            Gci_Expressio(Fdret, Idrese, Iddespe);

            It_Idx := Succ_Idx(Tts(Idproc), It_Idx);

            Di := Cons_Idx(Tts(Idproc), It_Idx);
            Dti := Cons(Tts(Idproc),Di);
            Ni := Dti.Dt.Lsup - Dti.Dt.Linf + 1;

            Novaconst(Tv, Ni, Tsent, Idproc, T0);
            Novavar(Tv, Idproc, T1);
            C1 := (Var, T1);
            C2 := (Var, Iddesp);
            C3 := (Const, T0);
            Genera(Producte, C1, C2, C3);
            Novavar(Tv, Idproc, T2);

            if Iddespe = Var_Nul then
               C1 := (Var, T2);
               C2 := (Var, T1);
               C3 := (Var, Idrese);
               Genera(Suma, C1, C2, C3);
            else
               C1 := (Var, T3);
               C2 := (Var, Idrese);
               C3 := (Var, Iddespe);
               Genera(Suma, C1, C2, C3);

               C1 := (Var, T2);
               C2 := (Var, T1);
               C3 := (Var, T3);
               Genera(Suma, C1, C2, C3);
            end if;
            Iddesp := T2;

         when Encappri => -- Encappri --> R(E
            Cim(Pproc, Idproc);

            Gci_Referencia_Var(Fesq, Idres, Idbase, Idtipus);
            Gci_Expressio(Fdret, Idrese, Iddespe);
            It_Idx := Primer_Idx(Tts(Idproc), Idtipus);

            if Iddespe = Var_Nul then
               Iddesp:= Idrese;
            else
               Novavar(Tv, Idproc, T1);
               C1:=(Var, T1);
               C2:=(Var, Idrese);
               C3:=(Var, Iddespe);
               Genera(Suma, C1, C2, C3);
               Iddesp:=T1;
            end if;

         when others =>
            Put_Line("Error (Debug)");
      end case;
   end Gci_Ref_Pri;


   procedure Gci_Ref_Rec
     (A : in Pnode;
      Idres, Iddesp: out Num_Var;
      Idtipus : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Dcmp : Descrip;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames A.Fd1.Id12;

      Numconstant : Num_Var := Var_Nul;

      T1 :Num_Var := Var_Nul;
      C1,
      C2,
      C3 : Camp;
      Dtipus_Camp : Descrip;
      Idproc : Num_Proc;

   begin
      Gci_Referencia_Var(Fesq, Idres, Iddesp, Idtipus);
      Cim(Pproc, Idproc);
      Dcmp := Conscamp(Tts(Idproc), Idtipus, Idcamp);
      Idtipus:= Dcmp.Tcamp;
      Dtipus_Camp := Cons(Ts, Idtipus);
      Novaconst(Tv, Valor(Dcmp.Dsp*4),
                Tsent, Idproc, Numconstant);
      if Iddesp = Var_Nul then
         Iddesp:=Numconstant;
      else
         Novavar(Tv, Idproc, T1);
         C1:=(Var, T1);
         C2:=(Var, Iddesp);
         C3:=(Const, Numconstant);
         Genera (Suma, C1, C2, C3);
         Iddesp:= T1;
      end if;
   end Gci_Ref_Rec;


   procedure Gci_Sconds
     (A : in Pnode) is

      Cond : Pnode renames A.Fe1;
      Bloc : Pnode renames A.Fd1;

      Idres, Iddesp : Num_Var;

      C1, C2, C3 : Camp;
      Efals: Num_Etiq;

      Idproc : Num_Proc;
      T1 : Num_Var := Var_Nul;

   begin
      Efals := Nova_Etiq;
      Gci_Expressio(Cond, Idres, Iddesp);
      if Iddesp = Var_Nul then
         C2 := (Var, Idres);
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idres);
         C3 := (Var, Iddesp);
         Genera(Consindex, C1, C2, C3);
         C2 := (Var, T1);
      end if;

      C3 := (Etiq, Efals);
      C1 := (Const, Zero);
      Genera(Igual, C2, C1, C3);
      Gci_Bloc(Bloc);
      Genera(Etiqueta, C3);
   end Gci_Sconds;


   procedure Gci_Scondc
     (A : in Pnode) is

      Cond : Pnode renames A.Fe2;
      Bloc : Pnode renames A.Fc2;
      Blocelse : Pnode renames A.Fd2;

      Idres, Iddesp : Num_Var;

      C1, C2, C3 : Camp;
      Efals, Efinal: Num_Etiq;

      Idproc : Num_Proc;
      T1 : Num_Var := Var_Nul;

   begin
      Efals := Nova_Etiq;
      Efinal := Nova_Etiq;
      Gci_Expressio(Cond, Idres, Iddesp);

      if Iddesp = Var_Nul then
         C2 := (Var, Idres);
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idres);
         C3 := (Var, Iddesp);
         Genera(Consindex, C1, C2, C3);
         C2 := (Var, T1);
      end if;

      C3 := (Etiq, Efals);
      C1 := (Const, Zero);
      Genera(Igual, C2, C1, C3);

      Gci_Bloc(Bloc);
      C1 := (Etiq, Efinal);
      Genera(Branc_inc, C1);

      C1.Ide:=Efals;
      Genera(Etiqueta, C1);

      Gci_Bloc(Blocelse);
      C1 := (Etiq, Efinal);
      Genera(Etiqueta, C1);

   end Gci_Scondc;


   procedure Gci_Srep
     (A : in Pnode) is

      Exp : Pnode renames A.Fe1;
      Bloc : Pnode renames A.Fd1;

      Idres, Iddesp : Num_Var;

      C1, C2, C3 : Camp;
      Einicial, Efinal: Num_Etiq;

      Idproc : Num_Proc;
      T1 : Num_Var := Var_Nul;

   begin
      Einicial := Nova_Etiq;
      Efinal := Nova_Etiq;
      C1 := (Etiq, Einicial);
      Genera(Etiqueta, C1);

      Gci_Expressio(Exp, Idres, Iddesp);
      C1 := (Etiq, Efinal);

      if Iddesp = Var_Nul then
         C2 := (Var, Idres);
      else
         Cim(Pproc, Idproc);
         Novavar(Tv, Idproc, T1);
         C1 := (Var, T1);
         C2 := (Var, Idres);
         C3 := (Var, Iddesp);
         Genera(Consindex, C1, C2, C3);
         C2 := (Var, T1);
      end if;

      C3 := (Const, Zero);
      Genera(Igual, C2, C3, C1);

      Gci_Bloc(Bloc);
      C1 := (Etiq, Einicial);
      Genera(Branc_inc, C1);
      C1.Ide := Efinal;
      Genera(Etiqueta, C1);

   end Gci_Srep;


   -- Calcula Desplaçaments
   procedure Calcula_Despls is
      Idpr     : Num_Proc;
      Ocup_Var : Despl;

   begin
      for P in Num_Proc loop
         if Tp.Tp(P).Tp = intern then
            Tp.Tp(P).Ocup_Var := 0;
         end if;
      end loop;

      for V in Num_Var range 1..Tv.Nv loop
         if Tv.Tv(V).Param then
            Idpr := Tv.Tv(V).Np;
            if Tp.Tp(Idpr).Tp = intern then
               Tv.Tv(V).Desp := Tp.Tp(Idpr).Ocup_Param + 12;
               Tp.Tp(Idpr).Ocup_Param := Despl(Tp.Tp(Idpr).Ocup_Param) + 4;
            end if;
         else
            Idpr := Tv.Tv(V).Np;
            if Tp.Tp(Idpr).Tp = intern then
               Ocup_Var := Tv.Tv(V).Ocup;
               Tp.Tp(Idpr).Ocup_Var := Tp.Tp(Idpr).Ocup_Var + Ocup_Var;
               Tv.Tv(V).Desp := Despl(Tp.Tp(Idpr).Ocup_Var* (-1));
            end if;
         end if;
      end loop;

   end Calcula_Despls;


end Semantica.Gci;

