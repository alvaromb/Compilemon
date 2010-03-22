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


   -- Comprovacio de tipus
   procedure Ct_Programa
     (A : in Pnode) is
   begin
      Ct_M1;
      Ct_Decprocediment(A.Fd1);
   end Ct_Programa;


   procedure Ct_M1 is
   begin
      Put_Line("M1: inicialitzam paràmetres");
      Tbuida(Tn);
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
   begin
      if A.Tipus = Pencap then
         Ct_Pencap(A, I);
      else
         I := A.Id12;
      end if;

   end Ct_Encap;


   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      Id : Id_Nom renames A.Fe1.Id12;

   begin
      Ct_Param(Fesq);

      if Fesq.Tipus = Identificador then
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
         --when Dconstant   => Ct_Decconst(Decl);
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

      Dvar : Pnode renames A.Fd1;
      Id : Pnode renames A.Fe1;
      Tipus : Tipussubjacent;

   begin
      Ct_Declsvar(Dvar, Tipus);

      --Id.Tipussubjacent := Tipus;

      ----------EXPLICACIO DEL CODI ANTERIOR-------------------
      -- Aqui assignam el tipus subjacent 'Tipus'
      --retornat per Ct_Declsvar a la variable 'Id'
      --per guardar a la taula de simbols que aquesta
      --variable es d'aquest tipus concret.
      ---------------------------------------------------------
   end Ct_Decvar;


   procedure Ct_Declsvar
     (A : in Pnode;
      T : out Tipussubjacent) is

      Tnode : Tipusnode renames A.Tipus;
      Fdret : Pnode renames A.Fd1;
      Id : Pnode renames A.Fe1;

   begin
      if Tnode = Asigvalvar then
         Put_Line("passam a assignacio de variable");

         --T := Id.Tipussubjacent;
         --Ct_Asigvalvar(Fdret, T);

         ---------EXPLICACIO DEL CODI ANTERIOR-----------------
         -- Aqui el tipus de 'Id' sira el tipus
         --que haurem de retornar com a tipus 'T'
         --mitjançant aquesta variable:
         --       'T : out Tipussubjacent'
         --Aquesta assignacio de 'T' fara que quan torni
         --cap a dalt dins la cerca recursiva es pugui assignar
         --el tipus a cada identificador (aixo es fa a l'else
         --situat abaix)

         -- Emprarem aquest tipus per comparar si el
         --tipus de l'assignacio es el mateix, en cas de que
         --existeixi el fill d'assignacio, el fill dret.
         --Dins del procediment 'Ct_Asigvalvar' farem la comprovacio
         --de tipus per saber si el tipus 'T' que li enviam es
         --correspon amb el tipus de l'assignacio que s'ha
         --introduit.
         -------------------------------------------------------

      elsif Tnode = Declmultvar then
         Put_Line("mes variables d'aquest tipus");
         Ct_Declsvar(Fdret, T);
      end if;
         -- Id.Tipussubjacent := T;

         -------------EXPLICACIO DEL CODI ANTERIOR--------------
         -- Aqui anirem cridant recursivament fins que entri a
         --l'if Tnode = Asigvalvar i aquell bloc ens retorni
         --la variable 'T' amb contingut. Una vegada haguem
         --sortit, assignarem aquest Tipussubjacent 'T' al tipus
         --de l'identificador corresponent a aquesta produccio.
         -------------------------------------------------------


   end Ct_Declsvar;


end Decls.Ctipus;
