
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




   procedure gci_Referencia_Proc --Complet
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


	--Procediments
   procedure gci_Ref_Pri --pendent d'acabar expressions
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
            gci_Ref_Pri(Fesq, T, It_Arg);
            gci_Expressio(Fdret, Tsref, Idref);
			
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



	

   procedure gci_Identificador -- falta fer el proc , var i const correcte
     (A : in Pnode;
      Idres, Iddesp, Idtipus : out Id_Nom) is

      Id : Id_Nom renames A.Id12;
      D : Descrip;
      Desc : Tdescrip renames D.Td;

      Carg : Cursor_Arg;

	  idv : num_var := var_nul;
	  idproc : num_proc := proc_nul;
	  c1, c2: camp;

   begin
      put_line(" CT_ID : "&Id'img);
      D := Cons(Ts, Id);

      case Desc is
         when Dvar =>
			Idres := d.nv;
			Iddesp := id_nul;
			Idtipus := d.tr;

         when Dconst =>
			cim(pproc, idproc);
		 	Novavar(Tv, idproc, Idv);

			C1:=(
			     Tc => Var,
			     Idv => Idvar
			);

			C2:=(
			     Tc => Const,
			     Idc => d.vc
			);

			genera(copia, c1, c2);

			Idres:= idv;
			Iddesp:= id_nul;
			Idtipus:= d.tc;

         when Dproc => --No tocado
            --Carg := Primer_Arg(Ts, Id);
            --if Arg_Valid(Carg) then
            --   T := Tsarr;
            --else
            --   T := Tsnul;
            --end if;
            Idres := Id;

         when others =>
			null;

      end case;

      Put_line("gci_id: Tipus: "&Idtipus'img);

   end gci_Identificador;



   procedure gci_Expressio
     (A : in Pnode;
      IdR, IdD: out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      Tps : Tipussubjacent;
      Id : Id_Nom;

   begin
      Put_line("CT_EXP: "&Tipus'img );
      case Tipus is
         when Expressio =>
            gci_Expressioc(A, Tps, Id);
         when ExpressioUnaria =>
            Ct_Expressiou(A, Tps, Id);
         when Identificador =>
            Ct_Identificador(A, Tps, Id);
         when Const =>
            Ct_Constant(A, Tps, Id);
         when Fireferencia | Referencia =>
            Ct_Referencia_Var(A, Tps, Id); 
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
            gci_Expressioc(A, T, Idtipus);
         when ExpressioUnaria =>
            Ct_Expressiou(A, T, Idtipus);
         when Referencia | Fireferencia=>
            Ct_Referencia_var(A, T, IdTipus);
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




   procedure gci_Expressioc --comprovar parametres
     (A : in Pnode;
      T : out Tipussubjacent;
      Idtipus : out Id_Nom) is

      Fesq : Pnode renames A.Fe3;
      Fdret : Pnode renames A.Fd3;
      Op : Operacio renames A.Op3;

      Idesq : Id_Nom;
      Iddret : Id_Nom;
	  Ires : Id_Nom;

   begin
      Put_line("gci_EXPRESSIOC");
      --Analitzam l'operand esquerra
      Ct_Operand_Exp(Fesq, Idesq);
      --Analitzam l'operand dret
      Ct_Operand_Exp(Fdret, Iddret);
      -- Comparam els tipus
      case Op is

         when Unio | Interseccio =>
            Ct_Exp_Logica(Idesq, Iddret, Ires, Op);
         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            Ct_Exp_Relacional(Idesq, Iddret, Ires, Op);
         when Suma | Resta | Mult | Div | Modul =>
            Ct_Exp_Aritmetica(Idesq, Iddret, Ires, Op);
         when others =>
            null;
      end case;

   end gci_Expressioc;



   procedure gci_Exp_Logica  --manca tocar
     (Idesq, Iddret : in Id_Nom;
	  IddespE,IddespD : in out num_var;
      Op : in Operacio) is

		T1,
		T2,
		T3 : num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;

   begin

	   if Idesq.Idvdespexp = Var_Nul then
		  T1:=Valor1.Idvbaseexp;
	   else
		  Novavar(Tv, Idproc_Actual, T1);
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => Valor1.Idvbaseexp
		     );
		  C3:=(
		     Tc => Var,
		     Idv => Valor1.Idvdespexp
		     );
		  Genera(Consindice,C1,C2,C3);
	   end if;
	   if Valor2.Idvdespexp=Id_Var_Nul then
		  T2:=Valor2.Idvbaseexp;
	   else
		  Novavar(Tv, Idproc_Actual, T2);
		  C1:=(
		     Tc => Var,
		     Idv => T2
		     );
		  C2:=(
		     Tc => Var,
		     Idv => Valor2.Idvbaseexp
		     );
		  C3:=(
		     Tc => Var,
		     Idv => Valor2.Idvdespexp);
		Genera(Consindice,C1,C2,C3);
		end if;
	Novavar(Tv, Idproc_Actual, T3);
	C1:=(
	   Tc => Var,
	   Idv => T3
	   );
	C2:=(
	   Tc => Var,
	   Idv => T1
	   );
	C3:=(
	   Tc => Var,
	   Idv => T2
	   );
	case Op is
	when  Unio =>
	when  Interseccio =>
	when others => null;
	end case;
	Genera(Op_And,C1,C2,C3);
	Result.Idvbaseexp:=T3;
	Result.Idvdespexp:=Id_Var_Nul;

   end gci_Exp_Logica;


   procedure gci_Referencia_Var --Fet xo amb errors al enccapri (da.b no
	--existeix a la practica)
     (A : in Pnode;
      Idres, Iddesp, Idtipus : out Id_Nom) is

      Tipus : Tipusnode renames A.Tipus;
      Idbase : Id_Nom;
      It_Idx : Cursor_Idx;
      da,dtc : Descrip;
	  T1,T2,T3,T4,T5: num_Var := Var_Nul;
	  idproc : num_proc := proc_nul;
	  c1, c2, c3: camp;

   begin
      case Tipus is
         when Identificador =>
            gci_Identificador(A, Idres, Iddesp, Idtipus);


         when Referencia => -- r -> r.id
            gci_Ref_Rec(A, Idres, Iddesp, Idtipus);

         when Fireferencia => --r -> ref_pri)

            gci_Ref_Pri(A.F6,Idres,Iddesp,Idtipus,Idbase,It_Idx);

			da := cons(ts,Idtipus);
			Idtipus := da.tr;
			dtc := cons(ts,da.tr);
			
			cim(pproc, idproc);
		    Novavar(Tv, idproc, T1);
			Novavar(Tv, idproc, T2);
	        Novaconst(Tv,da.b , Tsent, idproc, T3); -- da.b no existeix encara
			-- i a mes haurem de omplirla a les decls!!!
			C1:=(
   				Tc => Var,
              	Idv => T1
   				);
			C2:=(
   				Tc  => Var,
   				Idv => Iddesp
  				);
			C3:=(
 				Tc  => Const,
   				Idc => T3
   				);
				Genera (Resta, C1, C2, C3);
				C2.Idv:=T2;
				C3.Idc:=dtc.dt.ocup; --aqui pot petar...
				Genera (Producte, C2, C1, C3);
				
				if Idbase = Id_nul then

					Iddesp := T2;

				else
					Novavar(Tv, idproc, T4);
					Novaconst(Tv,Idbase, Tsent, idproc, T5);

					C1:=(
   						Tc => Var,
              			Idv => T4
   						);
					C2:=(
   						Tc  => Const,
   						Idv => T5
  						);
					C3:=(
 						Tc  => Var,
   						Idc => T2
   						);
					Genera (Suma, C1, C2, C3);
					
				end if;
	
         when others =>
            Put_Line("ERROR CT-referencia: node no "&
                       "reconegut");
            Esem := True;
      end case;

   end gci_Referencia_Var;

--Arrays
   procedure gci_Ref_Pri --Correcte : dubte entre el tipus de prm) i r->id
     (A : in Pnode;
      Idres, Iddesp, Idtipus, Idbase : out Id_Nom;
      It_Idx : out Cursor_Idx) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      IdresE, iddespE : Id_Nom := id_nul;

   	  T0,T1,T2,T3 : num_Var := Var_Nul;
	  C1, C2, C3 : Camp;
      idproc : num_proc := proc_nul;
	  di : Id_nom;
	  dti: descrip;

   begin
      case Tipus is
         when Pri => --pri -> pri ,E
            --Put_Line("CT-ref_pri: pri");
			gci_Ref_Pri(Fesq, Idres, Iddesp, Idtipus, Idbase, It_Idx);
            gci_Expressio(Fdret, IdresE, IddespE);
			
			It_Idx := Succ_Idx(Ts, It_Idx);
			
			di := cons_idx(ts, It_idx);
			dti := cons(ts,di);
			ni := dti.dt.lsup - dti.dt.linf + 1;
            
			cim(pproc, idproc);
		    Novaconst(Tv,ni , Tsent, idproc, T0);
			Novavar(Tv, idproc, T1);
		
			C1:=(
			   	Tc => Var,
				Idv => T1
			);
			C2:=(
			   Tc => Var,
			   Idv => Iddesp
			);
			C3:=(
			   Tc  => Const,
			   Idc => T0 
			);

			Genera(Producte, C1, C2, C3);
			Novavar(Tv, idproc, T2);
			if IddespE = id_nul then
				
				C1:=(
				   	Tc => Var,
			   		Idv => T2
				   	);
				C2:=(
				   Tc => Var,
				   Idv => T1
				   );
				C3:=(
				   Tc => Var,
				   Idv => IdresE
				   );

				Genera(Suma, C1, C2, C3);
						
			else

			 	Novavar(Tv, idproc, T1);
		
				C1:=(
				   Tc => Var,
			   	   Idv => T3
				   	);
				C2:=(
				   Tc => Var,
				   Idv => IdresE
				   );
				C3:=(
				   Tc => Var,
				   Idv => IddespE
				   );

				Genera(Suma, C1, C2, C3);
				
				C1:=(
				   	Tc => Var,
			   		Idv => T2
				   	);
				C2:=(
				   Tc => Var,
				   Idv => T1
				   );
				C3:=(
				   Tc => Var,
				   Idv => T3
				   );

				Genera(Suma, C1, C2, C3);
			end if;
			Iddesp:=T2;

         when Encappri => -- encappri --> R(E
    
		    gci_Referencia_Var(Fesq, Idres, Idbase, Idtipus);
            gci_Expressio(Fdret, IdresE, IddespE);			

			It_Idx := primer_idx(ts, Idtipus); ------------
			
			if IddespE = id_nul then
				Iddesp:= idresE;				
			else
				cim(pproc, idproc);
			 	Novavar(Tv, idproc, T1);
		
				C1:=(
				   	Tc => Var,
			   		Idv => T1
				   	);
				C2:=(
				   Tc => Var,
				   Idv => IdresE
				   );
				C3:=(
				   Tc => Var,
				   Idv => IddespE
				   );

				Genera(Suma, C1, C2, C3);
				Iddesp:=T1;
			end if;

         when others =>
            Put_Line("ERROR (DEBUG) gci-ref_pri: tipus no "&
                       "reconegut");
      end case;
   end gci_Ref_Pri;



   procedure gci_Ref_Rec --correcte
     (A : in Pnode;
      Idres, Iddesp, Idtipus : out Id_Nom) is

      Fesq : Pnode renames A.Fe1;
      Tesq : Tipussubjacent;
      Idbase_Esq : Id_Nom;
      Dcamp : Descrip;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames A.Fd1.Id12;

		numconstant : num_var := var_nul;

		T1 :num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;

   begin

      Ct_Referencia_Var(Fesq, Idres, Iddesp, Idtipus);
	 

      Dcamp := Conscamp(Ts, Idtipus, Idcamp);
	  Idtipus:= dcamp.tcamp;

      cim(pproc, idproc);
	  Novaconst(Tv, dcamp.despl, Tsent, Idproc, numconstant);

      if Iddesp = id_nul then
		   Iddesp:=numconstant;	  	  
	  else
		   Novavar(Tv, Idproc, T1);	   
		  
           C1:=(Tc => Var,
			   Idv => T1
			   );
		   C2:=(
			   Tc => Var,
			   Idv => Iddesp
			   );
		   C3:=(
			   Tc => Const, --------
			   Idc => numconstant
			   );
		   Genera (Suma, C1, C2, C3);

		   Iddesp:= T1;

      end if;

   end gci_Ref_Rec;


end semantica.gci;

