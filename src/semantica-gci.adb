
package body semantica.gci is


	procedure Genera (
      Instr : in     tInstruccio;
      C1    : in     Camp := Campo_Nul;
      C2    : in     Camp := Campo_Nul;
      C3    : in     Camp := Campo_Nul) is
	begin
   		Escriure_Fitxer((Instr, C1, C2, C3));
	end Genera;





   procedure Ct_Programa
     (A : in Pnode) is
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

      dproc : Descrip;
      
   begin
      Put_line("CT_ENCAP");
	  dproc:=Cons(Ts, I);
	  empilar(Pproc, dproc.Np);
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
         when Identificador => --crida a procediment sense parametres
            Put_Line("CT_Bloc : IDENTIFICADOR");
            gci_idproc(A);

         when Fireferencia =>
            gci_Referencia_Proc(A, T, Idbase);
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




	procedure gci_idproc(A: in Pnode) is
		Id_Proc : Id_Nom renames A.Fid5.Id12;
		dproc : Descrip;
		c1 : camp;
	begin
		dproc:=cons(ts, id_proc);
		c1:=(
		     Tc => Proc,
             Idp => Dproc.Np
   			);
		genera(Call, c1);
	end gci_idproc;




   procedure gci_Referencia_Proc
     (A : in Pnode;
      T : out Tipussubjacent;
      Id : out Id_Nom) is

      	Tipus : Tipusnode renames A.Tipus;

		dproc : Descrip;

		Prm : T_Param;
		c1, c2 : camp;
	


   begin
      case Tipus is
         when Identificador =>
            --Ct_Identificador(A, T, Id);
			Id := A.Fid5.Id12;			

         when Fireferencia =>
            gci_Ref_Pri(A.F6, T);
			
			while not es_buida(pparam) loop
				cim(pparam, prm);
				desempila(pparam);
				
				C1:=(
				     Tc => Var,
				     Idv => Prm.Base
			    );

				C2:=(
				     Tc => Var,
				     Idv => Prm.Despl
			    );

				if Prm.Despl=Var_Nul then
				   Genera(Params, C1);
				else
				   Genera(Paramc, C1, C2);
				end if;

			end loop;

			c1:=(
		     	Tc => Proc,
             	Idp => Dproc.Np
   			);
			genera(Call, c1);

         when others =>
            Put_Line("ERROR (DEBUG) gci-referencia: node "&
                       "no reconegut");

      end case;

   end gci_Referencia_Proc;



   procedure gci_Ref_Pri
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
			
			pbuida(pparam);
			--empilar(pparam, );

         when Encappri =>
            Put_Line("CT-ref_pri: encappri");
            Ct_Referencia_Proc(Fesq, Tsub, Id);
            Ct_Expressio(Fdret, Tsref, Idref);
           
         when others =>
            Put_Line("ERROR (DEBUG) gci-ref_pri: tipus no "&
                       "reconegut");
      end case;
   end gci_Ref_Pri;


   procedure Ct_Identificador
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

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



   procedure gci_Expressio
     (A : in Pnode;
      IdR, IdD : out Id_Nom) is

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
            Ct_Referencia_Var(A, Tps, Id); --falta L i C
         when others =>
            Put_Line("ERROR (DEBUG) gci-exp: tipus expressio no "&
                       "trobat :S "&Tipus'Img);
      end case;

   end gci_Expressio;



   procedure gci_Operand_Exp
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
            --falta L i C
            Ct_Referencia_var(A, T, IdTipus);
            Put_Line("refe");
         when Const =>
            Ct_Constant(A, T, Idtipus);
            Put_line("gci_EXP_COMP const: "&Idtipus'img);
         when Identificador =>
            Ct_Identificador(A, T, Idtipus);
            Put_line("gci_EXP_COMP Id: "&Idtipus'img);
         when others =>
            null;
      end case;

   end gci_Operand_Exp;




   procedure gci_Expressioc
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
      Put_line("gci_EXPRESSIOC");
      --Analitzam l'operand esquerra
      Ct_Operand_Exp(Fesq, Tesq, Idesq);
      --Analitzam l'operand dret
      Ct_Operand_Exp(Fdret, Tdret, Iddret);
      -- Comparam els tipus
      case Op is
         when Unio | Interseccio =>
            Ct_Exp_Logica(Tesq, Tdret, Idesq, Iddret, T,
                          Idtipus);
         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            Ct_Exp_Relacional(Tesq, Tdret, Idesq, Iddret,
                              T, Idtipus);
         when Suma | Resta | Mult | Div | Modul =>
            Ct_Exp_Aritmetica(Tesq, Tdret, Idesq, Iddret,
                              T, Idtipus);
         when others =>
            null;
      end case;

   end gci_Expressioc;



   procedure gci_Exp_Logica
     (Tesq, Tdret : in Tipussubjacent;
      Idesq, Iddret : in Id_Nom;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

   begin


   end gci_Exp_Logica;





end semantica.gci;

