
package body semantica.gci is

   procedure Ct_Programa
     (A : in Pnode) is
      d : Descrip;
      Idproc : Id_nom renames A.Fid5.Id12;
      ida : cursor_arg;
   begin
      --Entrabloc(Ts);
      Ct_Decprocediment(A);

      --Surtbloc(Ts);
	 
      Tanca_Fitxer;
   end Ct_Programa;


   procedure Ct_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Proc : Id_Nom renames A.Fid5.Id12;

   begin
      Put_line("CT_Decprocediment");
      Ct_Encap(Encap, Id_Proc);

      if Decls.Tipus = Declaracions then
         Ct_Declaracions(Decls);
      end if;

      Ct_Bloc(Bloc);
      Surtbloc(Ts);

   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : in Id_Nom) is

      Tproc : Descrip;
      
   begin
      Put_line("CT_ENCAP");
	  Tproc:=Cons(Ts, I);
	  empilar(Pproc, Tproc.Np);
   end Ct_Encap;



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


end semantica.gci;

