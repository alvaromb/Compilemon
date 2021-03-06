with U_Lexica;

use U_Lexica;

package body Semantica.Ctipus is

   procedure Mt_Atom
     (L, C : in Natural;
      A : out Atribut) is
   begin
      A := (Atom, L, C);
   end Mt_Atom;


   procedure Mt_Identificador
     (L, C : in Natural;
      S : in String;
      A : out Atribut) is
      Id : Id_Nom;
   begin
      Id := Id_Nul;
      Posa_Id(Tn, Id, S);
      A := (A_Ident, L, C, Id);
   end Mt_Identificador;


   procedure Mt_String
     (L, C : in Natural;
      S : in String;
      A : out Atribut) is
      Id : Rang_Tcar;
   begin
      Posa_Str(Tn, Id, S);
      A := (A_Lit_S, L, C, Valor(Id));
   end Mt_String;


   procedure Mt_Caracter
     (L, C : in Natural;
      Car : in String;
      A : out Atribut) is
   begin
      A := (A_Lit_C, L, C,
            Valor(Character'Pos(Car(Car'First+1))));
   end Mt_Caracter;


   procedure Mt_Numero
     (L, C : in Natural;
      S : in String;
      A : out Atribut) is
   begin
      A := (A_Lit_N, L, C, Valor(Integer'Value(S)));
   end Mt_Numero;


   -- Taula de simbols
   procedure Inicia_Enter is
      D : Descrip;
      Dt : Descriptipus;
      Idn, Ida, Idint : Id_Nom;
      E : Boolean;

      Ipr : Info_Proc;
      Idpr : Num_Proc;
      Iv : Info_Var;
      Idv : Num_Var;

   begin
      -- Constants inicials
      Posa_Id(Tn, Idn, "_zero");
      Iv := (Idn, Tp.Np, Integer'Size/8, 0, Tsent,
             False, True, 0);
      Nv := Nv + 1;
      Posa(Tv, Iv, Zero);

      Posa_Id(Tn, Idn, "_menysu");
      Iv := (Idn, Tp.Np, Integer'Size/8, 0, Tsent,
             False, True, -1);
      Posa(Tv, Iv, Menysu);
      Nv := Nv + 1;

      -- "Integer"
      Posa_Id(Tn, Idint, "integer");
      Dt := (Tsent, Integer'Size/8, Valor(Integer'First),
             Valor(Integer'Last));
      D := (Dtipus, Dt);
      Posa(Ts, Idint, D, E);

      -- "puti"
      Posa_Id(Tn, Idn, "puti");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_puti");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Param,
             Tsent, True, False, 0);
      Posa(Tv, Iv, Idv);
      Nv := Nv + 1;
      D := (Dargc, Idv, Idint);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

      -- "geti"
      Posa_Id(Tn, Idn, "geti");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_geti");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Param, Tsent,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      Nv := Nv + 1;
      D := (Dargc, Idv, Idint);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

   end Inicia_Enter;


   procedure Inicia_Boolea is
      D : Descrip;
      Dt : Descriptipus;
      Idb, Idt, Idf : Id_Nom;
      E : Boolean;

      Iv : Info_Var;
      Idv : Num_Var;
   begin
      Posa_Id(Tn, Idb, "boolean");
      Dt := (Tsbool, Integer'Size/8, -1, 0);
      D := (Dtipus, Dt);
      Posa(Ts, Idb, D, E);

      Posa_Id(Tn, Idt, "true");
      Iv := (Idt, 0, Integer'Size/8, 0, Tsbool, False,
             True, -1);
      Posa(Tv, Iv, Idv);
      Nv := Nv+1;
      D := (Dconst, Idb, -1, Nv);
      Posa(Ts, Idt, D, E);

      Posa_Id(Tn, Idf, "false");
      Iv.Id := Idf;
      Iv.Valconst := 0;
      Posa(Tv, Iv, Idv);
      Nv := Nv+1;
      D := (Dconst, Idb, 0, Nv);
      Posa(Ts, Idf, D, E);
   end Inicia_Boolea;


   procedure Inicia_Caracter is
      D : Descrip;
      Dt : Descriptipus;
      Idn, Idstring, Ida, Idchar : Id_Nom;
      E : Boolean;
      Ipr : Info_Proc;
      Idpr : Num_Proc;
      Iv : Info_Var;
      Idv : Num_Var;
   begin
      -- "character"
      Posa_Id(Tn, Idchar, "character");
      Dt := (Tscar, 4, Valor(Character'Pos(Character'First)),
             Valor(Character'Pos(Character'Last)));
      D := (Dtipus, Dt);
      Posa(Ts, Idchar, D, E);

      -- "string"
      Posa_Id(Tn, Idstring, "string");
      Dt := (Tsstr, 4, Idchar, 0); --0 es la base
      D := (Dtipus, Dt);
      Posa(Ts, Idstring, D, E);

      -- putc
      Posa_Id(Tn, Idn, "putc");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;

      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_putc");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Param, Tscar,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      nv:= nv +1;
      D := (Dargc, Idv, Idchar);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

      -- getc
      Posa_Id(Tn, Idn, "getc");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;

      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_getc");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Param, Tscar,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      nv:= nv +1;
      D := (Dargc, Idv, Idchar);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

      -- getcc
      Posa_Id(Tn, Idn, "getcc");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_getcc");
      Iv := (Ida, Idpr, 1, Ipr.Ocup_Param, Tscar,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      nv:= nv +1;
      D := (Dargc, Idv, Idchar);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);

      -- puts
      Posa_Id(Tn, Idn, "puts");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      Id_Puts := Idpr;

      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      --arg_puts
      Posa_Id(Tn, Ida, "_arg_puts");
      Iv := (Ida, Idpr, 4, Ipr.Ocup_Param, Tsstr,
             True, False, 0);--16 * Integer'Size
      Posa(Tv, Iv, Idv);
      nv:= nv +1;
      D := (Dargc, Idv, Idstring);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

      -- gets
      Posa_Id(Tn, Idn, "gets");
      Ipr := (Extern, 4, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      Id_Gets := Idpr;

      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);
      --arg_gets
      Posa_Id(Tn, Ida, "_arg_gets");
      Iv := (Ida, Idpr, 4, Ipr.Ocup_Param, Tsstr,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      Nv := Nv +1;
      D := (Dargc, Idv, Idstring);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

      -- nova linea
      Posa_Id(Tn, Idn, "new_line");
      Ipr := (Extern, 0, Idn);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);
   end Inicia_Caracter;


   procedure Inicia_Analisi
     (Nomfitxer : in String) is
   begin
      Nv := 0;
      Np := 0;
      Tbuida(Tn);
      Tbuida(Ts);
      -- Iniciam les Taules
      Noves_Taules(Tp, Tv);
      Inicia_Enter;
      Inicia_Boolea;
      Inicia_Caracter;
      Obre_Fitxer(nomFitxer);
   end Inicia_analisi;

   -- Procediments interns
   procedure Posa_Idvar
     (Idvar : in Id_Nom;
      Idtipus : in Id_Nom;
      L, C : in Natural;
      E : out Boolean) is
      Tassig : Descrip;
   begin
      Nv := Nv + 1;
      Tassig := (Dvar, Idtipus, Nv);
      Posa(Ts, Idvar, Tassig, E);
      if E then
         Error(Id_Existent, L, C, Cons_Nom(Tn, Idvar));
         Esem := True;
      end if;
   end Posa_Idvar;


   -- Comprovacio de tipus
   procedure Ct_Programa
     (A : in Pnode) is
      D : Descrip;
      Idproc : Id_nom renames A.Fid5.Id12;
      Ida : Cursor_Arg;
   begin
      Ct_Decprocediment(A);
      Ida := Primer_Arg(Ts, Idproc);
      if (Arg_Valid(Ida)) then
         Error(Paramspprincipal, Cons_Nom(Tn, Idproc));
         Esem := True;
      end if;
      Tts(Proc_Nul) := Ts;
      Tanca_Fitxer;

   end Ct_Programa;


   procedure Ct_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Inf : Id_Nom renames A.Fid5.Id12;
      Id_Sup : Id_Nom;
      Tdecls : Tipusnode;
      np_propi : num_proc;

   begin
      Ct_Encap(Encap, Id_Sup);
      Np_Propi := Np;
      if Id_Inf /= Id_Sup then
         Error(Idprogdiferents, A.Fid5.l1, A.Fid5.c1,
               Cons_Nom(Tn, Id_Sup));
         Esem := True;
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;
      Ct_Bloc(Bloc);
      Tts(Np_Propi) := Ts;

      Surtbloc(Ts,tn);

   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom) is

      Tproc : Descrip;
      E : Boolean;
      Idx_Arg : Cursor_Arg;
      Ida : Id_Nom;
      Dn : Descrip;

   begin

      if A.Tipus = Pencap then
         Ct_Pencap(A, I);
         Idx_Arg := Primer_Arg(Ts, I);
         while Arg_Valid(Idx_Arg) loop
            Cons_Arg(Ts, Idx_Arg, Ida, Dn);
            Posa(Ts, Ida, Dn, E);
            if E then
               Error(Enregarg, 3, 3, Cons_Nom(Tn, Ida));
               Esem := True;
            end if;
            Idx_Arg := Succ_Arg(Ts, Idx_Arg);
         end loop;

      else
         I := A.Id12;
         Np := Np + 1;
         Tproc := (Dproc, Np);
         Posa(Ts, I, Tproc, E);
         Entrabloc(Ts);
         if E then
            Error(Id_Existent, A.l1, A.C1, Cons_Nom(Tn, I));
            Esem := True;
         end if;

      end if;

   end Ct_Encap;


   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      Tproc : Descrip;
      E : Boolean;

   begin

      if Fesq.Tipus = Identificador then
         Np := Np + 1;
         Tproc := (Dproc, Np);
         Posa(Ts, Fesq.Id12, Tproc, E);
         if E then
            Error(Id_Existent, Fesq.L1, Fesq.C1,
                  Cons_Nom(Tn, Fesq.Id12));
            Esem := True;
         end if;
         Entrabloc(Ts);
         I := Fesq.Id12;
      else
         Ct_Pencap(Fesq, I);

      end if;
      Ct_Param(Param, I);
   end Ct_Pencap;


   procedure Ct_Param
     (A : in Pnode;
      I : in Id_Nom) is

      Idpar : Id_Nom renames A.Fe2.id12;
      Marg : Mmode renames A.Fc2.M12;
      Idtipus : Id_Nom renames A.Fd2.id12;
      D : Descrip;
      Darg : Descrip;
      E : Boolean;

   begin
      D := Cons(Ts, Idtipus);
      if D.Td /= Dtipus then
         Error(Tipusparam, A.Fd2.l1, A.Fd2.c1,
               Cons_Nom(Tn, Idtipus));
         Esem := True;
      end if;

      case Marg is
         when Surt | Entrasurt =>
            Nv := Nv + 1;
            Darg := (Dvar, Idtipus, Nv);
         when Entra =>
            Nv := Nv + 1;
            Darg := (Dargc, Nv, Idtipus);
         when others =>
            null;
      end case;

      Posa_Arg(Ts, I, Idpar, Darg, E);
      if E then
         Error(Enregarg, A.Fe2.l1, A.Fe2.c1,
               Cons_Nom(Tn, IdPar));
         Esem := True;
      end if;

   end Ct_Param;


   procedure Ct_Declaracions
     (A : in Pnode) is

      Decl : Pnode renames A.Fd1;
      Decls : Pnode renames A.Fe1;
      Tnode : Tipusnode;
      Idrec : Id_Nom;
      Ocup  : Despl;

   begin

      if Decls.Tipus = Declaracions then
         Ct_Declaracions(Decls);
      end if;

      Cons_Tnode(Decl, Tnode);
      case Tnode is
         when Dvariable   =>
            Ct_Decvar(Decl);
         when Dconstant   =>
            Ct_Decconst(Decl);
         when Dcoleccio   =>
            Ct_Deccol(Decl);
         when Dregistre | Dencapregistre | Firecord =>
            Ocup := 0;
            Ct_Decregistre(Decl, Idrec,Ocup);
         when Dsubrang    =>
            Ct_Decsubrang(Decl);
         when Procediment =>
            Ct_Decprocediment(Decl);
         when others =>
            Esem := True;
            null;
      end case;

   end Ct_Declaracions;


   procedure Ct_Decvar
     (A : in Pnode) is

      Dvariable : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      L : Natural renames A.Fe1.L1;
      C : Natural  renames A.Fe1.C1;
      Tassig : Descrip;
      Idtipus : Id_nom;
      E : Boolean;

   begin
      Ct_Declsvar(Dvariable, Idtipus);
      Posa_Idvar(Id, Idtipus, L, C, E);
   end Ct_Decvar;


   procedure Ct_Declsvar
     (A : in Pnode;
      Idtipus : out Id_Nom) is

      Tnode : Tipusnode renames A.Tipus;
      E : Boolean;
      Tdecl : Descrip;

   begin

      if Tnode = Identificador then
         Tdecl := Cons(Ts, A.Id12);
         if (Tdecl.Td /= Dtipus) then
            Error(Tipusinexistent, A.L1, A.C1,
                  Cons_Nom(Tn, A.Id12));
            Esem := True;
         end if;
         Idtipus := A.Id12;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(A.Fd1, Idtipus);
         Posa_Idvar(A.Fe1.Id12, Idtipus, A.Fe1.L1,
                    A.Fe1.C1, E);
      end if;

   end Ct_Declsvar;


   procedure Ct_Decconst
     (A : in Pnode) is

      Id : Id_Nom renames A.Fe2.Id12;
      Idtipus : Id_Nom renames A.Fc2.Id12;
      Val : Pnode renames A.Fd2;
      E : Boolean;
      Tdecl : Descrip;
      Tconst : Descrip;

      Tsubj : Tipussubjacent;
      Ids : Id_Nom;
      L, C : Natural := 0;

   begin

      Tdecl := Cons(Ts, Idtipus);
      if (Tdecl.Td /= Dtipus) then
         Error(Tipusinexistent, A.Fc2.L1, A.Fc2.C1,
               Cons_Nom(Tn, Idtipus));
         Esem := True;
      else
         Ct_Constant(Val, Tsubj, Ids, L, C);
         if (Tsubj /= Tdecl.Dt.Tt) then
            Error(Tipussubdiferents, A.Fc2.L1, A.Fc2.C1,
                  Cons_Nom(Tn, Idtipus));
            Esem := True;
         end if;

         if (Tdecl.Dt.Tt > Tsent) then
            Error(Tsub_No_Escalar, A.Fc2.L1, A.Fc2.C1,
                  Cons_Nom(Tn, Idtipus));
            Esem := True;
         end if;

         if (Tsubj = Tsent or Tsubj = Tsbool or
               Tsubj = Tscar) then
            if (Val.Val < Tdecl.Dt.Linf) or
              (Val.Val > Tdecl.Dt.Lsup) then
               Error(Rang_Sobrepassat, A.Fe2.L1, A.Fe2.C1,
                     Cons_Nom(Tn, Id));
               Esem := True;
            end if;
         end if;

         Nv := Nv + 1;
         Tconst := (Dconst, Idtipus, Val.Val, Nv);
         Posa(Ts, Id, Tconst, E);

         if E then
            Error(Id_Existent, A.Fe2.L1, A.Fe2.C1,
                  Cons_Nom(Tn, Id));
            Esem := True;
         end if;
      end if;

   end Ct_Decconst;


   procedure Ct_Deccol
     (A : in Pnode) is

      Darray : Descrip;
      Dtarray : Descrip;
      Fesq : Pnode renames A.Fe1;
      Idtipus_Array : Id_Nom renames A.Fd1.Id12;
      Idarray : Id_Nom;
      Ncomponents : Despl;

   begin
      Dtarray := Cons(Ts, Idtipus_Array);
      if (Dtarray.Td /= Dtipus) then
         Error(Tipusinexistent, A.Fd1.L1, A.Fd1.C1,
               Cons_Nom(Tn, Idtipus_Array));
         Esem := True;
      else
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray,
                      Ncomponents);
         Darray := Cons(Ts, Idarray);
         Darray.Dt.Tcamp := Idtipus_Array;
         Darray.Dt.Ocup := Ncomponents * Dtarray.Dt.Ocup;
         Actualitza(Ts, Idarray, Darray);
      end if;
   end Ct_Deccol;


   procedure Ct_Pcoleccio
     (A : in Pnode;
      Idtipus_Array : in Id_Nom;
      Idarray : out Id_Nom;
      Ncomponents : out Despl) is

      Fesq : Pnode renames A.Fe1;
      Idrang : Id_Nom renames A.Fd1.Id12;
      E : Boolean;

      Dtarray : Descriptipus;
      Darray : Descrip;
      Di : Descrip;

   begin
      if (A.Tipus = Pcoleccio) then
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray,
                      Ncomponents);
         Posa_Idx(Ts, Idarray, Idrang, E);

         if E then
            Error(Posaidxarray, A.Fd1.L1, A.Fd1.C1,
                  Cons_Nom(Tn, Idrang));
            Esem := True;
         else
            Di := Cons(Ts, Idrang);
            if Di.Td = Dtipus then
               Ncomponents := Ncomponents *
                 Despl(Di.Dt.Lsup - Di.Dt.Linf + 1);
            else
               Error(Tipusidxerroniarray, A.Fd1.L1,
                     A.Fd1.C1, Cons_Nom(Tn, Idrang));
               Esem := True;
            end if;
         end if;

      elsif (A.Tipus = Pdimcoleccio) then
         Dtarray := (Tsarr, 0, Idtipus_Array, 0);
         Darray := (Dtipus, Dtarray);
         Idarray := Fesq.Id12;
         Posa(Ts, Idarray, Darray, E);
         if E then
            Error(Tipusinexistent, Fesq.L1, Fesq.C1,
                  Cons_Nom(Tn, Idtipus_Array));
            Esem := True;
            Ncomponents := 0;
         end if;

         Di := Cons(Ts, Idrang);
         if not (Di.Td = Dtipus and then
                   Di.Dt.Tt <= Tsent) then
            Error(Tipusidxerroniarray, A.Fd1.L1, A.Fd1.C1,
                  Cons_Nom(Tn, Idrang));
            Esem := True;
            Ncomponents := 0;
         else
            Posa_Idx(Ts, Idarray, Idrang, E);
            if E then
               Put_Line("ERROR CT-pdimcoleccio (DEBUG): "&
                          "error al posa_idx, error "&
                          "del compilador, array no creat,"&
                          " idarr: "&Idarray'Img);
               Esem := True;
            end if;

            Ncomponents := Despl(Di.Dt.Lsup
                                   - Di.Dt.Linf + 1);
         end if;
      end if;

   end Ct_Pcoleccio;


   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom;
      Ocup: in out despl) is

      Drecord : Descrip;
      Dtrecord : Descriptipus;
      E : Boolean;

   begin
      if (A.Tipus = Dregistre) then
         Dtrecord := (Tsrec, 0);
         Drecord := (Dtipus, Dtrecord);
         Posa(Ts, A.Fe2.Id12, Drecord, E);
         Idrecord := A.Fe2.Id12;
         if E then
            Error(Id_Existent, A.Fe2.L1, A.Fe2.C1,
                  Cons_Nom(Tn, Idrecord));
            Esem := True;
         end if;
         Ct_Dregistre_Camp(A.Fe2.Id12, A.Fc2, A.Fd2, Ocup);

      elsif (A.Tipus = Dencapregistre) then
         Ct_Decregistre(A.Fe2, Idrecord, Ocup);
         Ct_Dregistre_Camp(Idrecord, A.Fc2, A.Fd2, Ocup);

      elsif (A.Tipus = Firecord) then
         Ct_Decregistre(A.F6, Idrecord, Ocup);
         Drecord := Cons(Ts, Idrecord);
         Drecord.Dt.Ocup := Ocup;
         Actualitza(Ts, Idrecord, Drecord);
      end if;

   end Ct_Decregistre;


   procedure Ct_Dregistre_Camp
     (Idrecord : in Id_Nom;
      Camp : in Pnode;
      Tcamp : in Pnode;
      Ocup: in out Despl) is

      Idtcamp : Id_Nom renames Tcamp.Id12;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames Camp.Id12;
      Desc_Camp : Descrip;
      E : Boolean;

   begin
      Dtcamp := Cons(Ts, Idtcamp);
      if (Dtcamp.Td /= Dtipus) then
         Error(Tipusinexistent, Camp.L1, Camp.C1,
               Cons_Nom(Tn, Idtcamp));
         Esem := True;
      else

         Desc_Camp := (Dcamp, Idtcamp, Ocup);
         Posacamp(Ts, Idrecord, Idcamp, Desc_Camp, E);
         Ocup := Ocup + Dtcamp.Dt.Ocup;
         if E then
            Error(IdCampRecordExistent, Camp.L1,
                  Camp.C1, Cons_Nom(Tn, Idcamp));
            Esem := True;
         end if;
      end if;

   end Ct_Dregistre_Camp;


   procedure Ct_Decsubrang
     (A : in Pnode) is

      Idsubrang : Id_Nom renames A.Fe5.Id12;
      Idtsubrang : Id_Nom renames A.Fc5.Id12;

      Rang_Esq : Pnode renames A.Fd5;
      Rang_Dret : Pnode renames A.Fid5;
      Tsub : Tipussubjacent;

      Tsesq : Tipussubjacent;
      Tsdret : Tipussubjacent;
      Idesq : Id_Nom;
      Iddret : Id_Nom;
      Valesq : Valor;
      Valdret : Valor;

      Tdecl : Descrip;
      Tdescrip_decl : Descrip;
      Tdescript_decl : Descriptipus;
      L, C : Natural := 0;
      E : Boolean;

   begin
      Tdecl := Cons(Ts, Idtsubrang);
      if(Tdecl.Td /= Dtipus) then
         Error(TipusInexistent, A.Fc5.L1, A.Fc5.C1,
               Cons_Nom(Tn, Idtsubrang));
         Esem := True;
      else
         --Miram el fill esquerra
         Ct_Constant(Rang_Esq, Tsesq, Idesq, L, C);
         Valesq := Rang_Esq.Val;

         --Miram el fill dret
         Ct_Constant(Rang_Dret, Tsdret, Iddret, L, C);
         Valdret := Rang_Dret.Val;

         -- Comparam els tipus
         if (Tsesq /= Tsdret) then
            Error(Tipussubdiferents, A.Fc5.L1, A.Fc5.C1,
                  ""&Tsesq'Img&"/"&Tsdret'Img);
            Esem := True;
         end if;

         Tsub := Tsesq;
         if (Tsub /= Tdecl.Dt.Tt) then
            Error(Tipussubdiferents, A.Fc5.L1, A.Fc5.C1,
                  ""&Tsub'Img&"/"&Tdecl.Dt.Tt'Img);
            Esem := True;
         end if;

         if (Valesq > Valdret) then
            Error(ValEsqMajorDret, A.Fc5.L1, A.Fc5.C1,
                  ""&Valesq'Img&" >"&Valdret'Img);
            Esem := True;
         end if;

         if (Valesq < Tdecl.Dt.Linf) then
            Error(ValEsqMenor, A.Fc5.L1, A.Fc5.C1,
                  Cons_Nom(Tn, Idtsubrang));
            Esem := True;
         end if;

         if (Valdret > Tdecl.Dt.Lsup) then
            Error(ValDretMajor, A.Fc5.L1, A.Fc5.C1,
                  Cons_Nom(Tn, Idtsubrang));
            Esem := True;
         end if;

         case Tsub is
            when Tsent =>
               Tdescript_Decl := (Tsent, 4, Valesq,
                                  Valdret);
            when Tscar =>
               Tdescript_Decl := (Tscar, 4, Valesq,
                                  Valdret);
            when others =>
               Put_Line("ERROR Ct_subrang: (Sub)Tipus no "&
                          "valid per a un subrang");
               Esem := True;
         end case;

         Tdescrip_Decl := (Dtipus, Tdescript_Decl);
         Posa(Ts, Idsubrang, Tdescrip_Decl, E);
         if E then
            Error(Id_Existent, A.Fe5.L1, A.Fe5.C1,
                  Cons_Nom(Tn, Idsubrang));
            Esem := True;
         end if;
      end if;

   end Ct_Decsubrang;


   procedure Ct_Expressio
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Tipus : Tipusnode renames A.Tipus;
      Tps : Tipussubjacent;
      Id : Id_Nom;

   begin

      case Tipus is
         when Expressio =>
            Ct_Expressioc(A, Tps, Id, L, C);
         when ExpressioUnaria =>
            Ct_Expressiou(A, Tps, Id, L, C);
         when Identificador =>
            Ct_Identificador(A, Tps, Id, L, C);
         when Const =>
            Ct_Constant(A, Tps, Id, L, C);
         when Fireferencia | Referencia =>
            Ct_Referencia_Var(A, Tps, Id);
         when others =>
            Put_Line("ERROR CT-exp: tipus expressio no "&
                       "trobat :S "&Tipus'Img);
            Esem := True;
      end case;
      T := Tps;
      Idtipus := Id;

   end Ct_Expressio;


   procedure Ct_Operand_Exp
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Tipus : Tipusnode renames A.Tipus;

   begin
      case Tipus is
         when Expressio =>
            Ct_Expressioc(A, T, Idtipus, L, C);
         when ExpressioUnaria =>
            Ct_Expressiou(A, T, Idtipus, L, C);
         when Referencia | Fireferencia=>
            Ct_Referencia_var(A, T, IdTipus);
         when Const =>
            Ct_Constant(A, T, Idtipus, L, C);
         when Identificador =>
            Ct_Identificador(A, T, Idtipus, L, C);

         when others =>
            Esem := True;
            null;
      end case;

   end Ct_Operand_Exp;


   procedure Ct_Expressioc
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Fesq : Pnode renames A.Fe3;
      Fdret : Pnode renames A.Fd3;
      Op : Operacio renames A.Op3;

      Tesq : Tipussubjacent;
      Idesq : Id_Nom;
      Tdret : Tipussubjacent;
      Iddret : Id_Nom;

   begin
      --Analitzam l'operand esquerra
      Ct_Operand_Exp(Fesq, Tesq, Idesq, L, C);
      --Analitzam l'operand dret
      Ct_Operand_Exp(Fdret, Tdret, Iddret, L, C);
      -- Comparam els tipus
      case Op is
         when Unio | Interseccio =>
            Ct_Exp_Logica(Tesq, Tdret, Idesq, Iddret, T,
                          Idtipus, L, C);
         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            Ct_Exp_Relacional(Tesq, Tdret, Idesq, Iddret,
                              T, Idtipus, L, C);
         when Suma | Resta | Mult | Div | Modul =>
            Ct_Exp_Aritmetica(Tesq, Tdret, Idesq, Iddret,
                              T, Idtipus, L, C);
         when others =>
            Esem := True;
            null;
      end case;

   end Ct_Expressioc;


   procedure Ct_Exp_Logica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

   begin
      if Tesq /= Tsbool then
         Error(Tsub_No_Bool, L, C, "esquerra");
         Esem := True;
      end if;

      if Tdret /= Tsbool then
         Error(Tsub_No_Bool, L, C, "dret");
         Esem := True;
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Error(Tops_Diferents, L, C, "");
            Esem := True;
         end if;
      end if;

      if Idesq = Id_Nul then
         Idtipus := Iddret;
      else
         Idtipus := Idesq;
      end if;

      T := Tsbool;

   end Ct_Exp_Logica;


   procedure Ct_Exp_Relacional
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

   begin
      if Tesq /= Tdret then
         Error(Tsubs_Diferents, L, C, "");
         Esem := True;
      end if;

      if Tesq > Tsent then
         Error(Tsub_No_Escalar, L, C, "esquerra");
         Esem := True;
      end if;

      if Tdret > Tsent then
         Error(Tsub_No_Escalar, L, C, "dret");
         Esem := True;
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Error(Tops_Diferents, L, C, "");
            Esem := True;
         end if;
      end if;

      T := Tsbool;
      Idtipus := Id_Nul;

   end Ct_Exp_Relacional;


   procedure Ct_Exp_Aritmetica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

   begin
      if Tesq /= Tsent then
         Error(Tsub_No_Sencer, L, C, "esquerra");
         Esem := True;
      end if;

      if Tdret /= Tsent then
         Error(Tsub_No_Sencer, L, C, "dret");
         Esem := True;
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Error(Tops_Diferents, L, C, "");
            Esem := True;
         end if;
      end if;

      T := Tsent;
      if Idesq = Id_Nul then
         Idtipus := Iddret;
      else
         Idtipus := Idesq;
      end if;

   end Ct_Exp_Aritmetica;


   procedure Ct_Expressiou
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Fdret : Pnode renames A.F4;
      Op : Operacio renames A.Op4;
      Tdret : Tipussubjacent;
      Iddret : Id_Nom;

   begin
      Ct_Operand_Exp(Fdret, Tdret, Iddret, L, C);
      case Op is
         when Resta =>
            Ct_Exp_Negacio(Tdret, Iddret, T, Idtipus,
                           L, C);
         when Negacio =>
            Ct_Exp_Neglogica(Tdret, Iddret, T, Idtipus,
                             L, C);
         when others =>
            Esem := True;
            null;
      end case;
   end Ct_Expressiou;


   procedure Ct_Exp_Negacio
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is
   begin
      if Ts /= Tsent then
         Error(Tsub_No_Sencer, L, C, "");
         Esem := True;
      end if;
      Idtipus := Id;
      T := Tsent;
   end Ct_Exp_Negacio;


   procedure Ct_Exp_Neglogica
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C: in out Natural) is
   begin
      if Ts /= Tsbool then
         Error(Tsub_No_Bool, L, C, "");
         Esem := True;
      end if;
      Idtipus := Id;
      T := Tsbool;
   end Ct_Exp_Neglogica;


   procedure Ct_Constant
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Tatr : Tipus_Atribut renames A.Tconst;
      Lin : Natural renames A.L2;
      Col : Natural renames A.C2;
      D : Descrip;

   begin

      Idtipus := Id_Nul;
      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when A_Lit_S =>
            T := Tsstr;
         when others =>
            Put_Line("ERROR CT-constant: tipus constant "&
                       "erroni");
            Esem := True;
      end case;
      L := Lin;
      C := Col;

   end Ct_Constant;


   procedure Ct_Identificador
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      L, C : in out Natural) is

      Id : Id_Nom renames A.Id12;
      D : Descrip;
      Desc : Tdescrip renames D.Td;
      Lin : Natural renames A.L1;
      Col : Natural renames A.C1;

      Carg : Cursor_Arg;

   begin

      D := Cons(Ts, Id);

      case Desc is
         when Dvar =>
            Idtipus := D.Tr;
            D := Cons(Ts, Idtipus);
            if (D.Td = Dtipus) then
               T := D.Dt.Tt;
            else
               Error(Tipus_No_Desc, L, C, D.Td'Img);
               Esem := True;
            end if;

         when Dconst =>
            Idtipus := D.Tc;
            D := Cons(Ts, Idtipus);
            if (D.Td = Dtipus) then
               T := D.Dt.Tt;
            else
               Error(Tipus_No_Desc, L, C, D.Td'Img);
               Esem := True;
            end if;

         when Dproc =>
            Carg := Primer_Arg(Ts, Id);
            if Arg_Valid(Carg) then
               T := Tsarr;
            else
               T := Tsnul;
            end if;
            Idtipus := Id;
         when Dargc =>
            Idtipus := D.Targ;
            D := Cons(Ts, Idtipus);
            if (D.Td = Dtipus) then
               T := D.Dt.Tt;
            else
               Error(Tipus_No_Desc, L, C, D.Td'Img);
               Esem := True;
            end if;

         when others =>
            Error(Id_No_Reconegut, L, C, Desc'Img);
            Esem := True;
            Idtipus := Id;
            T := tsnul;
      end case;

      L := Lin;
      C := Col;

   end Ct_Identificador;


   procedure Ct_Bloc
     (A : in Pnode) is

      D : Descrip;
      T : Tipussubjacent;
      Idbase : Id_Nom;
      Idtipus : Id_Nom;

      Tsexp : Tipussubjacent;
      Idexp : Id_Nom;
      Tsvar : Tipussubjacent;
      Idvar : Id_Nom;
      L, C : Natural := 0;

   begin
      case (A.Tipus) is
         when Bloc =>
            Ct_Bloc(A.Fe1);
            Ct_Bloc(A.Fd1);
         when Repeticio =>
            Ct_Srep(A);
         when Identificador =>

            Ct_Identificador(A, T, Idtipus, L, C);
            if T /= Tsnul then
               Error(Id_No_Cridaproc, L, C,
                     Cons_Nom(Tn, A.Id12));
               Esem := True;
            end if;

         when Fireferencia =>
            Ct_Referencia_Proc(A, T, Idbase);
         when condicionalS =>
            Ct_Sconds(A);
         when condicionalC =>
            Ct_Scondc(A);
         when Assignacio =>
            Ct_Referencia_Var(A.Fe1, Tsvar, Idvar);
            Ct_Expressio(A.Fd1, Tsexp, Idexp, L, C);
            if Tsvar /= Tsexp then
               Error(Assig_Tipus_Diferents, L, C, "");
               Esem := True;
            end if;
            if Idexp /= Id_Nul and Idexp /= Idvar then
               Error(Assig_Tipus_Diferents, L, C, "");
               Esem := True;
            end if;
         when others =>

            Esem := True;
      end case;
   end Ct_Bloc;


   procedure Ct_Srep
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Exp : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;
      L, C : Natural := 0;

   begin
      Ct_Expressio(Exp, Tsexp, Idtipus_Exp, L, C);
      if tsexp /= tsbool then
         Error(Exp_No_Bool, L, C, "bucle");
         Esem := True;
      end if;
      Ct_Bloc(Bloc);
   end Ct_Srep;


   procedure Ct_Sconds
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Cond : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;
      L, C : Natural := 0;

   begin
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp, L, C);
      if tsexp /= tsbool then
         Error(Exp_No_Bool, L, C, "condicional");
         Esem := True;
      end if;
      Ct_Bloc(Bloc);
   end Ct_Sconds;


   procedure Ct_Scondc
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Cond : Pnode renames A.Fe2;
      Bloc : Pnode renames A.fc2;
      Blocelse : Pnode renames A.fd2;
      L, C : Natural := 0;

   begin
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp, L, C);
      if tsexp /= tsbool then
         Error(Exp_No_Bool, L, C, "condicional compost");
         Esem := True;
      end if;
      Ct_Bloc(Bloc);
      Ct_Bloc(Blocelse);
   end Ct_Scondc;


   procedure Ct_Referencia_Proc
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      It_Arg : Cursor_Arg;
      L, C : Natural := 0;

   begin
      case Tipus is
         when Identificador =>
            Ct_Identificador(A, T, Id, L, C);
         when Referencia =>
            Error(Rec_No_Cridaproc, L, C, "");
            Esem := True;
         when Fireferencia =>
            Ct_Ref_Pri(A.F6, T, It_Arg);
            if Arg_Valid(It_Arg) then
               Error(Falta_Param_Proc, L, C, "");
               Esem := True;
            end if;
         when others =>
            Put_Line("ERROR CT-referencia: node "&
                       "no reconegut");
            Esem := True;
      end case;

   end Ct_Referencia_Proc;



   procedure Ct_Referencia_Var
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      Idtipus : Id_Nom;
      It_Idx : Cursor_Idx;
      D : Descrip;
      L, C : Natural := 0;

   begin
      case Tipus is
         when Identificador =>
            Ct_Identificador(A, T, Id, L, C);
            D := Cons(Ts, Id);
            if D.Td = Dproc then
               Error(Refvar_No_Proc, L, C, "");
               Esem := True;
            end if;
         when Referencia =>
            Ct_Ref_Rec(A, T, Id, Idtipus);
         when Fireferencia =>
            Ct_Ref_Pri(A.F6, T, Id, It_Idx);
            if Idx_Valid(It_Idx) then
               Error(Falta_Param_Array, L, C, "");
               Esem := True;
            end if;
            if T = Tsarr then
               D := Cons(Ts, Id);
               Id := D.Dt.Tcamp;
               D := Cons(Ts, Id);
               T := D.Dt.Tt;
            end if;
         when others =>
            Esem := True;
            null;
      end case;

   end Ct_Referencia_Var;


   procedure Ct_Ref_Rec
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom;
      Idbase : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Tesq : Tipussubjacent;
      Idbase_Esq : Id_Nom;
      Dcamp : Descrip;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames A.Fd1.Id12;
      L, C : Natural := 0;

   begin
      Ct_Referencia_Var(Fesq, Tesq, Idbase_Esq);
      if Tesq /= Tsrec then
         Error(Reccamp_No_Valid, L, C, "");
         Esem := True;
      end if;

      Dcamp := Conscamp(Ts, Idbase_Esq, Idcamp);
      if Dcamp.Td = Dnula then
         Error(Idrec_No_Valid, L, C, Cons_Nom(Tn, Idcamp));
         Esem := True;
      end if;

      Idtipus := Dcamp.Tcamp;
      Dtcamp := Cons(Ts, Dcamp.Tcamp);
      T := Dtcamp.Dt.Tt;
      Idbase := Idbase_Esq;

   end Ct_Ref_Rec;


   procedure Ct_Ref_Pri
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom;
      It_Idx : out Cursor_Idx) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;
      Tsub : Tipussubjacent;
      Idvar : Id_Nom;

      Tsref : Tipussubjacent;
      Idref : Id_Nom;

      Id_Cursor : Id_Nom;
      Dtipoarg : Descrip;
      Dbase : Descrip;
      L, C : Natural := 0;

   begin
      case Tipus is
         when Pri =>
            Ct_Ref_Pri(Fesq, T, Id, It_Idx);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            if not Idx_Valid(It_Idx) then
               Error(Sobren_Parametres, L, C, "");
               Esem := True;
            else
               Id_Cursor := Cons_Idx(Ts, It_Idx);
               Dtipoarg := Cons(Ts, Id_Cursor);
               if Idref = Id_Nul then
                  if Dtipoarg.Dt.Tt /= Tsref then
                     Error(Tparam_No_Coincident,
                           L, C, "");
                     Esem := True;
                  end if;
               elsif Idref /= Id_cursor then
                  Error(Tparam_No_Coincident, L, C,
                        Cons_Nom(Tn, Idref)&"/"&
                          Cons_Nom(Tn, Id_Cursor));
                  Esem := True;
               end if;
               It_Idx := Succ_Idx(Ts, It_Idx);
            end if;

         when Encappri =>
            Ct_Referencia_Var(Fesq, Tsub, Idvar);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            Dbase := Cons (Ts, Idvar);
            if Tsub = Tsarr then
               It_Idx := Primer_Idx(Ts, Idvar);
               if Idx_Valid(It_Idx) then
                  Id_Cursor := Cons_Idx(Ts, It_Idx);
                  Dtipoarg := Cons(Ts, Id_Cursor);
                  if Idref = Id_Nul then
                     if Dtipoarg.Dt.Tt /= Tsref then
                        Error(Tparam_No_Coincident, L, C,
                              "");
                        Esem := True;
                     end if;
                  elsif Idref /= Id_Cursor then
                     Error(Tparam_No_Coincident, L, C,
                           Cons_Nom(Tn, Idref)&"/"&
                             Cons_Nom(Tn, Id_Cursor));
                     Esem := True;
                  end if;
               end if;
            else
               Error(Tipus_No_Array, L, C, Tsub'Img);
               Esem := True;
            end if;
            It_Idx := Succ_Idx(Ts, It_Idx);
            T := Tsub;
            Id := Idvar;

         when others =>
            Esem := True;
            null;
      end case;

   end Ct_Ref_Pri;


   procedure Ct_Ref_Pri
     (A : in Pnode;
      T : out Tipussubjacent;
      It_Arg : out Cursor_Arg) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;
      Tsub : Tipussubjacent;
      Id : Id_Nom;

      Tsref : Tipussubjacent;
      Idref : Id_Nom;

      Id_Cursor : Id_Nom;
      Dparam : Descrip;
      Dtipoarg : Descrip;
      Dbase : Descrip;
      L, C : Natural := 0;

   begin
      case Tipus is
         when Pri => -- pri , E
            Ct_Ref_Pri(Fesq, T, It_Arg);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            if not Arg_Valid(It_Arg) then
               Error(Sobren_Parametres, L, C, "");
               Esem := True;
            else
               Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);
               if Idref = Id_Nul then
                  Dtipoarg := Cons(ts, Dparam.targ);
                  if Dtipoarg.Dt.Tt /= Tsref then
                     Error(Tparam_No_Coincident, L,
                           C, Dtipoarg.Dt.Tt'Img);
                     Esem := True;
                  end if;
               elsif Dparam.td = Dargc then
                  if Idref /= Dparam.targ then
                     Error(Tparam_No_Coincident, L, C,
                           Cons_Nom(Tn, Idref)&"/"&
                             Cons_Nom(Tn, Id_Cursor));
                     Esem := True;
                  end if;
               elsif Dparam.td = Dvar then
                  if Idref /= Dparam.Tr then
                     Error(Tparam_No_Coincident, L, C,
                           Cons_Nom(Tn, Idref)&"/"&
                             Cons_Nom(Tn, Id_Cursor));
                     Esem := True;
                  end if;
               end if;
               It_Arg := Succ_Arg(Ts, It_Arg);
            end if;

         when Encappri => -- r(E
            Ct_Referencia_Proc(Fesq, Tsub, Id);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            Dbase := Cons (Ts, Id);
            if Tsub = Tsarr and Dbase.td = Dproc then
               It_Arg := Primer_Arg(Ts, Id);
               if Arg_Valid(It_Arg) then
                  Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);

                  if Idref = Id_Nul then
                     if(Dtipoarg.Td /= Dnula) then
                        Dtipoarg := Cons(Ts, Dparam.Targ);
                        if Dtipoarg.Dt.Tt /= Tsref then
                           Error(Tparam_No_Coincident,
                                 L, C, "");
                           Esem := True;
                        end if;
                     end if;
                  elsif Dparam.Td = Dargc then
                     if Idref /= Dparam.Targ then
                        Error(Tparam_No_Coincident, L, C,
                              Cons_Nom(Tn, Idref)&"/"&
                                Cons_Nom(Tn, Id_Cursor));
                        Esem := True;
                     end if;
                  elsif Dparam.Td = Dvar then
                     if Idref /= Dparam.Tr then
                        Error(Tparam_No_Coincident, L, C,
                              Cons_Nom(Tn, Idref)&"/"&
                                Cons_Nom(Tn, Id_Cursor));
                        Esem := True;
                     end if;
                  end if;
               end if;
               It_Arg := Succ_Arg(Ts, It_Arg);
            else
               Error(Tproc_No_Param, L, C, Tsub'Img);
               Esem := True;
            end if;

            T := Tsub;
         when others =>
            Esem := True;
      end case;
   end Ct_Ref_Pri;

end Semantica.Ctipus;
