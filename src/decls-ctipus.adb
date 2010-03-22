
package body Decls.Ctipus is

   procedure Ct_Programa
     (A : in Pnode) is
   begin
      Ct_M1;
      Ct_Decprocediment(A.Fd1);
   end Ct_Programa;


   procedure Ct_M1 is
   begin
      Put_Line("M1: inicialitzam paràmetres");

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
   begin
      Put_Line("comprovam una variaaaable");
   end Ct_Decvar;


end Decls.Ctipus;
