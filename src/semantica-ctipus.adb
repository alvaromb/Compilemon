with U_Lexica;

use U_Lexica;


package body Semantica.Ctipus is

   procedure mt_atom
     (l, c : in natural;
      a : out atribut) is
   begin
      a := (atom, l, c);
   end mt_atom;


   procedure mt_identificador
     (l, c : in natural;
      s : in string;
      a : out atribut) is
      id : id_nom;
   begin
      id := id_nul;
      posa_id(tn, id, s);
      a := (a_ident, l, c, id);
   end mt_identificador;


   procedure mt_string
     (l, c : in natural;
      s : in string;
      a : out atribut) is
      id : rang_tcar;
   begin
      posa_str(tn, id, s);
      a := (A_Lit_S, l, c, valor(id));
   end mt_string;


   procedure mt_caracter
     (l, c : in natural;
      car : in string;
      a : out atribut) is
   begin
      a := (A_Lit_C, l, c, valor(car'First+1));
   end mt_caracter;


   procedure mt_numero
     (l, c : in natural;
      s : in string;
      a : out atribut) is
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
      --Ie : Info_Etiq;
      --Ide : Num_Etiq;
      Iv : Info_Var;
      Idv : Num_Var;
   begin
      -- Constants inicials
      Posa_Id(Tn, Idn, "_zero");
      Iv := (Idn, Tp.Np, Integer'Size/8, 0, Tsent,
             False, True, 0);
      Posa(Tv, Iv, Zero);

      Posa_Id(Tn, Idn, "_menysu");
      Iv := (Idn, Tp.Np, Integer'Size/8, 0, Tsent,
             False, True, -1);
      Posa(Tv, Iv, Menysu);

      -- "Integer"
      Posa_Id(Tn, Idint, "integer");
      Dt := (Tsent, Integer'Size/8, Valor(Integer'First),
             Valor(Integer'Last));
      D := (Dtipus, Dt);
      Posa(Ts, Idint, D, E);

      -- "puti"
      Posa_Id(Tn, Idn, "puti");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_puti");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Extern,
             Tsent, True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idint);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;

      -- "geti"
      Posa_Id(Tn, Idn, "geti");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_geti");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Extern, Tsent,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idint);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;
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
      Iv := (Idt, Tp.Np, Integer'Size/8, 0, Tsbool, False,
             True, -1);
      Posa(Tv, Iv, Idv);
          Nv:=Nv+1;
      D := (Dconst, Idt, -1, Nv); --REPASAR ESTO!!!
      Posa(Ts, Idt, D, E);

      Posa_Id(Tn, Idf, "false");
      Iv.Id := Idf;
      Iv.Valconst := 0;
      Posa(Tv, Iv, Idv);
           Nv:=Nv+1;
      D := (Dconst, Idf, 0, Nv); --REPASAR ESTO!!!
      Posa(Ts, Idf, D, E);
   end Inicia_Boolea;


   procedure Inicia_Caracter is
      D : Descrip;
      Dt : Descriptipus;
      Idn, Idstring, Ida, Idchar : Id_Nom;
      E : Boolean;
      Ipr : Info_Proc;
--      Ide : Num_Etiq;
      Idpr : Num_Proc;
--      Ie : Info_Etiq;
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
      Dt := (Tsstr, 32*Integer'Size, Idchar, 0); --0 es la base
      D := (Dtipus, Dt);
      Posa(Ts, Idstring, D, E);

      -- putc
      Posa_Id(Tn, Idn, "putc");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_putc");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Extern, Tscar,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idchar);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;

      -- getc
      Posa_Id(Tn, Idn, "getc");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_getc");
      Iv := (Ida, Idpr, Integer'Size/8, Ipr.Ocup_Extern, Tscar,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idchar);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;

      -- puts
      Posa_Id(Tn, Idn, "puts");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_puts");
      Iv := (Ida, Idpr, 32*Integer'Size, Ipr.Ocup_Extern, Tsstr,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idstring);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;

      -- gets
      Posa_Id(Tn, Idn, "gets");
      Ipr := (Extern, Idn, 4);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);

      Posa_Id(Tn, Ida, "_arg_gets");
      Iv := (Ida, Idpr, 32*Integer'Size, Ipr.Ocup_Extern, Tsstr,
             True, False, 0);
      Posa(Tv, Iv, Idv);
      D := (Dargc, Idv, Idstring);
      Posa(Ts, Ida, D, E);
      Posa_Arg(Ts, Idn, Ida, D, E);
      Ipr.Ocup_Extern := Ipr.Ocup_Extern + Iv.Ocup;

      -- nova linea
      Posa_Id(Tn, Idn, "new_line");
      Ipr := (Extern, Idn, 0);
      Posa(Tp, Ipr, Idpr);
      Np := Np + 1;
      --  Ie := (Etiq_Proc, Idpr);
      --  Posa(Te, Ie, Ide);
      --  Ipr.Etiq := Ide;
      --  Modif_Descripcio(Tp, Idpr, Ipr);
      D := (Dproc, Idpr);
      Posa(Ts, Idn, D, E);
   end Inicia_Caracter;


   procedure Inicia_analisi(nomFitxer : in String) is
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
      d : Descrip;
      Idproc : Id_nom renames A.Fid5.Id12;
      ida : cursor_arg;
   begin
      --Entrabloc(Ts);
      Ct_Decprocediment(A);
      ida := primer_arg(Ts, Idproc);
      --Surtbloc(Ts);
      if (arg_valid(ida)) then
         Error(paramsPprincipal, cons_nom(tn, Idproc));
         Esem := True;
      end if;

          tts(proc_nul) := ts;
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
      Put_line("CT_Decprocediment");
      Ct_Encap(Encap, Id_Sup);
          np_propi := np;
      if Id_Inf /= Id_Sup then
         Error(idProgDiferents, A.Fid5.l1, A.Fid5.c1,
               cons_nom(tn, Id_Sup));
         Esem := True;
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;
      Ct_Bloc(Bloc);
          tts(np_propi) := ts;--afegit per la nova ts
      Surtbloc(Ts);

   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom) is

      Tproc : Descrip;
      E : Boolean;
      Idx_Arg : cursor_arg;
      ida : id_nom;
      dn : descrip;

   begin
      Put_line("CT_ENCAP");
      if A.Tipus = Pencap then

         Ct_Pencap(A, I);
         --Entrabloc(Ts);
         idx_Arg := primer_arg(ts, I);
         while arg_valid(idx_Arg) loop
            cons_arg(ts, idx_arg, ida, dn);
            posa(ts, ida, dn, e);
            if E then
               Error(enregArg, 3, 3, cons_nom(tn, ida));
               Esem := True;
            end if;
            idx_Arg := succ_arg(ts, idx_arg);
         end loop;
      else
         I := A.Id12;
         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, I, Tproc, E);
         Put_Line("posam un procediment");
         if E then
            Error(id_existent, A.l1, A.c1, cons_nom(tn, I));
            Esem := True;
         end if;
         Entrabloc(Ts);
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
      Put_line("CT_pencap: ");
      if Fesq.Tipus = Identificador then
         np := np + 1;
         Tproc := (Dproc, np);
         --entrabloc
         Posa(Ts, Fesq.Id12, Tproc, E);
         Put_Line("posam un procediment amb param");
         Entrabloc(Ts);
         if E then
            Error(id_existent, Fesq.l1, Fesq.c1,
                  cons_nom(tn, Fesq.Id12));
            Esem := True;
         end if;
         I := fesq.Id12;
      else
         Ct_Pencap(Fesq, I);
      end if;
      Ct_Param(Param, I);
   end Ct_Pencap;


   procedure Ct_Param
     (A : in Pnode;
      I : in Id_Nom) is

      idPar : id_nom renames A.Fe2.id12;
      mArg : mMode renames A.Fc2.M12;
      idTipus : id_nom renames A.Fd2.id12;
      d : Descrip;
      dArg : Descrip;
      E : boolean;

   begin
      Put_line("CT_Param");
      d := cons(ts, idtipus);
      if d.td /= dtipus then
         Error(tipusParam, A.Fd2.l1, A.Fd2.c1,
               cons_nom(tn, idtipus));
         Esem := True;
      end if;

      case mArg is
         when Surt | Entrasurt =>
            nv := nv + 1;
            dArg := (dvar, idtipus, nv);
         when Entra =>
            nv := nv + 1;
            dArg := (dargc, nv, idtipus);
         when others =>
            null;
      end case;

      Posa_Arg(ts, I, idPar, dArg, E);
      Put_Line("hem posat un posa_arg");
      if E then
         Error(enregArg, A.Fe2.l1, A.Fe2.c1,
               cons_nom(tn, idPar));
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
      Put_line("CT_DECLARACIONS");
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
            Put_Line("ERROR CT_Declaracions:(DEBUG)tipus "&
                       "declarat inexistent "&Tnode'Img);
            Esem := True;
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
      Put_line("CT_DECVAR");
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
      Put_line("CT_DECLSVAR");
      if Tnode = Identificador then
         Tdecl := Cons(Ts, A.Id12);
         if (Tdecl.Td /= Dtipus) then
            Error(tipusInexistent, A.l1, A.c1,
                  cons_nom(tn, A.Id12));
            Esem := True;
         end if;
         Idtipus := A.Id12;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(A.Fd1, Idtipus);
         Put_Line("CT_DECLSVAR:(DEBUG) diferents "&
                    "variables amb mateix tipus...");
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

      -- variables per la crida a expressio
      Tsubj : Tipussubjacent;
      Ids : Id_Nom;
      L, C : Natural := 0;

   begin

      Tdecl := Cons(Ts, Idtipus);
      if (Tdecl.Td /= Dtipus) then
         Error(tipusInexistent, A.Fc2.l1, A.Fc2.c1,
               cons_nom(tn, Idtipus));
         Esem := True;
      else
         Ct_Constant(Val, Tsubj, Ids, L, C);
         if (Tsubj /= Tdecl.Dt.Tt) then
            Error(tipusSubDiferents, A.Fc2.l1, A.Fc2.c1,
                  cons_nom(tn, Idtipus));
            Esem := True;
         end if;

         if (Tdecl.Dt.Tt > Tsent) then
            Error(Tsub_No_Escalar, A.Fc2.L1, A.Fc2.C1,
                  Cons_Nom(Tn, Idtipus));
            Esem := True;
         end if;

         if (Tsubj = Tsent or Tsubj = Tsbool or Tsubj = Tscar) then
            if (Val.Val < Tdecl.Dt.Linf) or
              (Val.Val > Tdecl.Dt.Lsup) then
               Error(rang_sobrepassat, A.Fe2.l1, A.Fe2.c1,
                     cons_nom(tn, Id));
               Esem := True;
            end if;
         end if;
          Nv:=Nv+1;
         Tconst := (dconst, IdTipus, Val.val,Nv);
         Posa(Ts, Id, Tconst, E);
         Put_Line("CT_CONST: (DEBUG)El valor de la "&
                    "constant es: "&Val.val'img);
         if E then
            Error(id_existent, A.Fe2.l1, A.Fe2.c1,
                  cons_nom(tn, Id));
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
         Error(tipusInexistent, A.Fd1.l1, A.Fd1.c1,
               cons_nom(tn, Idtipus_Array));
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
            Error(posaIdxArray, A.Fd1.l1, A.Fd1.c1,
                  cons_nom(tn, Idrang));
            Esem := True;
         else
            Di := Cons(Ts, Idrang);
            if Di.td = Dtipus then
               Ncomponents := Ncomponents +
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
            Error(tipusInexistent, Fesq.l1, Fesq.c1,
                  cons_nom(tn, Idtipus_Array));
            Esem := True;
            Ncomponents := 0;
         end if;

         Di := cons(ts, Idrang);
         if not (Di.td = dtipus and then
                   Di.dt.tt <= tsent) then
            Error(TipusIdxErroniArray, A.Fd1.l1, A.Fd1.c1,
                  cons_nom(tn, Idrang));
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
            Error(id_existent, A.Fe2.l1, A.Fe2.c1,
                  cons_nom(tn, Idrecord));
            Esem := True;
            --Ver si hacer un error nuevo o no (no es
            --una variable) es un tipo record
         end if;
         Ct_Dregistre_Camp(A.Fe2.Id12, A.Fc2, A.Fd2,Ocup);

      elsif (A.Tipus = Dencapregistre) then
         Ct_Decregistre(A.Fe2, Idrecord, Ocup);
         Ct_Dregistre_Camp(Idrecord, A.Fc2, A.Fd2,Ocup);

      elsif (A.Tipus = Firecord) then
         Ct_Decregistre(A.F6, Idrecord,Ocup);
         Drecord := cons(ts,Idrecord);
         Drecord.dt.ocup := ocup;
         actualitza(ts, Idrecord,Drecord);
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
         Error(tipusInexistent, Camp.l1, Camp.c1,
               cons_nom(tn, Idtcamp));
         Esem := True;
      else
         Desc_Camp := (Dcamp, Idtcamp, Nul_Despl);
         Posacamp(Ts, Idrecord, Idcamp, Desc_Camp, E);
         Ocup := Ocup + Dtcamp.dt.ocup;
         if E then
            Error(idCampRecordExistent, Camp.l1,
                  Camp.c1, cons_nom(tn, Idcamp));
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
         Error(tipusInexistent, A.Fc5.l1, A.Fc5.c1,
               cons_nom(tn, Idtsubrang));
         Esem := True;
      else
         --Miram el fill esquerra
         Ct_Constant(Rang_Esq, Tsesq, Idesq, L, C);
         Valesq := Rang_Esq.val;

         --Miram el fill dret
         Ct_Constant(Rang_Dret, Tsdret, Iddret, L, C);
         Valdret := Rang_Dret.val;

         -- Comparam els tipus
         if (Tsesq /= Tsdret) then
            Error(Tipussubdiferents, A.Fc5.L1, A.Fc5.C1,
                  ""&Tsesq'Img&"/"&Tsdret'Img);
            Esem := True;
         end if;

         Tsub := Tsesq;
         if (Tsub /= Tdecl.dt.tt) then
            Error(Tipussubdiferents, A.Fc5.L1, A.Fc5.C1,
                  ""&Tsub'Img&"/"&Tdecl.Dt.Tt'Img);
            Esem := True;
         end if;

         if (valesq > valdret) then
            Error(ValEsqMajorDret, A.Fc5.L1, A.Fc5.C1,
                  ""&Valesq'Img&" >"&Valdret'Img);
            Esem := True;
         end if;

         if (valesq < Tdecl.dt.Linf) then
            Error(ValEsqMenor, A.Fc5.L1, A.Fc5.C1,
                  Cons_Nom(Tn, Idtsubrang));
            Esem := True;
         end if;

         if (valdret > Tdecl.dt.Lsup) then
            Error(ValDretMajor, A.Fc5.L1, A.Fc5.C1,
                  Cons_Nom(Tn, Idtsubrang));
            Esem := True;
         end if;

         case Tsub is
            when tsent =>
               Tdescript_decl := (tsent, 4, valesq,
                                  valdret);
            when tscar =>
               Tdescript_decl := (tscar, 4, valesq,
                                  valdret);
            when others =>
               Put_line("ERROR Ct_subrang: (Sub)Tipus no "&
                          "valid per a un subrang");
               Esem := True;
         end case;

         Tdescrip_decl := (Dtipus, Tdescript_decl);
         Posa(ts, Idsubrang, Tdescrip_decl, E);
         if E then
            Error(id_existent, A.Fe5.l1, A.Fe5.c1,
                  cons_nom(tn, Idsubrang));
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
      Put_line("CT_EXP: "&Tipus'img );
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
            Ct_Referencia_Var(A, Tps, Id); --falta L i C
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
            --falta L i C
            Ct_Referencia_var(A, T, IdTipus);
            Put_Line("refe");
         when Const =>
            Ct_Constant(A, T, Idtipus, L, C);
            Put_line("CT_EXP_COMP const: "&Idtipus'img);
         when Identificador =>
            Ct_Identificador(A, T, Idtipus, L, C);
            Put_line("CT_EXP_COMP Id: "&Idtipus'img);
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
      Put_line("CT_EXPRESSIOC");
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
      Put_line("CT_EXPRESSIOU");
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

      Put_Line("DRT: ts: "&T'Img&" id: "&Idtipus'Img);

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
      Put_line("CT_CONSTANT");
      Idtipus := Id_Nul;
      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when A_Lit_S =>
            T := Tsarr;
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
      put_line(" CT_ID : "&Id'img);
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

         when others =>
            Error(Id_No_Reconegut, L, C, Desc'Img);
            Esem := True;
            Idtipus := Id;
            T := tsnul;

      end case;
      L := Lin;
      C := Col;

      Put_line("ct_id: Tipus: "&Idtipus'img);

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
            Put_Line("CT_Bloc : IDENTIFICADOR");
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
            Put_Line("blocothers"&A.Tipus'img);
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
               --falta L i C
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
            Put_Line("ERROR CT-referencia: node no "&
                       "reconegut");
            Esem := True;
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
         Error(Reccamp_No_Valid, L, C, ""); --falta L i C
         Esem := True;
      end if;

      Dcamp := Conscamp(Ts, Idbase_Esq, Idcamp);
      if Dcamp.Td = Dnula then
         --comprovar nom
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
            Put_Line("CT-ref_pri: pri");
            Ct_Ref_Pri(Fesq, T, Id, It_Idx);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            if not Idx_Valid(It_Idx) then
               Error(Sobren_Parametres, L, C, "");
               Esem := True;
            else
               Id_Cursor := Cons_Idx(Ts, It_Idx);
               Dtipoarg := Cons(ts, Id_Cursor);
               if Idref = Id_Nul then
                  if Dtipoarg.dt.tt /= Tsref then
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
            Put_Line("CT-ref_pri: encappri");
            Ct_Referencia_Var(Fesq, Tsub, Idvar);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            Dbase := Cons (ts, Idvar);
            if Tsub = Tsarr then
               It_Idx := Primer_Idx(Ts, Idvar);
               if Idx_Valid(It_Idx) then
                  Id_Cursor := Cons_Idx(Ts, It_Idx);
                  Dtipoarg := Cons(Ts, Id_Cursor);
                  if Idref = Id_Nul then
                     if Dtipoarg.dt.tt /= Tsref then
                        Error(Tparam_No_Coincident, L, C, "");
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
            Put_Line("ERROR CT-ref_pri: tipus no "&
                       "reconegut");
            Esem := True;
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
         when Pri =>
            Put_Line("CT-ref_pri: pri");
            Ct_Ref_Pri(Fesq, T, It_Arg);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);

            if not Arg_Valid(It_Arg) then
               Error(Sobren_Parametres, L, C, "");
               Esem := True;
            else
               Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);
               if Idref = Id_Nul then
                  Dtipoarg := Cons(ts, Dparam.targ);
                  if Dtipoarg.dt.tt /= Tsref then
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
                  if Idref /= Dparam.tr then
                     Error(Tparam_No_Coincident, L, C,
                           Cons_Nom(Tn, Idref)&"/"&
                             Cons_Nom(Tn, Id_Cursor));
                     Esem := True;
                  end if;
               end if;
               It_Arg := succ_arg(ts, It_Arg);
            end if;

         when Encappri =>
            Put_Line("CT-ref_pri: encappri");
            Ct_Referencia_Proc(Fesq, Tsub, Id);
            Ct_Expressio(Fdret, Tsref, Idref, L, C);
            Dbase := Cons (ts, id);
            if Tsub = Tsarr and Dbase.td = Dproc then
               It_Arg := Primer_Arg(Ts, Id);
               if Arg_Valid(It_Arg) then
                  Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);
                  if Idref = Id_Nul then
                     Dtipoarg := Cons(ts, Dparam.targ);
                     if Dtipoarg.dt.tt /= Tsref then
                        Error(Tparam_No_Coincident,
                              L, C, "");
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
                     if Idref /= Dparam.tr then
                        Error(Tparam_No_Coincident, L, C,
                              Cons_Nom(Tn, Idref)&"/"&
                                Cons_Nom(Tn, Id_Cursor));
                        Esem := True;
                     end if;
                  end if;
               end if;
            else
               Error(Tproc_No_Param, L, C, Tsub'Img);
               Esem := True;
            end if;
            It_Arg := succ_arg(ts, It_Arg);
            T := Tsub;
         when others =>
            Put_Line("ERROR CT-ref_pri: tipus no "&
                       "reconegut");
            Esem := True;
      end case;
   end Ct_Ref_Pri;


end Semantica.Ctipus;
