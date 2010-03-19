
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

   begin
      Ct_Encap(Encap, Id_Sup);

      Put_Line("id_inf: "&Id_Inf'Img);
      Put_Line("id_sup: "&Id_Sup'Img);
      Put_Line("id_sup: "&Cons_Nom(Tn, Id_Sup));
      Put_Line("id_inf: "&Cons_Nom(Tn, Id_Inf));

      if Id_Inf /= Id_Sup then
         raise Identificadors_Diferents;
      end if;

      --Ct_Declaracions(Decls);
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

      --Id : Id_Nom renames A.Id12;

   begin
      if A.Tipus = Pencap then
         Ct_Pencap(A, I);
      else
         --I := Id;
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
      --Ct_Param(Fesq);

      if Fesq.Tipus = Identificador then
         I := Id; --si no funciona: fesq.id12
      else
         Ct_Pencap(Fesq, I);
      end if;

   end Ct_Pencap;





end Decls.Ctipus;
