
package body semantica.gci is


	procedure Genera (
      Instr : in     tInstruccio;
      C1    : in     Camp := Campo_Nul;
      C2    : in     Camp := Campo_Nul;
      C3    : in     Camp := Campo_Nul) is
	begin
   		Escriure_Fitxer((Instr, C1, C2, C3));
	end Genera;




   procedure inici_gci is

   		Iv : Info_Var;
		Ip : Info_Proc;
		Ie : Info_Etiq;

		idv : num_var;
		idpr : num_proc;
		ide : num_etiq;

		Idn, IdBool, Idchar, Idint, Idstr, Ida : Id_Nom;

		D : descrip;
		dt : descriptipus;

		Error : Boolean;

   begin

   		Crea_Fitxer(Nom_Fitxer); --c3a
		Pila_Buida(Pproc);
		Empilar(Pproc, Proc_Nul);


		--constants inicials
		Posa_Id(Tn, Idn, "_zero");
		Iv:=(
		   Id       => Idn,
		   Np       => Tp.Np,
		   Ocup     => Integer'Size / 8,
		   Desp     => 0,
		   Tsub     => Tsent,
		   Param    => False,
		   Const    => True,
		   Valconst => 0
		   );
		Posa(Tv, Iv, Zero);


		--Posa_Id(Tn, "_uno", Idn);
		--Iv:=(
		--   Id       => Idn,
		--   Np       => Tp.Np,
		--   Ocup     => Integer'Size / 8,
		--   Desp     => 0,
		--   Tsub     => Tsent,
		--   Param    => False,
		--   Const    => True,
		--   Valconst => 1
		--   );
		--Posa(Tv, Iv, Uno);


		Posa_Id(Tn, Idn, "_menysu");
		Iv:=(
		   Id       => Idn,
		   Np       => Tp.Np,
		   Ocup     => Integer'Size / 8,
		   Desp     => 0,
		   Tsub     => Tsent,
		   Param    => False,
		   Const    => True,
		   Valconst => -1
		   );
		Posa(Tv, Iv, MenysU);



		--boolean
		Posa_Id(Tn, IdBool, "boolean");
		Dt:=(
		   Tsbool,
		   Ocup => Integer'Size / 8,
		   Linf => -1,
		   Lsup => 0
		   );

		D:=(
		   Td => Dtipo,
		   Dt => Dt
		   );
		Posa(Ts, Idbool, D, Error);


		--true
		Posa_Id(Tn, Idn, "true");
		Iv:=(
		   Id       => Idn,
		   Np       => Tp.Np,
		   Ocup     => Integer'Size / 8,
		   Desp     => 0,
		   Tsub     => Tsbool,
		   Param    => False,
		   Const    => True,
		   Valconst => - 1
		   );
		Posa(Tv, Iv, Idv);

		D:=(
		   Td => Dconst,
		   Tc => Idbool,
		   Vc => Idv
		   );
		Posa(Ts, Idn, D, Error);

		--false
		Posa_Id(Tn, Idn, "false");
		Iv.Id := Idn;
		Dv.Valconst := 0;
		Posa(Tv, Iv, Idv);
		D.Vc := Idv;
		Posa(Ts, Idn, D, Error);



		--character
		Posa_Id(Tn, Idchar, "character");
		Dt:=(
		   Ts   => Tscar,
		   Ocup => Integer'Size / 8,
		   Linf => Character'Pos (Character'First),
		   Lsup => Character'Pos (Character'Last)
		   );

		D:=(
		   Td => Dtipo,
		   Dt => Dt
		   );
		Posa(Ts, Idchar, D, Error);


		--integer
		Posa_Id(Tn, Idint, "integer");
		Dt:=(
		   Ts   => Tsent,
		   Ocup => Integer'Size / 8,
		   Linf => Valor_Const (Integer'First),
		   Lsup => Valor_Const (Integer'Last)
		   );

		D:=(
		   Td => Dtipo,
		   Dt => Dt
		   );
		Posa(Ts, Idint, D, Error);


		--string
		Posa_Id(Tn, Idstr, "string");
		Dt:=(
		   Ts    => Tsarr,
		   Ocup  => 32 * Integer'Size,
		   --256 caracteres maximo:
		   --(256/8)*integer'size
		   TCamp => Idchar,
		   Base  => 0
		   );

		D:=(
		   Td => Dtipo,
		   Dt => Dt
		   );
		Posa (Ts, Idstr, D, Error);



		-- FUNCIONES
		--puti
		Posa_Id(Tn, Idn, "puti");
		Ipr:=(
		   Idn         => Idn,
		   Prof        => 0,
		   Ocup_Var    => 0,
		   Ocup_Param  => 4,
		   Etiq        => Etiq_Nul
		   );
		Posa(Tp, Ipr, Idpr);

		Ie:=(
		   TipE => Etiq_Proc,
		   Idpr     => Idpr
		   );
		Posa(Te, Ie, Ide);
		Ipr.Etiq := Ide;

		Modif_Descripcio(Tp, Idpr, Ipr);
		D:=(
		   Td => Dproc,
		   Np => Idpr
		   );
		Posa(Ts, Idn, D, Error);

		Posa_Id(Tn, Ida, "_arg_puti");
		Dv:=(
		   Id        => Ida,
		   Np        => Idpr,
		   Ocup      => Integer'Size / 8,
		   Desp      => Ipr.Ocup_Param,
		   Tsub      => Tsent,
		   Param     => True,
		   Const     => False,
		   Valconst => 0
		   );
		Posa(Tv, Iv, Idv);
		D:=(
		   Td   => Darg,
		   Targ => Idint,
		   Narg => Idv
		   );

		Posa(Ts, Ida, D, Error);
		Posa_Arg(Ts, Idn, Ida, D, Error);
		Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;

	

		--geti
		Posa_Id(Tn, Idn, "geti");
		Ipr:=(
		   Idn        => Idn,
		   Prof       => 0,
		   Ocup_Var   => 0,
		   Ocup_Param => 4,
		   Etiq       => Ide
		   );
		Posa(Tp, Ipr, Idpr);
		Ie:=(
		   TipE => Etiq_Proc,
		   Idpr => Idpr
		   );
		Posa(Te, Ie, Ide);
		Ipr.Etiq:=Ide;
		Modif_Descripcio(Tp, Idpr, Ipr);
		D:=(
		   Td => Dproc,
		   Np => Idpr
		   );
		Posa(Ts, Idn, D, Error);
		Posa_Id(Tn, Ida, "_arg_geti");
		Iv:=(
		   Id        => Ida,
		   Np        => Idpr,
		   Ocup      => Integer'Size / 8,
		   Desp      => Ipr.Ocup_Param,
		   Tsub      => Tsent,
		   Param     => True,
		   Const     => False,
		   Valconst => 0
		   );
		Posa(Tv, Iv, Idv);
		D:=(
		   Td   => Darg,
		   Targ => Idint,
		   Narg => Idv
		   );
		Posa(Ts, Ida, D, Error);
		Posa_Arg(Ts, Idn, Ida, D, Error);
		Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;


		--putc
		Posa_Id(Tn, Idn, "putc");
		Ipr:=(
		   Idn        => Idn,
		   Prof       => 0,
		   Ocup_Var   => 0,
		   Ocup_Param => 4,
		   Etiq       => Ide
		   );
		Posa(Tp, Ipr, Idpr);
		Ie:=(
		   TipE => Etiq_Proc,
		   Idpr => Idpr
		   );
		Posa(Te, Ie, Ide);
		Ipr.Etiq := Ide;
		Modif_Descripcio(Tp, Idpr, Ipr);
		D:=(
		   Td => Dproc,
		   Np => Idpr
		   );
		Posa(Ts, Idn, D, Error);
		Posa_Id(Tn, Ida, "_arg_putc");
		Iv:=(
		   Id       => Ida,
		   Np       => Idpr,
		   Ocup     => Integer'Size / 8,
		   Desp     => Ipr.Ocup_Param,
		   Tsub     => Tscar,
		   Param    => True,
		   Const    => False,
		   Valconst => 0
		   );
		Posa(Tv, Iv, Idv);
		D:=(
		   Td   => Darg,
		   Targ => Idchar,
		   Narg => Idv
		   );
		Posa(Ts, Ida, D, Error);
		Posa_Arg(Ts, Idn, Ida, D, Error);
		Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;



		--getc
		Posa_Id(Tn, Idn, "getc");
		Ipr:=(
		   Idn        => Idn,
		   Prof       => 0,
		   Ocup_Var   => 0,
		   Ocup_Param => 4,
		   Etiq       => Ide
		   );
		Posa(Tp, Ipr, Idpr);
		Ie:=(
		   TipE => Etiq_Proc,
		   Idpr => Idpr
		   );
		Posa(Te, Ie, Ide);
		Ipr.Etiq:=Ide;
		Modif_Descripcio(Tp, Idpr, Ipr);
		D:=(
		   Td => Dproc,
		   Np => Idpr
		   );
		Posa(Ts, Idn, D, Error);
		Posa_Id(Tn, Ida, "_arg_getc");
		Iv:=(
		   Id       => Ida,
		   Np       => Idpr,
		   Ocup     => Integer'Size / 8,
		   Desp     => Ipr.Ocup_Param,
		   Tsub     => Tscar,
		   Param    => True,
		   Const    => False,
		   Valconst => 0
		   );
		Posa(Tv, Iv, Idv);
		D:=(
		   Td   => Darg,
		   Targ => Idchar,
		   Narg => Idv
		   );
		Posa(Ts, Ida, D, Error);
		Posa_Arg(Ts, Idn, Ida, D, Error);
		Ipr.Ocup_Param := Ipr.Ocup_Param + Iv.Ocup;






   end inici_gci;




   procedure gci_Programa
     (A : in Pnode) is
   begin
      --Entrabloc(Ts);
      gci_Decprocediment(A);

      --Surtbloc(Ts);
	 
      Tanca_Fitxer;
   end gci_Programa;


   procedure gci_Decprocediment
     (A : in Pnode) is

      Encap : Pnode renames A.Fe5;
      Decls : Pnode renames A.Fc5;
      Bloc : Pnode renames A.Fd5;
      Id : Pnode renames A.Fid5;
      Id_Proc : Id_Nom renames A.Fid5.Id12;

	  eip : num_etiq;
	  C1 : camp;

	  Ipr : Info_Proc;
      dproc : Descrip;

	  Idprinvocador,
	  Idprinvocat : Num_Proc;

   begin
      Put_line("CT_Decprocediment");
      gci_Encap(Encap, Id_Proc);

      if Decls.Tipus = Declaracions then
         gci_Declaracions(Decls); --pendent, arrays, vars i constants
      end if;
	
	  --Necesario? PRMB
	  eip := Nova_Etiq;
	  C1 := (Tc => Etiq, Ide => eip);
	  Genera(Etiqueta, C1);

	  dproc:=Cons(Ts, Id_Proc);
	  C1:=(
		Tc => Proc,
		Idp => dproc.np);

	  Ipr := Consulta(Tp, dproc.np);
	  Genera(Preamb, C1);

	  --
      gci_Bloc(Bloc);
      Surtbloc(Ts);
	  --

	  --RTN
	  Cim(Pproc, Idprinvocat);
	  C1:=(
		 Tc => Proc,
		 Idp => Idprinvocat
	  );
	  Genera(Rtn, C1);

	  Desempilar(Pproc);
	  Cim(Pproc, Idprinvocador);

	  if Idprinvocador = Proc_Nul then
	  	C1:=(
		  Tc => Etiq,
		  Ide => Tp.Tp(Idprinvocat).Etiq
		);
		Genera(Global, C1);
	  end if;


   end gci_Decprocediment;


   procedure gci_Encap
     (A : in Pnode;
      I : in Id_Nom) is

      dproc : Descrip;
      
   begin
      Put_line("CT_ENCAP");
	  dproc:=Cons(Ts, I);
	  empilar(Pproc, dproc.Np);
   end gci_Encap;


   procedure gci_Bloc
     (A : in Pnode) is

      D : Descrip;
      T : Tipussubjacent;
      Idbase : Id_Nom;
      Idtipus : Id_Nom;

      Tsexp : Tipussubjacent;
      Idexp : Id_Nom;
      Tsvar : Tipussubjacent;
      Idvar : Id_Nom;

      Idres, 
	  Iddesp,
	  Idr,
	  Idd: num_var;

   begin
      case (A.Tipus) is
         when Bloc =>
            gci_Bloc(A.Fe1);
            gci_Bloc(A.Fd1);
         when Repeticio =>
            gci_Srep(A);
         when Identificador => --crida a procediment sense parametres
            Put_Line("CT_Bloc : IDENTIFICADOR");
            gci_identificador(A, Idres, Iddesp, Idtipus);
         when Fireferencia =>
            gci_Referencia_Proc(A, T, Idbase);
         when condicionalS =>
            gci_Sconds(A);
         when condicionalC =>
            gci_Scondc(A);
         when Assignacio =>
            gci_Referencia_Var(A.Fe1,Idr, Idd);
            gci_Expressio(A.Fd1, Idres, Iddesp);
			gci_Assignacio(Idr, Idd, Idres, Iddesp);
         when others => null;
      end case;
   end gci_Bloc;

	
   procedure gci_Assignacio(
	  Idref, 
	  Iddref,
	  Idrexp,
	  Iddexp: in num_var) is

	   C1,
	   C2,
	   C3,
	   C4,
	   C5 : Camp;
	   T : Num_Var;
   begin

	   C1:=(
		   Tc => Var,
		   Idv => Idref
		   );
	   C2:=(
		   Tc => Var,
		   Idv => Iddref
		   );
	   C3:=(
		   Tc => Var,
		   Idv => Idrexp
		   );
	   C4:=(
	   		Tc => Var,
	   		Idv => Iddexp
	   	   );


		cim(pproc, idproc);
		Novavar(Tv, idproc, T);
		C5:=(
		   Tc => Var,
		   Idv => T
		   );


		if Iddref = Var_Nul then
		   if Iddexp = Var_Nul then
			  Genera(Copia, C1, C3);
		   else
			  Genera(Consindex, C1, C3, C4);
		   end if;
		else
		   if Iddexp = Var_Nul then
			  Genera(Asigindex, C1, C2, C3);
		   else
			  Genera(Consindex, C5, C3, C4);
			  Genera(Asigindex, C1, C2, C5);
		   end if;
		end if;

   end gci_Assignacio;


	--Procediments
   procedure gci_Referencia_Proc --InComplet
     (A : in Pnode;
      Idproc : out num_proc) is

      	Tipus : Tipusnode renames A.Tipus;
		dproc : Descrip;

		Prm : T_Param;
		c1, c2 : camp;

   begin
      case Tipus is
         when Identificador => --R -> id
		 			
			dproc := cons(ts, A.Fid5.Id12);
			Idproc := dproc.np;

         when Fireferencia => -- R -> pri)
            gci_Ref_Pri(A.F6);
			
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
             	Idp => Idproc
   			);
			genera(Call, c1);

         when others =>
            Put_Line("ERROR (DEBUG) gci-referencia: node "&
                       "no reconegut");

      end case;

   end gci_Referencia_Proc;


   procedure gci_Ref_Pri 
     (A : in Pnode;
	  Idproc : out num_proc) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

		Idres, Iddesp : num_var;
		prm:  T_Param;
   begin
      case Tipus is
         when Pri => --pri -> pri,E
            Put_Line("CT-ref_pri: pri");
            gci_Ref_Pri(Fesq,IdProc);
            gci_Expressio(Fdret, Idres, Iddesp);
			
			prm.base := Idres;
			prm.despl := Iddesp;
			pbuida(pparam);
			empilar(pparam, prm);

         when Encappri => -- pri -> R(E
            Put_Line("CT-ref_pri: encappri");
            gci_Referencia_Proc(Fesq, Idproc);
            gci_Expressio(Fdret, Idres, Iddesp);
			prm.base := Idres;	
		    prm.despl := Iddesp;
            empilar(pparam, prm);
         when others =>
            Put_Line("ERROR (DEBUG) gci-ref_pri: tipus no "&
                       "reconegut");
      end case;
   end gci_Ref_Pri;


   procedure gci_Identificador -- correcte
     (A : in Pnode;
      Idres, Iddesp: out num_var;
      Idtipus : out Id_Nom) is

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
         when Dvar => -- R -> id
			Idres := d.nv;
			Iddesp := var_nul;
			Idtipus := d.tr;

         when Dconst =>
			cim(pproc, idproc);
		 	Novavar(Tv, idproc, Idv);

			C1:=(
			     Tc => Var,
			     Idv => Idv
			);

			C2:=(
			     Tc => Const,
			     Idc => d.vc
			);

			genera(copia, c1, c2);

			Idres:= idv;
			Iddesp:= var_nul;
			Idtipus:= d.tc;

         when Dproc => 

			D:=cons(ts, id);
			c1:=(
			 Tc => Proc,
		     Idp => D.Np
	   		);
			genera(Call, c1);

         when others =>
			null;

      end case;

      Put_line("gci_id: Tipus: "&Idtipus'img);

	end gci_Identificador;

	
   procedure gci_Constant
     (A : in Pnode;
      Idres : out Num_var) is

      Tatr : Tipus_Atribut renames A.Tconst;
      idproc : num_proc;
      D : Descrip;
	  T1 : num_var;

   begin
		Put_line("CT_CONSTANT");
		cim(pproc, idproc);
     
      case (Tatr) is
         when A_Lit_C =>
            T := Tscar;
         when A_Lit_N =>
            T := Tsent;
         when others => null;
	  end case;

	  Novaconst(Tv, Tatr.val, T, idproc, Idres);

   end gci_Constant;	


   procedure gci_Expressio
     (A : in Pnode;
      Idr, Idd: out num_var) is

      Tipus : Tipusnode renames A.Tipus;
      Idtipus : Id_Nom;

   begin
	  Idd := var_nul;

      Put_line("CT_EXP: "&Tipus'img );
      case Tipus is
         when Expressio =>
            gci_Expressioc(A, Idr, Idd);
         when ExpressioUnaria =>
           gci_Expressiou(A, Idr, Idd);
         when Identificador =>
            gci_Identificador(A, Idr, Idd, Idtipus); --Idtipus??
         when Const =>
            gci_Constant(A, Idr);

         when Fireferencia | Referencia =>
            gci_Referencia_Var(A, Idr, Idd); 
         when others =>
            Put_Line("ERROR (DEBUG) gci-exp: tipus expressio no "&
                       "trobat :S "&Tipus'Img);
      end case;

   end gci_Expressio;


   procedure gci_Expressioc --comprovar parametres
     (A : in Pnode;
      Idres,Idresdesp: out num_var) is

      Fesq : Pnode renames A.Fe3;
      Fdret : Pnode renames A.Fd3;
      Op : Operacio renames A.Op3;

      Idesq,
      Iddret,
	  IddespE,
	  IddespD : num_var;

   begin
      Put_line("gci_EXPRESSIOC");
      --Analitzam l'operand esquerra
      gci_Expressio(Fesq, Idesq,IddespE);
      --Analitzam l'operand dret
      gci_Expressio(Fdret, Iddret,IddespD);
      -- Comparam els tipus
      case Op is

         when Unio | Interseccio =>
            gci_Exp_Logica(Idesq, Iddret, IddespE, IddespD, Idres, Idresdesp, Op);

         when Menor | Menorig | Major | Majorig
           | Igual | Distint =>
            gci_Exp_Relacional(Idesq, Iddret, IddespE, IddespD, Idres, Idresdesp, Op);

         when Suma | Resta | Mult | Div | Modul =>
            gci_Exp_Aritmetica(Idesq, Iddret, IddespE, IddespD, Idres, Idresdesp, Op);

         when others =>
            null;
      end case;

	end gci_Expressioc;
	


	procedure gci_Exp_Relacional --manca acabar d'entendre el final
     (IdResE, IdResD, IddespE, IddespD : in num_var;
	  IdResultExp, IddespExp :   out num_var;
      Op : in Operacio) is

		T1,
		T2,
		T3 : num_Var := Var_Nul;

		Emig,
		Efi : num_Etiq;

		C1,
		C2,
		C3 : Camp;

	  	idproc : num_proc := proc_nul;

	begin
   
	   if IddespE = Var_Nul then
		  T1:= IdResE;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T1);
			
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => IdResE
		     );
		  C3:=(
		     Tc => Var,
		     Idv => IddespE
		     );
		  Genera(Consindex,C1,C2,C3);

	   end if;

	   if IddespD = Var_Nul then
		  T2 := IdResD;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T2);
		  C1:=(
		     Tc  => Var,
		     Idv => T2
		     );
		  C2:=(
		     Tc  => Var,
		     Idv => IdResD
		     );
		  C3:=(
		     Tc  => Var,
		     Idv => IddespD);
		  Genera(Consindice,C1,C2,C3);
	   end if;

		Emig:=Nova_Etiq;
		Efi:=Nova_Etiq;

		C1:=(
		   Tc => Var,
		   Idv => T1
		   );
		C2:=(
		   Tc => Var,
		   Idv => T2
		   );
		C3:=( --Al loro, puesto de nuestra manera. C3 va la etiqueta
		   Tc => Etiq,
		   Ide => Emig
		   );

	case Op is
		when Menor => Genera(Menor, C1, C2, C3);
		when Menorigual => Genera(Menorigual, C1, C2, C3);
		when Igual => Genera(Igual,C1,C2,C3);
		when Majorigual => Genera(Majorigual, C1, C2, C3);
		when Major => Genera(Major, C1, C2, C3);
		when Diferent => Genera(Diferent, C1, C2, C3);
		when others => null;
	end case;

    cim(pproc, idproc);
	Novavar(Tv, Idproc, T3);

	C1:=(
	   Tc => Var,
	   Idv => T3
	   );
	C2:=(
	   Tc => Const,
	   Idc => Zero
	   );

	Genera(Copia, C1, C2);

	C3:=(
	   Tc => Etiq,
	   Ide => Efi
	);
	Genera(Branc_Inc, C3);

	C3.Ide:=Emig;
	Genera(Etiqueta, C3);

	C2.Idc:=MenysU;
	Genera(Copia, C1, C2);

	C3.Ide:=Efi;
	Genera(Etiqueta, C3);

	IdResultExp:=T3;
	IddespExp:=Var_Nul;


	end gci_Exp_Relacional;
	


	procedure gci_Exp_Logica 
     (IdResE, IdResD, IddespE, IddespD : in num_var;
	  IdResultExp, IddespExp :   out num_var;
      Op : in Operacio) is

		T1,
		T2,
		T3 : num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;
	  idproc : num_proc := proc_nul;

	begin
	   
	   if IddespE = Var_Nul then
		  T1:= IdResE;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T1);
			
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => IdResE
		     );
		  C3:=(
		     Tc => Var,
		     Idv => IddespE
		     );
		  Genera(Consindex,C1,C2,C3);

	   end if;

	   if IddespD = Var_Nul then
		  T2 := IdResD;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T2);
		  C1:=(
		     Tc  => Var,
		     Idv => T2
		     );
		  C2:=(
		     Tc  => Var,
		     Idv => IdResD
		     );
		  C3:=(
		     Tc  => Var,
		     Idv => IddespD);
		Genera(Consindice,C1,C2,C3);
	   end if;

	 cim(pproc, idproc);
	 Novavar(Tv, idproc, T3);
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
		when Unio => Genera(Op_Or,C1,C2,C3);
		when Interseccio => Genera(Op_And,C1,C2,C3);
		when others => null;
	end case;
	
	IdResultExp := T3;
	IddespExp := Var_Nul;

   end gci_Exp_Logica;


	procedure gci_Exp_Aritmetica 
     (IdResE, IdResD, IddespE, IddespD : in num_var;
	  IdResultExp, IddespExp : out num_var;
      Op : in Operacio) is

		T1,
		T2,
		T3 : num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;
	  idproc : num_proc := proc_nul;

	begin
	   
	   if IddespE = Var_Nul then
		  T1:= IdResE;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T1);
			
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => IdResE
		     );
		  C3:=(
		     Tc => Var,
		     Idv => IddespE
		     );
		  Genera(Consindex,C1,C2,C3);

	   end if;

	   if IddespD = Var_Nul then
		  T2 := IdResD;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T2);
		  C1:=(
		     Tc  => Var,
		     Idv => T2
		     );
		  C2:=(
		     Tc  => Var,
		     Idv => IdResD
		     );
		  C3:=(
		     Tc  => Var,
		     Idv => IddespD);
		  Genera(Consindice,C1,C2,C3);
	   end if;

	 cim(pproc, idproc);
	 Novavar(Tv, idproc, T3);
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
		when Suma => Genera(Suma,C1,C2,C3);
		when Resta => Genera(Resta,C1,C2,C3);
		when Producte => Genera(Producte,C1,C2,C3);
		when Divisio => Genera(Divisio,C1,C2,C3);
		when Modul => Genera(Modul,C1,C2,C3);
		when others => null;
	end case;
	
	IdResultExp := T3;
	IddespExp := Var_Nul;

   end gci_Exp_Aritmetica;


   procedure gci_Expressiou
     (A : in Pnode;
      Idr, Idd : out num_var) is

      Fdret : Pnode renames A.F4;
      Op : Operacio renames A.Op4;
      Tdret : Tipussubjacent;
      Iddret : Id_Nom;

   begin
      Put_line("CT_EXPRESSIOU");
      gci_Expressio(Fdret, Idr, Idd);
      case Op is
         when Resta =>
            gci_Exp_Negacio(Tdret, Iddret, T, Idtipus);
         when Negacio =>
            gci_Exp_Neglogica(Tdret, Iddret, T, Idtipus);
         when others =>
            null;
      end case;

   end gci_Expressiou;


   procedure gci_Exp_Negacio
     (idRes, Iddesp : in num_var;
	  IdresultExp, IddespExp : out num_var) is

		T1,
		T2 : num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;
	    idproc : num_proc := proc_nul;

	begin
	   
	   if Iddesp = Var_Nul then
		  T1:= IdRes;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T1);
			
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => IdRes
		     );
		  C3:=(
		     Tc => Var,
		     Idv => Iddesp
		     );

		  Genera(Consindex, C1, C2, C3);

	   end if;

		Novavar(Tv, idproc, T2);
		C1:=(
		   Tc => Var,
		   Idv => T2
		   );
		C2:=(
		   Tc => Var,
		   Idv => T1
		   );


	   Genera(Negacio, C1, C2);

	   IdResultExp := T2;
	   IddespExp := Var_Nul;

   end gci_Exp_Negacio;


   procedure gci_Exp_Neglogica
     (idRes, Iddesp : in num_var;
	  IdresultExp, IddespExp : out num_var) is

		T1,
		T2 : num_Var := Var_Nul;
		C1,
		C2,
		C3 : Camp;
	    idproc : num_proc := proc_nul;

	begin
	   
	   if Iddesp = Var_Nul then
		  T1:= IdRes;
	   else
		  cim(pproc, idproc);
		  Novavar(Tv, idproc, T1);
			
		  C1:=(
		     Tc => Var,
		     Idv => T1
		     );
		  C2:=(
		     Tc => Var,
		     Idv => IdRes
		     );
		  C3:=(
		     Tc => Var,
		     Idv => Iddesp
		     );

		  Genera(Consindex, C1, C2, C3);

	   end if;


		Novavar(Tv, idproc, T2);
		C1:=(
		   Tc => Var,
		   Idv => T2
		   );
		C2:=(
		   Tc => Var,
		   Idv => T1
		   );

	   Genera(Op_Not, C1, C2);

	   IdResultExp := T2;
	   IddespExp := Var_Nul;

   end gci_Exp_Neglogica;


   procedure gci_Referencia_Var --Fet xo amb errors al enccapri (da.b no
	--existeix a la practica)
     (A : in Pnode;
      Idres, Iddesp: out Num_var; 
	  Idtipus : out Id_Nom) is

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
				C3.Idc:=dtc.td.ocup; 
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
	
         when others => null;
      end case;

   end gci_Referencia_Var;


