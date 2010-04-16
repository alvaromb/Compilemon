with U_Lexica;

use U_Lexica;


package body Decls.Ctipus is

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
       a := (A_Lit_N, l, c, valor(Integer'value(s)));
   end mt_numero;


   -- Taula de simbols
   procedure Inicia_Enter is
      D : Descrip;
      Dt : Descriptipus;
      Idn : Id_Nom;
      E : Boolean;
   begin
      posa_id(tn, idn, "integer");
      dt := (tsent, 4, valor(integer'first), valor(integer'last));
      d := (dtipus,dt);
      posa(ts, idn, d, e);

   end Inicia_Enter;


   procedure Inicia_Boolea is
      D : Descrip;
      Dt : Descriptipus;
      Idb, Idt, Idf : Id_Nom;
      E : Boolean;
   begin
      Posa_Id(Tn, Idb, "boolean");
      Dt := (Tsbool, 4, -1, 0);
      D := (Dtipus, Dt);
      Posa(Ts, Idb, D, E);

      Posa_Id(Tn, Idt, "true");
      Nv := Nv + 1;
      --D := (Dconst, Idb, -1, Nv);
          D := (Dconst, Idb, -1);
      Posa(Ts, Idt, D, E);

      Posa_Id(Tn, Idf, "false");
      Nv := Nv + 1;
      --D := (Dconst, Idb, 0, Nv);
      D := (Dconst, Idb, 0);
      Posa(Ts, Idf, D, E);
   end Inicia_Boolea;


   procedure Inicia_analisi is
   begin
      nv := 0;
      np := 0;
      Tbuida(Tn);
      Tbuida(Ts);
      Inicia_Enter;
      Inicia_Boolea;
   end Inicia_analisi;


   -- Procediments interns
   procedure Posa_Idvar
     (Idvar : in Id_Nom;
      Idtipus : in Id_Nom;
      E : out Boolean) is
      Tassig : Descrip;
   begin
      nv := nv + 1;
      Tassig := (Dvar, Idtipus, Nv);
      Posa(Ts, Idvar, Tassig, E);
      if E then
         Put_Line("ERROR CT-posaidvar: l'identificador ja existeix");
      end if;
   end Posa_Idvar;


   -- Comprovacio de tipus
   procedure Ct_Programa
     (A : in Pnode) is
        d : Descrip;
                Idproc : Id_nom renames A.Fd1.Fid5.Id12;
        ida : cursor_arg;
   begin
      Ct_M1;
      Ct_Decprocediment(A.Fd1);
      ida := primer_arg(ts,Idproc);
          if (arg_valid(ida)) then

                put_line("Ct_Programa: El procediment principal no pot tenir params");

          end if;

   end Ct_Programa;


   procedure Ct_M1 is
   begin
      put_line("M1 necessari per generacio de codi 3@");
   end Ct_M1;


   procedure Ct_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Inf : Id_Nom renames A.Fid5.Id12;
      Id_Sup : Id_Nom;
      Tdecls : Tipusnode;

   begin
      Put_line("CT_Decprocediment");
      Ct_Encap(Encap, Id_Sup);

      if Id_Inf /= Id_Sup then
         Put_Line("ERROR CT_Decprocediment: identificadors de "&
                    "procediment diferents");
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;
      Ct_Bloc(Bloc);
      Surtbloc(Ts);
   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom) is

      Tproc : Descrip;
      E : Boolean;
          idx_Arg : cursor_arg;
          ida : id_nom;
          dn : descrip;

   begin
      Put_line("CT_ENCAP");
      if A.Tipus = Pencap then

         Ct_Pencap(A, I);
                 entrabloc(Ts);
                 idx_Arg := primer_arg(ts, I);
                 while arg_valid(idx_Arg) loop

                        cons_arg(ts,idx_arg, ida,dn);
                    posa(ts, ida,dn,e);
                        if E then
                                Put_Line("ERROR CT_ENCAP: Error compilador :impossible posar param");
                        end if;
                    idx_Arg := succ_arg(ts, idx_arg);
                end loop;

      else

         I := A.Id12;
         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, I, Tproc, E);
                 if E then
                        Put_Line("ERROR CT_ENCAP: Error el id del procediment ja existeix");
                 end if;
                 Entrabloc(Ts);

      end if;

   end Ct_Encap;


   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      --Id : Id_Nom renames A.Fe1.Id12;
      Tproc : Descrip;
      E : Boolean;

   begin
      Put_line("CT_pencap: ");

      if Fesq.Tipus = Identificador then

         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, A.Fe1.Id12, Tproc, E);
         if E then
                        Put_Line("ERROR CT_ENCAP: Error el id del procediment ja existeix");
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
         Put_Line("ERROR CT_Param: El tipus del parametre no es correcte"&d.td'img);
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

      posa_arg(ts, I, idPar, dArg, E);
      if E then
         Put_Line("ERROR CT_Param: Error al enregistrar l'argument");
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
         when Dvariable   => Ct_Decvar(Decl);
         when Dconstant   => Ct_Decconst(Decl);
         when Dcoleccio   => Ct_Deccol(Decl);
         when Dregistre | Dencapregistre
             |Firecord => Ocup := 0;
                                              Ct_Decregistre(Decl, Idrec,Ocup);
         when Dsubrang    => Ct_Decsubrang(Decl);
         when Procediment => Ct_Decprocediment(Decl);
         when others => Put_Line("ERROR CT_Declaracions:(DEBUG)tipus declarat inexistent "&Tnode'img);
      end case;

   end Ct_Declaracions;


   procedure Ct_Decvar
     (A : in Pnode) is

      Dvariable : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      Tassig : Descrip;
      Idtipus : Id_nom;
      E : Boolean;

   begin
      Put_line("CT_DECVAR");
      Ct_Declsvar(Dvariable, Idtipus);
      Posa_Idvar(Id, Idtipus, E);

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
                         Put_Line("ERROR CT_DECLSVAR: el tipus no existeix");
         end if;

                Idtipus := A.Id12;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(A.Fd1, Idtipus);
         Put_Line("CT_DECLSVAR:(DEBUG) diferents variables amb mateix tipus...");
         Posa_Idvar(A.Fe1.Id12, Idtipus, E);
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

   begin

      Tdecl := Cons(Ts, Idtipus);
      if (Tdecl.Td /= Dtipus) then
            Put_Line("ERROR CT-const: No es d'un tipus o el tipus no existeix");
          end if;
      Ct_Constant(Val, Tsubj, Ids);
      if (Tsubj /= Tdecl.Dt.Tt) then
            Put_Line("ERROR CT-const: tipus subj diferent");
          end if;

      if (Val.Val < Tdecl.Dt.Linf) or (Val.Val > Tdecl.Dt.Lsup) then
               Put_Line("ERROR CT-const: el valor de la constant "&
                       "surt del rang");
      end if;

      Tconst := (dconst, IdTipus, Val.val);
      Posa(Ts, Id, Tconst, E);
      Put_Line("CT_CONST: (DEBUG)El valor de la constant es: "&Val.val'img);
      if E then
                Put_Line("ERROR-CT-const: var ja existent");
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
         Put_Line("ERROR-CT-deccol: el tipus de l'array no existeix");
      end if;

      Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray, Ncomponents);
      Darray := Cons(Ts, Idarray); --Falta control d'errors?
      Darray.Dt.Tcamp := Idtipus_Array;
      Darray.Dt.Ocup := Ncomponents * Dtarray.Dt.Ocup;
      Actualitza(Ts, Idarray, Darray);
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
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray, Ncomponents);
         Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posa_idx");
         end if;

         Di := Cons(Ts, Idrang);
         Ncomponents := Ncomponents + Despl(Di.Dt.Lsup - Di.Dt.Linf + 1);

      elsif (A.Tipus = Pdimcoleccio) then
         Dtarray := (Tsarr, 0, Idtipus_Array);
         Darray := (Dtipus, Dtarray);
         Idarray := Fesq.Id12;

         Posa(Ts, Idarray, Darray, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'array");
         end if;


         Di := cons(ts, Idrang);
         if not (Di.td = dtipus and then Di.dt.tt <= tsent) then
            Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'index de l'array");
         end if;

         Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pdimcoleccio: error al posa_idx, error "&
                       "del compilador, array no creat, idarr: "&
                       Idarray'Img);
         end if;

         Ncomponents := Despl(Di.Dt.Lsup - Di.Dt.Linf + 1);
      end if;
   end Ct_Pcoleccio;


   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom;
          Ocup: in out despl) is

     -- Tipus : Tipusnode renames A.Tipus;
      Drecord : Descrip;
      Dtrecord : Descriptipus;
     -- Camp : Pnode renames A.Fc2;
     -- Tcamp : Pnode renames A.Fd2;
      E : Boolean;

   begin

      if (A.Tipus = Dregistre) then
         Dtrecord := (Tsrec, 0);
         Drecord := (Dtipus, Dtrecord);
         Posa(Ts, A.Fe2.Id12, Drecord, E);
         Idrecord := A.Fe2.Id12;
         if E then
            Put_Line("ERROR CT-registre: el id del record "&
                       "ja existeix");
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

         Put_Line("ERROR CT-dregistre-camp: el tipus del camp no "&
                    "existeix o no es d'un tipus");
      end if;
      --desplnul provisional
      Desc_Camp := (Dcamp, Idtcamp, Nul_Despl);
      Posacamp(Ts, Idrecord, Idcamp, Desc_Camp, E);

          Ocup := Ocup + Dtcamp.dt.ocup;

      if E then
         Put_Line("ERROR CT-dregistre-camp: ja existeix un camp amb "&
                    "el mateix id en aquest record");
      end if;
   end Ct_Dregistre_Camp;


   procedure Ct_Decsubrang
     (A : in Pnode) is

      Idsubrang : Id_Nom renames A.Fe5.Id12;
      Idtsubrang : Id_Nom renames A.Fc5.Id12;

      --Suposarem que limit nomes pot ser 'const'
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

      E : Boolean;

   begin

      Tdecl := Cons(Ts, Idtsubrang);
      --Miram si el tipus sobre el qual es vol crear

      if(Tdecl.Td /= Dtipus) then

                          Put_Line("ERROR CT-decsubrang: tipus 'new x' x no existeix: ");
          end if;

      --Miram el fill esquerra
          Ct_Constant(Rang_Esq, Tsesq, Idesq);
          Valesq := Rang_Esq.val;
      --Miram el fill dret
          Ct_Constant(Rang_Dret, Tsdret, Iddret);
          Valdret := Rang_Dret.val;

      -- Comparam els tipus
      if (Tsesq /= Tsdret) then
                Put_line("ERROR Ct_subrang: Tipus subjacents diferents dels valors del rang");
      end if;

          Tsub := Tsesq;

      if (Tsub /= Tdecl.dt.tt) then
           Put_line("ERROR Ct_subrang: Tipus subjacents diferents del tipus del subrang");
          end if;

      if (valesq > valdret) then

                Put_line("ERROR Ct_subrang: El valor esquerra no pot ser major al de la dreta");
          end if;

         if (valesq < Tdecl.dt.linf ) then
            Put_line("ERROR Ct_subrang: Valor esquerra inferior al permes");
         end if;

        if (valdret > Tdecl.dt.lsup ) then
           Put_line("ERROR Ct_subrang: Valor dret superior al permes");
        end if;

        case Tsub is

                when tsent =>  Tdescript_decl := (tsent, 4, valesq, valdret);
                when tscar =>  Tdescript_decl := (tscar, 4, valesq, valdret);
            when others => Put_line("ERROR Ct_subrang: (Sub)Tipus no valid per a un subrang");

        end case;

    Tdescrip_decl := (Dtipus, Tdescript_decl);
    Posa(ts, Idsubrang, Tdescrip_decl, E);

     if E then
        Put_Line("ERROR CT-decsubrang: el tipus "&
                 "que intentes declarar ja existeix");
     end if;

   end Ct_Decsubrang;


   procedure Ct_Expressio
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;

      Tps : Tipussubjacent;
      Id : Id_Nom;

   begin
      Put_line("CT_EXP: "&Tipus'img );

      case Tipus is
         when Expressio =>
            Ct_Expressioc(A, Tps, Id);
         when ExpressioUnaria =>
            Ct_Expressiou(A, Tps, Id);
         when Identificador =>

            Ct_Identificador(A, Tps, Id);
         when Const =>
            Ct_Constant(A, Tps, Id);
         when Fireferencia | Referencia =>
            Ct_Referencia_Var(A, Tps, Id);
         when others =>
            Put_Line("ERROR CT-exp: tipus expressio no trobat :S "&
                       Tipus'Img);
      end case;

      T := Tps;
      Idtipus := Id;

   end Ct_Expressio;


   procedure Ct_Operand_Exp
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;

   begin
      case Tipus is
         when Expressio =>
            Ct_Expressioc(A, T, Idtipus);
         when ExpressioUnaria =>
            Ct_Expressiou(A, T, Idtipus);
         when Referencia | Fireferencia=>
            Ct_Referencia_var(A, T, IdTipus);
            Put_Line("refe");
         when Const =>
            Ct_Constant(A, T, Idtipus);
            Put_line("CT_EXP_COMP const: "&Idtipus'img);
         when Identificador =>
            Ct_Identificador(A, T, Idtipus);
            Put_line("CT_EXP_COMP Id: "&Idtipus'img);
         when others =>
            null;
      end case;
   end Ct_Operand_Exp;


   procedure Ct_Expressioc
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

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
      Ct_Operand_Exp(Fesq, Tesq, Idesq);

      --Analitzam l'operand dret
      Ct_Operand_Exp(Fdret, Tdret, Iddret);

      -- Comparam els tipus
      case Op is
         when Unio | Interseccio =>
            Ct_Exp_Logica(Tesq, Tdret, Idesq, Iddret, T, Idtipus);

         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            Ct_Exp_Relacional(Tesq, Tdret, Idesq, Iddret, T, Idtipus);

         when Suma | Resta | Mult | Div | Modul =>
            Ct_Exp_Aritmetica(Tesq, Tdret, Idesq, Iddret, T, Idtipus);

         when others =>
            null;
      end case;

      Put_Line("ESQ: ts: "&Tesq'Img&" id: "&Idesq'Img);
      Put_Line("DRT: ts: "&Tdret'Img&" id: "&Iddret'Img);

   end Ct_Expressioc;


   procedure Ct_Exp_Logica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

   begin
      if Tesq /= Tsbool then
         Put_Line("ERROR CT-exp_logica: l'operand esq no es del ts boolea");
      end if;

      if Tdret /= Tsbool then
         Put_Line("ERROR CT-exp_logica: l'operand dret no es del ts boolea");
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Put_Line("ERROR CT-exp_logica: els tipus dels operands son"&
                       " diferents");
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
      Idtipus : out Id_Nom) is

   begin
      if Tesq /= Tdret then
         Put_Line("ERROR CT-exp_relacional: els tipus subj dels operands"&
                    " son diferents");
      end if;

      if Tesq > Tsent then
         Put_Line("ERROR CT-exp_relacional: el tipus esq no es escalar");
      end if;

      if Tdret > Tsent then
         Put_Line("ERROR CT-exp_relacional: el tipus dret no es escalar");
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Put_Line("ERROR CT-exp_relacional: els tipus dels operands "&
                       "son diferents");
         end if;
      end if;

      T := Tsbool;
      Idtipus := Id_Nul;

   end Ct_Exp_Relacional;


   procedure Ct_Exp_Aritmetica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

   begin
      if Tesq /= Tsent then
         Put_Line("ERROR CT-exp_aritmetica: l'operand esq no es sencer");
      end if;

      if Tdret /= Tsent then
         Put_Line("ERROR CT-exp_aritmetica: l'operand dret no es sencer");
      end if;

      if Idesq /= Id_Nul and Iddret /= Id_Nul then
         if Idesq /= Iddret then
            Put_Line("ERROR CT-exp_aritmetica: els tipus dels operands son"&
                       " diferents");
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
      Idtipus : out Id_Nom) is

      Fdret : Pnode renames A.F4;
      Op : Operacio renames A.Op4;

      Tdret : Tipussubjacent;
      Iddret : Id_Nom;

   begin
      Put_line("CT_EXPRESSIOU");
      Ct_Operand_Exp(Fdret, Tdret, Iddret);

      case Op is
         when Resta =>
            Ct_Exp_Negacio(Tdret, Iddret, T, Idtipus);
         when Negacio =>
            Ct_Exp_Neglogica(Tdret, Iddret, T, Idtipus);
         when others =>
            null;
      end case;

      Put_Line("DRT: ts: "&Tdret'Img&" id: "&Iddret'Img);

   end Ct_Expressiou;


   procedure Ct_Exp_Negacio
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is
   begin
      if Ts /= Tsent then
         Put_Line("ERROR CT-exp_negacio: l'operand ha de ser sencer");
      end if;

      Idtipus := Id;
      T := Ts;
   end Ct_Exp_Negacio;


   procedure Ct_Exp_Neglogica
     (Ts : in Tipussubjacent;
      Id : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is
   begin
      if Ts /= Tsbool then
         Put_Line("ERROR CT-exp_neglogica: l'operand ha de ser boolea");
      end if;

      Idtipus := Id;
      T := Ts;
   end Ct_Exp_Neglogica;


   procedure Ct_Constant
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

      Tatr : Tipus_Atribut renames A.Tconst;
      D : Descrip;

   begin
      Put_line("CT_CONSTANT");
      Idtipus := Id_Nul;
      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when others =>
            Put_Line("ERROR CT-constant: tipus constant erroni");
      end case;

   end Ct_Constant;


   procedure Ct_Identificador
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

      Id : Id_Nom renames A.Id12;
      D : Descrip;
      Desc : Tdescrip renames D.Td;

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
               Put_Line("ERROR CT-identificador: el tipus no es"&
                          " una descripcio de tipus "&D.Td'img);
            end if;

         when Dconst =>
            Idtipus := D.Tc;
            D := Cons(Ts, Idtipus);
            if (D.Td = Dtipus) then
               T := D.Dt.Tt;
            else
               Put_Line("ERROR CT-identificador: el tipus no es"&
                          " una descripcio de tipus "&D.Td'img);
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
            Put_Line("ERROR CT: l'identificador no es reconegut "&Desc'img);
      end case;

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

   begin
      case (A.Tipus) is
         when Bloc =>
            Ct_Bloc(A.Fe1);
            Ct_Bloc(A.Fd1);
         when Repeticio =>
            Ct_Srep(A);
         when Identificador =>
            Put_Line("CT_Bloc : IDENTIFICADOR");
            Ct_Identificador(A, T, Idtipus);
            if T /= Tsnul then
               Put_Line("ERROR CT-bloc: un identificador nomes pot "&
                          "representar una crida a procediment sense "&
                          "parametres.");
            end if;

         when Fireferencia =>
            Ct_Referencia_Proc(A, T, Idbase);

         when condicionalS =>
            Ct_Sconds(A);
         when condicionalC =>
            Ct_Scondc(A);
         when Assignacio =>
            Ct_Referencia_Var(A.Fe1, Tsvar, Idvar);
            Ct_Expressio(A.Fd1, Tsexp, Idexp);
            if Tsvar /= Tsexp then
               Put_Line("ERROR CT-bloc: l'assignacio es de tipus diferents");
               Put_Line("ERROR CT-bloc: tsvar: "&Tsvar'Img&"/tsexp: "&
                          Tsexp'Img);
            end if;
            if Idexp /= Id_Nul and Idexp /= Idvar then
               Put_Line("ERROR CT-bloc: l'assignacio no es del tipus de la "&
                          "variable.");
               Put_Line("ERROR CT-bloc: idexp: "&Idexp'Img&"/idvar: "&
                          Idvar'Img);
            end if;
         when others =>
            Put_Line("blocothers"&A.Tipus'img);
      end case;
   end Ct_Bloc;


   procedure Ct_Srep
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Exp : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

   begin
      Ct_Expressio(Exp, Tsexp, Idtipus_Exp);
      if tsexp /= tsbool then
         Put_Line("Ct : La expresion para un bucle debe ser un "&
                    " booleano");
      end if;
      Ct_Bloc(Bloc);
   end Ct_Srep;


   procedure Ct_Sconds
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Cond : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

   begin
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp);
      if tsexp /= tsbool then
         Put_Line("Ct : La expresion para un condicional "&
                    "debe ser un booleano");
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

   begin
      Put_Line("Ct_CondCompost : Entram dins un condicional compost");
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp);
      if tsexp /= tsbool then
         Put_Line("Ct : La expresion para un condicional compuesto "&
                    "debe ser un booleano");
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

   begin
      case Tipus is
         when Identificador =>
            Ct_Identificador(A, T, Id);
         when Referencia =>
            --Ct_Ref_Rec(A, T, Id, Idtipus); --alerta amb el q tornam
            Put_Line("ERROR CT-referencia: no pots utilitzar un record com "&
                       "una crida a procediment");
         when Fireferencia =>
            Ct_Ref_Pri(A.F6, T, It_Arg);
            if Arg_Valid(It_Arg) then
               Put_Line("ERROR CT-referencia: falten parametres al "&
                          "procediment");
            end if;
         when others =>
            Put_Line("ERROR CT-referencia: node no reconegut");
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

   begin
      case Tipus is
         when Identificador =>
            Ct_Identificador(A, T, Id);
            D := Cons(Ts, Id);
            if D.Td = Dproc then
               Put_Line("ERROR CT-referencia: no pot esser un procediment "&
                          "idiota!");
            end if;
         when Referencia =>
            Ct_Ref_Rec(A, T, Id, Idtipus); --alerta amb el q tornam
         when Fireferencia =>
            Ct_Ref_Pri(A.F6, T, Id, It_Idx);
            if Idx_Valid(It_Idx) then
               Put_Line("ERROR CT-referencia: falten parametres a "&
                          "l'array.");
            end if;
			 Put_Line("(DEBUG)laaaaaaaaaaaaaaaaaa : "&ID'img&" , "&T'img);
            if T = Tsarr then
               D := Cons(Ts, Id);
               Id := D.Dt.Tcamp;
               D := Cons(Ts, Id);
               T := D.Dt.Tt;
				    
            end if;
         when others =>
            Put_Line("ERROR CT-referencia: node no reconegut");
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

   begin
      Ct_Referencia_Var(Fesq, Tesq, Idbase_Esq);

      if Tesq /= Tsrec then
         Put_Line("ERROR CT-ref_rec: camp no valid en l'acces a "&
                    "referencia");
      end if;

      Dcamp := Conscamp(Ts, Idbase_Esq, Idcamp);
      if Dcamp.Td = Dnula then
         Put_Line("ERROR CT-ref_rec: id no es un nom de camp "&
                    "valid per al tipus R");
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

   begin
      case Tipus is
         when Pri =>
            Put_Line("CT-ref_pri: pri");
            Ct_Ref_Pri(Fesq, T, Id, It_Idx);
            Ct_Expressio(Fdret, Tsref, Idref);

            if not Idx_Valid(It_Idx) then
               Put_Line("ERROR CT-ref_pri: sobren parametres");
            else
               Id_Cursor := Cons_Idx(Ts, It_Idx);
               Dtipoarg := Cons(ts, Id_Cursor);

               if Idref = Id_Nul then
                  if Dtipoarg.dt.tt /= Tsref then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no coincideix amb el tipus demanat");
                  end if;
               elsif Idref /= Id_cursor then
                  Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                             "no es correcte "&cons_nom(Tn, Idref)&" , "&
                             Cons_nom(Tn, Id_cursor));
               end if;
               It_Idx := Succ_Idx(Ts, It_Idx);
            end if;

         when Encappri =>
            Put_Line("CT-ref_pri: encappri");
            Ct_Referencia_Var(Fesq, Tsub, Idvar);
            Ct_Expressio(Fdret, Tsref, Idref);
            Dbase := Cons (ts, Idvar);
            if Tsub = Tsarr then
               It_Idx := Primer_Idx(Ts, Idvar);
               if Idx_Valid(It_Idx) then
                  Id_Cursor := Cons_Idx(Ts, It_Idx);
                  Dtipoarg := Cons(Ts, Id_Cursor);
                  if Idref = Id_Nul then
                     if Dtipoarg.dt.tt /= Tsref then
                        Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                   "no coincideix amb el tipus demanat");
                     end if;
                  elsif Idref /= Id_Cursor then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no es correcte "&cons_nom(tn, Idref)&
                                " , "&Cons_nom(tn,Id_cursor));
                  end if;
               end if;
            else
               Put_Line("ERROR CT-ref_pri: error en el tipus, no es "&
                          "un array "&Tsub'img);
            end if;
            It_Idx := Succ_Idx(Ts, It_Idx);
            T := Tsub;
            Id := Idvar;

         when others =>
            Put_Line("ERROR CT-ref_pri: tipus no reconegut");
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

   begin
      case Tipus is
         when Pri =>
            Put_Line("CT-ref_pri: pri");
            Ct_Ref_Pri(Fesq, T, It_Arg);
            Ct_Expressio(Fdret, Tsref, Idref);

            if not Arg_Valid(It_Arg) then
               Put_Line("ERROR CT-ref_pri: sobren parametres");
            else
               Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);
               if Idref = Id_Nul then
                  Dtipoarg := Cons(ts, Dparam.targ);
                  if Dtipoarg.dt.tt /= Tsref then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no coincideix amb el tipus demanat");
                  end if;
               elsif Dparam.td = Dargc then 
					 if Idref /= Dparam.targ then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no es correcte "&cons_nom(tn, Idref)&
                                " , "&Cons_nom(tn,Id_cursor));
					 end if;
				  elsif Dparam.td = Dvar then
					 if Idref /= Dparam.tr then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no es correcte "&cons_nom(tn, Idref)&
                                " , "&Cons_nom(tn,Id_cursor));
					 end if;
					
                  end if;
               It_Arg := succ_arg(ts, It_Arg);
            end if;

         when Encappri =>
            Put_Line("CT-ref_pri: encappri");
            Ct_Referencia_Proc(Fesq, Tsub, Id);
            Ct_Expressio(Fdret, Tsref, Idref);
            Dbase := Cons (ts, id);
            if Tsub = Tsarr and Dbase.td = Dproc then
               It_Arg := Primer_Arg(Ts, Id);
               if Arg_Valid(It_Arg) then
                  Cons_Arg(Ts, It_Arg, Id_Cursor, Dparam);
                  if Idref = Id_Nul then
                     Dtipoarg := Cons(ts, Dparam.targ);
                     if Dtipoarg.dt.tt /= Tsref then
                        Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                   "no coincideix amb el tipus demanat");
                     end if;
                  elsif Dparam.td = Dargc then 
					 if Idref /= Dparam.targ then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no es correcte "&cons_nom(tn, Idref)&
                                " , "&Cons_nom(tn,Id_cursor));
					 end if;
				  elsif Dparam.td = Dvar then
					 if Idref /= Dparam.tr then
                     Put_Line("ERROR CT-ref_pri: el tipus del parametre "&
                                "no es correcte "&cons_nom(tn, Idref)&
                                " , "&Cons_nom(tn,Id_cursor));
					 end if;
					
                  end if;
               end if;
            else
               Put_Line("ERROR CT-ref_pri: error en el tipus, no es "&
                          "un procediment amb parametres "&Tsub'img);
            end if;
            It_Arg := succ_arg(ts, It_Arg);
            T := Tsub;

         when others =>
            Put_Line("ERROR CT-ref_pri: tipus no reconegut");
      end case;

   end Ct_Ref_Pri;


end Decls.Ctipus;
