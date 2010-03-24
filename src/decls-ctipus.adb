with U_Lexica;

use U_Lexica;


package body Decls.Ctipus is


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
       a := (a_lit, l, c, valor(id));
   end mt_string;


   procedure mt_caracter
     (l, c : in natural;
       car : in string;
         a : out atribut) is
   begin
      a := (a_lit, l, c, valor(car'First+1));
   end mt_caracter;


   procedure mt_numero
     (l, c : in natural;
         s : in string;
         a : out atribut) is
   begin
       a := (a_lit, l, c, valor(Integer'value(s)));
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


   -- Procediments interns
   procedure Posa_Id
     (I : in Id_Nom;
      E : out Boolean) is
   begin
      nv := nv + 1;
      Tassig := (Dvar, I, Nv);
      Posa(Ts, I, Tassig, E);
   end Posa_Id;


   -- Comprovacio de tipus
   procedure Inicia_analisi is

   begin
        nv := 0;
    np := 0;
        Tbuida(Tn);
    Tbuida(Ts);
    Inicia_Enter;

   end Inicia_analisi;


   procedure Ct_Programa
     (A : in Pnode) is
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
      Ct_Encap(Encap, Id_Sup);

      if Id_Inf /= Id_Sup then
         raise Identificadors_Diferents;
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;

      --Ct_Bloc(Bloc);

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

   begin
      Cons_Tnode(Decl, Tnode);
      case Tnode is
         when Dvariable   => Ct_Decvar(Decl);
         when Dconstant   => Ct_Decconst(Decl);
         --when Dcoleccio   => Ct_Deccol(Decl);
         --when Dregistre   => Ct_Decregistre(Decl);
         --when Dsubrang    => Ct_Decsubrang(Decl);
         --when Procediment => Ct_Procediment(Decl);
         when others => raise Tdeclaracio_Inexistent;
      end case;

      if Decls.Tipus = Declaracions then
         Ct_Declaracions(Decls);
      end if;

   exception
      when Tdeclaracio_Inexistent =>
         Put_Line("ERROR CT: tipus declarat inexistent");

   end Ct_Declaracions;


   procedure Ct_Decvar
     (A : in Pnode) is

      Dvariable : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      Tipus : Descrip;
      Tassig : Descrip;
      Idvar : Id_nom;
      E : Boolean;

   begin
      Ct_Declsvar(Dvariable, Tipus, Idvar);
      nv := nv + 1;
      Tassig := (Dvar, Idvar, Nv);
      Posa(Ts, Id, Tassig, E);

      if E then
         raise Identificador_Existent;
      end if;
        --Posa(Ts, Id, Tipus, E);

      ----------EXPLICACIO DEL CODI ANTERIOR-------------------
      -- Aqui assignam el tipus subjacent 'Tipus'
      --retornat per Ct_Declsvar a la variable 'Id'
      --per guardar a la taula de simbols que aquesta
      --variable es d'aquest tipus concret.
      ---------------------------------------------------------
   exception
      when Identificador_Existent =>
         Put_Line("ERROR CT: L'identificador ja existeix");

   end Ct_Decvar;


   procedure Ct_Declsvar
     (A : in Pnode;
      T : out Descrip;
      Idvar : out Id_nom ) is

      Tnode : Tipusnode renames A.Tipus;
      Fdret : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      E : Boolean;

      Tassig : Descrip; --ASSIGNACIO PROVISIONAL
      Tdecl : Descrip;

   begin
      if Tnode = Asigvalvar then
         Put_Line("VERBOSE: passam a assignacio de variable");

         --PSEUDOCODI:
         --si existeix_tipus_declarat llavors
         Tdecl := Cons(Ts, Id);
         if (Tdecl.Td /= Dnula) then
         -- si existeix_assignacio llavors
            if (Fdret.Tipus /= Tnul) then
         --    Ct_Expressio(Tassig)
                 --    Pensar a assignar valor i pujarlo cap a dalt
         --    si tdeclarat /= tassignacio llavors
               if (Tdecl.Td /= Tassig.Td) then
         --       aixecar Error;
                  raise Tassig_Diferent;
               end if;
            end if;
         -- T := Tipus_Declarat;
            T := Tdecl;
            Idvar := Id;
         else
            raise TNo_Existent;
         end if;

      elsif Tnode = Declmultvar then
         Put_Line("VERBOSE: diferents variables amb mateix tipus...");
         Ct_Declsvar(Fdret, T, Idvar);
         nv := nv + 1;
         Tassig := (dvar, Idvar, nv);
         Posa(Ts, Id, Tassig, E);
      end if;

   exception
      when TNo_Existent =>
         Put_Line("ERROR CT: el tipus no existeix");
      when Tassig_Diferent =>
         Put_Line("ERROR CT: el tipus que es vol"&
                    "assignar es diferent al declarat");

   end Ct_Declsvar;


    procedure Ct_Decconst
     (A : in Pnode) is

          Id      : Id_nom renames A.fe2.id12;
          Idtipus : Id_nom renames A.fc2.id12;
          Val : Pnode renames A.fd2;
          E : Boolean;
      Tdecl : Descrip;
          Txxx : Descrip;

        begin

                Tdecl := Cons(Ts, Idtipus);
        if (Tdecl.Td /= Dnula) then
                        --Ct_Expressio(Tassig,valor);
                        Posa(Ts, Id, Tdecl, E);


            else
            raise TNo_Existent;
        end if;

        exception

      when TNo_Existent =>
         Put_Line("ERROR CT: el tipus no existeix");

        end Ct_Decconst;


end Decls.Ctipus;