--Arrays
   procedure gci_Ref_Pri --"Correcte"
     (A : in Pnode;
      Idres, Iddesp, Idbase : out Num_var;
	   Idtipus : out Id_Nom;
      It_Idx : out Cursor_Idx) is

      Tipus : Tipusnode renames A.Tipus;
      Fesq : Pnode renames A.Fe1;
      Fdret : Pnode renames A.Fd1;

      IdresE, iddespE : Num_var := Var_Nul;

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
			if IddespE = var_nul then
				
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
      Idres, Iddesp: out num_var;
	  Idtipus : out Id_Nom) is

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


   procedure gci_Sconds
     (A : in Pnode) is

      Cond : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

      Idres, Iddesp : num_var;

	  C1, C2, C3 : camp;
	  efals: num_etiq;

	  idproc : num_proc;
   	  T1 : num_Var := Var_Nul;

   begin

	  efals := nova_etiq;

      gci_Expressio(Cond, Idres, Iddesp);

	  if Iddesp = Var_Nul then
	  	C2:=(
		  	Tc => Var,
		  	Idv => Idres
		);
	  else
	  	cim(pproc, idproc);
	   	Novavar(Tv, idproc, T1);
	   	C1:=(
		  Tc => Var,
		  Idv => T1
		  );
	   	C2:=(
		  Tc => Var,
		  Idv => Idres
		  );
	    C3:=(
		  Tc => Var,
		  Idv => Iddesp
		  );
	    Genera(Consindex, C1, C2, C3);
	    C2:=(
		  Tc => Var,
		  Idv => T1
		  );
	  end if;

		-- if C1 = C2 then Efals 
		C3:=(
		   Tc => Etiq,
		   Ide => Efals
		   );
		C1:=(
		   Tc => Const,
		   Idc => Zero
		   );
		Genera(Igual, C2, C1, C3);
	
      gci_Bloc(Bloc);


	  C1:=(
		 Tc => Etiq,
		 Ide => efals
		 );
	  Genera(Etiqueta, C1);

   end gci_Sconds;


  procedure gci_Scondc
     (A : in Pnode) is

      Cond : Pnode renames A.Fe2;
      Bloc : Pnode renames A.fc2;
      Blocelse : Pnode renames A.fd2;

      Idres, Iddesp : num_var;

	  C1, C2, C3 : camp;
	  efals, efinal: num_etiq;

	  idproc : num_proc;
   	  T1 : num_Var := Var_Nul;

   begin

	  efals := nova_etiq;
	  efinal := nova_etiq;

      Ct_Expressio(Cond, Idres, Iddesp); ----

	  if Iddesp = Var_Nul then
	  	C2:=(
		  	Tc => Var,
		  	Idv => Idres
		);
	  else
	  	cim(pproc, idproc);
	   	Novavar(Tv, idproc, T1);
	   	C1:=(
		  Tc => Var,
		  Idv => T1
		  );
	   	C2:=(
		  Tc => Var,
		  Idv => Idres
		  );
	    C3:=(
		  Tc => Var,
		  Idv => Iddesp
		  );
	    Genera(Consindex, C1, C2, C3);
	    C2:=(
		  Tc => Var,
		  Idv => T1
		  );
	  end if;

		-- if C1 = C2 then Efals 
		C3:=(
		   Tc => Etiq,
		   Ide => Efals
		   );
		C1:=(
		   Tc => Const,
		   Idc => Zero
		   );
		Genera(Igual, C2, C1, C3);

      Ct_Bloc(Bloc); ------

	  C1:=(
   	  	Tc => Etiq,
   		Ide => efinal
   		);
	  Genera(Branc_Inc, C1);

	  C1.Ide:=efals;
	  Genera(Etiqueta, C);

      Ct_Bloc(Blocelse); ----

	  C1:=(
	    Tc => Etiq,
	    Ide => efinal
	    );
	  Genera(Etiqueta, C1);

   end gci_Scondc;


   procedure gci_Srep
     (A : in Pnode) is

      Exp : Pnode renames A.Fe1;
      Bloc : Pnode renames A.fd1;

      Idres, Iddesp : num_var;

	  C1, C2, C3 : camp;
	  einicial, efinal: num_etiq;

	  idproc : num_proc;
   	  T1 : num_Var := Var_Nul;

   begin

	  einicial : nova_etiq;
	  efinal : nova_etiq;

	  C1:=(
   		Tc => Etiq,
   		Ide => einicial
   		);
	  Genera(Etiqueta, C1);

      gci_Expressio(Exp, Idres, Iddesp); ------

		C1:=(
		   Tc => Etiq,
		   Ide => efinal
		   );

		if Iddesp = Var_Nul then
		   C2:=(
			  Tc => Var,
			  Idv => Idres
			  );
		else
		   cim(pproc, idproc);
		   Novavar(Tv, idproc, T1);
		   C1:=(
			  Tc => Var,
			  Idv => T1
			  );
		   C2:=(
			  Tc => Var,
			  Idv => idres
			  );
		   C3:=(
			  Tc => Var,
			  Idv => iddesp
			  );
		   Genera(ConsIndex, C1, C2, C3);
		   C2:=(
			  Tc => Var,
			  Idv => T1
			  );
		end if;

		C3:=(
		   Tc => Const,
		   Idc => Zero
		   );
		Genera(Igual, C2, C3, C1);  --if exp = 0 then etiqueta

      gci_Bloc(Bloc);  -----------

	  C1 := (
		 Tc => Etiq,
		 Ide => einicial
	    );
	  Genera(Branc_Inc, C1);
	  C1.Ide := efinal;
	  Genera(Etiqueta, C1);

   end gci_Srep;

end semantica.gci;

