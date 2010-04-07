with U_Lexica;

use U_Lexica;


package body Decls.Ctipus is


   -- FALTA:
   --    - dir-li que es una constant
   --    - mirar que quan assignam un valor sigui del rang
   --    - fer entra i surt bloc
   --    - guardar el valor

   -- Rutines lexiques
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
      D := (Dconst, Idb, -1, Nv);
      Posa(Ts, Idt, D, E);

      Posa_Id(Tn, Idf, "false");
      Nv := Nv + 1;
      D := (Dconst, Idb, 0, Nv);
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
   begin
      Ct_M1;
      Ct_Decprocediment(A.Fd1);
      printts(ts);
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
         raise Identificadors_Diferents;
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;

      Ct_Bloc(Bloc);

   exception
      when Identificadors_Diferents =>
         -- Entram al missatge corresponent
         -- FALTA PER FER
         Put_Line("ERROR CT: identificadors diferents");

   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom) is

      Tproc : Descrip;
      E : Boolean;

   begin
      Put_line("CT_ENCAP");
      if A.Tipus = Pencap then
         Ct_Pencap(A, I);
      else
         I := A.Id12;
         --aqui
         --Entrabloc(Ts);
         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, I, Tproc, E);
         --fi
      end if;

   end Ct_Encap;


   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      Id : Id_Nom renames A.Fe1.Id12;
      Tproc : Descrip;
      E : Boolean;

   begin
      Put_line("CT_pencap");
      Ct_Param(Fesq);

      if Fesq.Tipus = Identificador then
         --aqui
         --Entrabloc(Ts);
         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, Id, Tproc, E);
         --fi
         I := Id; --si no funciona: fesq.id12
      else
         Ct_Pencap(Fesq, I);
      end if;

   end Ct_Pencap;


   procedure Ct_Param
     (A : in Pnode) is
   begin
      Put_Line("comprovam els paràmetres");
   end Ct_Param;


   procedure Ct_Declaracions
     (A : in Pnode) is

      Decl : Pnode renames A.Fd1;
      Decls : Pnode renames A.Fe1;
      Tnode : Tipusnode;
      Merdaid : Id_Nom;

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
         when Dregistre |
           Dencapregistre => Ct_Decregistre(Decl, Merdaid);
         when Dsubrang    => Ct_Decsubrang(Decl);
         --when Procediment => Ct_Procediment(Decl);
         when others => raise Tdeclaracio_Inexistent;
      end case;

   exception
      when Tdeclaracio_Inexistent =>
         Put_Line("ERROR CT-declaracions: tipus declarat inexistent");

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

      -- variables per la crida a procediment
      --Tsubj_assig : Tipussubjacent;
      --Id_assig : Id_Nom;

   begin
      Put_line("CT_DECLSVAR");
      if Tnode = Identificador then
         Tdecl := Cons(Ts, A.Id12);
         if (Tdecl.Td /= Dnula) then --la id existeix
            Idtipus := A.Id12;
         else
            raise TNo_Existent;
         end if;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(A.Fd1, Idtipus);
         Put_Line("VERBOSE: diferents variables amb mateix tipus...");
         Posa_Idvar(A.Fe1.Id12, Idtipus, E);
      end if;

   exception
      when TNo_Existent =>
         Put_Line("ERROR CT: el tipus no existeix");
      when Tassig_Diferent =>
         Put_Line("ERROR CT: el tipus que es vol"&
                    " assignar es diferent al declarat");

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
      if (Tdecl.Td /= Dnula) then

         Ct_Constant(Val, Tsubj, Ids);
         if (Idtipus /= Ids) and (Ids /= Id_Nul) then
            Put_Line("ERROR CT-const: tipus assig diferent");
         elsif (Ids = Id_Nul) and (Tsubj /= Tdecl.Dt.Tt) then
            Put_Line("ERROR CT-const: tipus subj diferent");
         else
            if (Val.Val < Tdecl.Dt.Linf) or (Val.Val > Tdecl.Dt.Lsup) then
               Put_Line("ERROR CT-const: el valor de la constant "&
                       "surt del rang");
            else
               -- Guardam la constant
               Nv := Nv + 1;
               Tconst := (dconst, IdTipus, Val.val, Nv);
               Posa(Ts, Id, Tconst, E);
               Put_Line("El valor de la constant es: "&Val.val'img);                        if E then
                  Put_Line("ERROR-CT-const: var ja existent");
               end if;
            end if;
         end if;

      else
         raise Tno_Existent;
      end if;

   exception
      when Tno_Existent =>
         Put_Line("ERROR CT-const: el tipus no existeix");
   end Ct_Decconst;


   procedure Ct_Deccol
     (A : in Pnode) is

      Darray : Descrip;
      Fesq : Pnode renames A.Fe1;
      Idtipus_Array : Id_Nom renames A.Fd1.Id12;
      Idarray : Id_Nom;

   begin
      Darray := Cons(Ts, Idtipus_Array);
      if (Darray.Td = Dtipus) then
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray);
      else
         Put_Line("ERROR-CT-deccol: el tipus de l'array no existeix");
      end if;
   end Ct_Deccol;


   procedure Ct_Pcoleccio
     (A : in Pnode;
      Idtipus_Array : in Id_Nom;
      Idarray : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Idrang : Id_Nom renames A.Fd1.Id12;
      E : Boolean;

      Dtarray : Descriptipus;
      Darray : Descrip;

   begin
      if (A.Tipus = Pcoleccio) then
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray);
         Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posa_idx, error "&
                       "del compilador, array no creat");
         end if;

      elsif (A.Tipus = Pdimcoleccio) then
         Dtarray := (Tsarr, 4, Idtipus_Array);
         Darray := (Dtipus, Dtarray);
         Idarray := Fesq.Id12;

         Posa(Ts, Idarray, Darray, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'array");
         end if;

         Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pdimcoleccio: error al posa_idx, error "&
                       "del compilador, array no creat, idarr: "&
                       Idarray'Img);
         end if;
      end if;
   end Ct_Pcoleccio;


   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      Drecord : Descrip;
      Dtrecord : Descriptipus;
      Camp : Pnode renames A.Fc2;
      Tcamp : Pnode renames A.Fd2;
      E : Boolean;

   begin
      if (Tipus = Dregistre) then
         Dtrecord := (Tsrec, 0);
         Drecord := (Dtipus, Dtrecord);
         Posa(Ts, A.Fe2.Id12, Drecord, E);
         Idrecord := A.Fe2.Id12;
         if E then
            Put_Line("ERROR CT-registre: el id del record "&
                       "ja existeix");
         end if;

         Ct_Dregistre_Camp(A.Fe2.Id12, Camp, Tcamp);
      elsif (Tipus = Dencapregistre) then
         Ct_Decregistre(A.Fe2, Idrecord);
         Ct_Dregistre_Camp(Idrecord, Camp, Tcamp);
      end if;
   end Ct_Decregistre;


   procedure Ct_Dregistre_Camp
     (Idrecord : in Id_Nom;
      Camp : in Pnode;
      Tcamp : in Pnode) is

      Idtcamp : Id_Nom renames Tcamp.Id12;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames Camp.Id12;
      Desc_Camp : Descrip;
      E : Boolean;

   begin
      Dtcamp := Cons(Ts, Idtcamp);
      if (Dtcamp.Td = Dnula) or (Dtcamp.Td /= Dtipus) then
         Put_Line("ERROR CT-dregistre-camp: el tipus del camp no "&
                    "existeix o no es d'un tipus");
      end if;
      --desplnul provisional
      Desc_Camp := (Dcamp, Idtcamp, Nul_Despl);
      Posacamp(Ts, Idrecord, Idcamp, Desc_Camp, E);
      if E then
         Put_Line("ERROR CT-dregistre-camp: ja existeix un camp amb "&
                    "el mateix id en aquest record");
      end if;
   end Ct_Dregistre_Camp;


   procedure Ct_Dsubrang_Limit
     (A : in Pnode;
      Val : out Valor;
      Id : out Id_Nom;
      Tsubj : out Tipussubjacent;
      S : in String) is

      Rang : Pnode renames A;
      Tipus : Descrip;

   begin
      if (Rang.Tipus = Const) then
         Ct_Constant(Rang, Tsubj, Id);
         Val := Rang.Val;
      elsif (Rang.Tipus = Identificador) then
         Tipus := Cons(Ts, A.Id12);
         if (Tipus.Td = Dconst) then
            Ct_Identificador(Rang, Tsubj, Id);
            Val := Tipus.Vc;
         else
            Put_Line("ERROR CT-Dsubrang_Limit: El limit "&S&
                       " es una variable no constant.");
         end if;
      else
         Put_Line("ERROR CT-Dsubrang_Limit: El limit "&S&
                    " no es de cap tipus vàlid.");
      end if;

   end Ct_Dsubrang_Limit;


   procedure Ct_Decsubrang
     (A : in Pnode) is

      Idsubrang : Id_Nom renames A.Fe5.Id12;
      Idtsubrang : Id_Nom renames A.Fc5.Id12;
      Idtipus : Id_nom;

      --Suposarem que limit nomes pot ser 'const' o una constant
      Rang_Esq : Pnode renames A.Fd5;
      Rang_Dret : Pnode renames A.Fid5;
      T : Tipussubjacent;

      Tsesq : Tipussubjacent;
      Tsdret : Tipussubjacent;
      Idesq : Id_Nom;
      Iddret : Id_Nom;
      Valesq : Valor;
      Valdret : Valor;

      Tdecl : Descrip;
      --Tresq : Descrip;
      --Trdret : Descrip;

      Tdescrip_decl : Descrip;
      Tdescript_decl : Descriptipus;

      E : Boolean;

   begin
      Tdecl := Cons(Ts, Idtsubrang);
      --Miram si el tipus sobre el qual es vol crear
      if (Tdecl.Td /= Dnula) then
         if(Tdecl.Td = Dtipus) and (Tdecl.dt.tt = Tsbool
                                or  Tdecl.dt.tt = Tscar
                                or  Tdecl.dt.tt = tsent ) then

            --Miram el fill esquerra
            Ct_Dsubrang_Limit(Rang_Esq, Valesq, Idesq, Tsesq, "esquerra");

            --Miram el fill dret
            Ct_Dsubrang_Limit(Rang_Dret, Valdret, Iddret, Tsdret, "dret");

            -- Comparam els tipus
            if (Idesq /= Id_Nul) and (Iddret /= Id_Nul) then
               if (Idesq = Iddret) then
                  T := Tsesq;
                  Idtipus := Idesq;
               else
                  Put_Line("ERROR CT-decsubrang: Els tipus assignats"&
                             " no coincideixen");
               end if;
            else
               if (Tsesq = Tsdret) then
                  if (Idesq /= Id_Nul) then
                     Idtipus := Idesq;
                  elsif (Iddret /= Id_Nul) then
                     Idtipus := Iddret;
                  else
                     Idtipus := Id_Nul;
                  end if;
                  T := Tsesq;
               else
                  Put_line("ERROR Ct_expresio: Tipus subjacents diferents");
                  Idtipus := Idesq;
                  T := Tsesq;
               end if;
            end if;

            if(Idtipus = Id_nul) then
               if (T = Tdecl.dt.tt) then
                  --tipus subjacents iguals
                  if (valesq < valdret) then
                     --rang esq menor rang dret
                     --cream la variable
                     case (T) is
                        when tsbool =>
                           Tdescript_decl := (tsbool, 4, valesq, valdret);
                        when tscar =>
                           Tdescript_decl := (Tscar, 4, valesq, valdret);
                        when tsent =>
                           Tdescript_decl := (Tsent, 4, valesq, valdret);
                        when others =>
                           Put_Line("ERROR CT-decsubrang: "&
                                      "ERROR UNCONTROLLED");
                     end case;
                     Tdescrip_decl := (Dtipus, Tdescript_decl);
                     Posa(ts, Idsubrang, Tdescrip_decl, E);
                     if E then
                        Put_Line("ERROR CT-decsubrang: el tipus "&
                                   "que intentes declarar ja existeix");
                     end if;
                  else
                     Put_Line("ERROR CT-decsubrang: el rang esq "&
                                "es major o igual q el dret");
                  end if;
               else
                  Put_Line("ERROR CT-decsubrang: els tipus del "&
                             "rang i el declarat son diferents");
               end if;

            elsif (idtipus = idtsubrang) then
               --tipus dels limits i del tipus subrang iguals
               if (valesq < valdret) then
                  --rang esq menor rang dret
                  case (T) is
                     when Tsbool =>
                        Tdescript_decl := (tsbool, 4, valesq, valdret);
                     when tscar =>
                        Tdescript_decl := (Tscar, 4, valesq, valdret);
                     when tsent =>
                        Tdescript_decl := (Tsent, 4, valesq, valdret);
                     when others =>
                        Put_Line("ERROR CT-decsubrang: ERROR UNCONTROLLED");
                  end case;
                  Tdescrip_decl := (Dtipus, Tdescript_decl);
                  posa(ts, Idsubrang, Tdescrip_decl, E);
                  if E then
                     put_line("ERROR CT-decsubrang: el tipus que "&
                                "intentes declarar ja existeix");
                  end if;
               else
                  put_line("ERROR CT-decsubrang: el rang esq "&
                             "es major o igual q el dret");
               end if;
            else
               put_line("ERROR CT-decsubrang: els tipus del "&
                          "rang i el declarat fallen");
            end if;
         else
            Put_Line("ERROR CT-decsubrang: tipus 'new x' "&
                       "x no es d'un tipus valid");
         end if;
      else
         Put_Line("ERROR CT-decsubrang: tipus 'new x' x no existeix");
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
      if Tipus = Expressio then
         Ct_Expressioc(A, Tps, Id);
      elsif Tipus = ExpressioUnaria then
         Ct_Expressiou(A, Tps, Id);
      elsif Tipus = Identificador then
        Ct_identificador(A, Tps, Id);
      elsif Tipus = const then
         Ct_Constant(A, Tps, Id);
      end if;

      T := Tps;
      Idtipus := Id;

   end Ct_Expressio;


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
      case Fesq.Tipus is
         when Expressio =>
            Ct_Expressioc(Fesq, Tesq, Idesq);
         when ExpressioUnaria =>
            Ct_Expressiou(Fesq, Tesq, Idesq);
         when Referencia =>
            --Ct_Referencia(Fesq, Tesq, Idesq);
            Put_Line("refe");
         when Const =>
            Ct_Constant(Fesq, Tesq, Idesq);
         when Identificador =>
            Ct_Identificador(Fesq, Tesq, Idesq);
            Put_line("CT_EXP_COMP Id: "&Idesq'img);
         when others =>
            null;
      end case;

      case Fdret.Tipus is
         when Expressio =>
            Ct_Expressioc(Fdret, Tdret, Iddret);
         when ExpressioUnaria =>
            Ct_Expressiou(Fdret, Tdret, Iddret);
         when Referencia =>
            --Ct_Referencia(Fdret, Tdret, Iddret);
            Put_Line("refe");
         when Const =>
            Ct_Constant(Fdret, Tdret, Iddret);
            Put_line("CT_EXP_COMP const: "&Iddret'img);
         when Identificador =>
            Ct_Identificador(Fdret, Tdret, Iddret);
         when others =>
            null;
      end case;

      -- Comparam els tipus
      if (Idesq /= Id_Nul) and (Iddret /= Id_Nul) then
         if (Idesq = Iddret) then
            T := Tesq;
            Idtipus := Idesq;
         end if;
      else
        if (Tesq = Tdret) then
            if (Idesq /= Id_Nul) then
               Idtipus := Idesq;
            elsif (Iddret /= Id_Nul) then
               Idtipus := Iddret;
            else
               Idtipus := Id_Nul;
            end if;
            T := Tesq;
        else
            Put_line("ERROR Ct_expresio: Tipus subjacents diferents");
            Idtipus := Idesq;
            T := Tesq;
        end if;
      end if;

   end Ct_Expressioc;


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
      case Fdret.Tipus is
         when Expressio =>
            Ct_Expressioc(Fdret, Tdret, Iddret);
         when ExpressioUnaria =>
            Ct_Expressiou(Fdret, Tdret, Iddret);
         when Referencia =>
            --Ct_Referencia(Fdret, Tdret, Iddret);
            Put_Line("refe");
         when Const =>
            Ct_Constant(Fdret, Tdret, Iddret);
         when Identificador =>
            Ct_Identificador(Fdret, Tdret, Iddret);
         when others =>
            null;
      end case;

      -- Comprovar el tipus segons la Op
      if (Op = Negacio) and (Tdret = Tsbool) then
         T := Tdret;
         Idtipus := Iddret;
      elsif (Op = Resta) and (Tdret = Tsent) then
         T := Tdret;
         Idtipus := Iddret;
      else
         Put_Line("ERROR CT-expun: l'expressio no suporta el tipus");
         -- Pujam aixo per seguir comprovant tipus

         if (Op = Negacio) then T := Tsbool;
         else T := Tsent;
         end if;

         Idtipus := Id_Nul;
      end if;

   end Ct_Expressiou;


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

   begin
      put_line(" CT_ID : "&Id'img);
      D := Cons(Ts, Id);

      if (D.Td = dvar) then
         Idtipus := D.Tr;
         D := Cons(Ts, Idtipus);
         if (D.Td = Dtipus) then
            T := D.Dt.Tt;
         else
            Put_Line("ERROR CT-identificador: el tipus no es"&
                       " una descripcio de tipus "&D.Td'img);
         end if;

      elsif (D.Td = Dconst) then
         Idtipus := D.Tc;
         D := Cons(Ts, Idtipus);
         if (D.Td = Dtipus) then
            T := D.Dt.Tt;
         else
            Put_Line("ERROR CT-identificador: el tipus no es"&
                       " una descripcio de tipus "&D.Td'img);
         end if;
      else
         Put_Line("ERROR CT: l'identificador no es una variable");
      end if;
      Put_line("ct_id: Tipus: "&Idtipus'img);

   end Ct_Identificador;


   procedure Ct_Bloc
     (A : in Pnode) is
   begin
      case (A.Tipus) then
         when Bloc =>
            Ct_Bloc(A.Fe1);
            Ct_Bloc(A.Fd1);
         when Repeticio =>
            Ct_Srep(A);
         when others =>
            Put_Line("blocothers");
      end case;
   end Ct_Bloc;


   procedure Ct_Srep
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Exp : Pnode renames A.Fe1;

   begin
      Ct_Expressio(Exp, Tsexp, Idtipus_Exp);

   end Ct_Srep;


end Decls.Ctipus;
