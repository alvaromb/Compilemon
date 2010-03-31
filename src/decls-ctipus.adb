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
      --printts(ts);
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

   begin
        Put_line("CT_DECLARACIONS");
      if Decls.Tipus = Declaracions then
         Ct_Declaracions(Decls);
      end if;

     Cons_Tnode(Decl, Tnode);
      case Tnode is
         when Dvariable   => Ct_Decvar(Decl);
         when Dconstant   => Ct_Decconst(Decl);
         --when Dcoleccio   => Ct_Deccol(Decl);
         --when Dregistre   => Ct_Decregistre(Decl);
         when Dsubrang    => Ct_Decsubrang(Decl);
         --when Procediment => Ct_Procediment(Decl);
         when others => raise Tdeclaracio_Inexistent;
      end case;

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
      Idtipus : Id_nom;
      E : Boolean;

   begin
      Put_line("CT_DECVAR");
      Ct_Declsvar(Dvariable, Tipus, Idtipus);
      Posa_Idvar(Id, Idtipus, E);

   end Ct_Decvar;


   procedure Ct_Declsvar
     (A : in Pnode;
      T : out Descrip;
      Idtipus : out Id_nom ) is

      Tnode : Tipusnode renames A.Tipus;
      Fdret : Pnode renames A.Fd1;
      Id : Id_Nom renames A.Fe1.Id12;
      E : Boolean;

      Tassig : Descrip; --ASSIGNACIO PROVISIONAL
      Tdecl : Descrip;

      -- variables per la crida a procediment
      Tps : Tipussubjacent;
      Ids : Id_Nom;

   begin
      Put_line("CT_DECLSVAR");
      if Tnode = Asigvalvar then
         Put_Line("VERBOSE: passam a assignacio de variable");

         Tdecl := Cons(Ts, Id);
         if (Tdecl.Td /= Dnula) then --la id existeix
            if (Fdret.Tipus /= Tnul) then
               Ct_Expressio(Fdret, Tps, Ids);
               if (Id /= Ids) and (Ids /= Id_Nul) then
                  --si ids es nul s'han de mirar els tipus subjacents
                  PUT_LINE("VERBOSE: "&Ids'img);
                  raise Tassig_Diferent;
               elsif (Ids = Id_Nul) and (Tps /= Tdecl.Dt.Tt) then
                  raise Tassig_Diferent;
               end if;
            end if;
            T := Tdecl;
            Idtipus := Id;
         else
            raise TNo_Existent;
         end if;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(Fdret, T, Idtipus);
         Put_Line("VERBOSE: diferents variables amb mateix tipus...");
         Posa_Idvar(Id, Idtipus, E);
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

      -- variables per la crida a expressio
      Tps : Tipussubjacent;
      Ids : Id_Nom;

   begin
      Tdecl := Cons(Ts, Idtipus);
      if (Tdecl.Td /= Dnula) then
         Ct_Expressio(Val, Tps, Ids);
         if (Idtipus /= Ids) and (Ids /= Id_Nul) then
            Put_Line("ERROR CT-const: tipus assig diferent");

         elsif (Ids = Id_Nul) and (Tps /= Tdecl.Dt.Tt) then
            Put_Line("ERROR CT-const: tipus subj diferent");

         end if;

         -- Guardam la constant
         Posa(Ts, Id, Tdecl, E);
         if E then
            Put_Line("ERROR-CT-const: var ja existent");
         end if;
      else
         raise Tno_Existent;
      end if;

   exception
      when Tno_Existent =>
         Put_Line("ERROR CT-const: el tipus no existeix");
   end Ct_Decconst;


   procedure Ct_Decsubrang
     (A : in Pnode) is

      Idsubrang : Id_Nom renames A.Fe5.Id12;
      Idtsubrang : Id_Nom renames A.Fc5.Id12;
      Idtipus : Id_nom;

      --Suposarem que limit nomes pot ser 'const' o una constant
      Rang_Esq : Pnode renames A.Fd5;
      Rang_Dret : Pnode renames A.Fid5;
      Tsesq : Tipussubjacent;
      Tsdret : Tipussubjacent;
      T : Tipussubjacent;
      Idesq : Id_Nom;
      Iddret : Id_Nom;

      Tdecl : Descrip;
      Tresq : Descrip;
	  Trdret : Descrip;

      Valesq : Valor;
      Valdret : Valor;

	  Tdescrip_decl : Descrip;
	  Tdescript_decl : Descriptipus;

	  E : Boolean;

   begin
	Tdecl := Cons(Ts, Idtsubrang);
	--Miram si el tipus sobre el qual es vol crear
	if (Tdecl.Td /= Dnula) then
		
		if(Tdecl.Td = Dtipus) and (Tdecl.dt.tt = tsbool 
                                        or  Tdecl.dt.tt = tscar
                                        or  Tdecl.dt.tt = tsent ) then	

			--Miram el fill esquerra
			if (Rang_Esq.Tipus = Const) then

				Ct_Constant(Rang_Esq, Tsesq, Idesq);
				Valesq := Rang_Esq.val;

			elsif( Rang_Esq.Tipus = Identificador) then
				
				Tresq := cons(ts,Rang_Esq.Id12);
				if(Tresq.td = dconst) then
					Ct_Identificador(Rang_Esq, Tsesq, Idesq);
					Valesq := Tresq.vc;
				else
				  Put_Line("ERROR CT-decsubrang: El limit esquerra es una variable no constant");		
				end if;
			else   Put_Line("ERROR CT-decsubrang: El limit esq no es de cap tipus valid");
			end if;

			--Miram el fill dret
			if (Rang_Dret.Tipus = Const) then

				Ct_Constant(Rang_Dret, Tsdret, Iddret);
				Valdret := Rang_Dret.val;

			elsif( Rang_dret.Tipus = Identificador) then
				
				Trdret := cons(ts, Rang_Dret.Id12);
				if(Trdret.td = dconst) then
					Ct_Identificador(Rang_Dret, Tsdret, Iddret);
					Valdret := Trdret.vc;
				else
				  Put_Line("ERROR CT-decsubrang: El limit dret es una variable no constant");
		
				end if;
			else   Put_Line("ERROR CT-decsubrang: El limit dret no es de cap tipus valid");

			end if;

			-- Comparam els tipus
			if (Idesq /= Id_Nul) and (Iddret /= Id_Nul) then
				 if (Idesq = Iddret) then
				    T := Tsesq;
				    Idtipus := Idesq;

			     else Put_Line("ERROR CT-decsubrang: Els tipus assignats no coincideixen");

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
							when tsbool => Tdescript_decl := (tsbool, 4, valesq, valdret);
							when tscar => Tdescript_decl := (Tscar, 4, valesq, valdret);
							when tsent => Tdescript_decl := (Tsent, 4, valesq, valdret);
							when others => put_LINE("ERROR CT-decsubrang: ERROR UNCONTROLLED");
						end case;
						Tdescrip_decl := (Dtipus, Tdescript_decl); 
						posa(ts, Idsubrang, Tdescrip_decl, E);
						if E then
							put_line("ERROR CT-decsubrang: el tipus que intentes declarar ja existeix");
						end if;
					else
						put_line("ERROR CT-decsubrang: el rang esq es major o igual q el dret");
					end if;
				else
					put_Line("ERROR CT-decsubrang: els tipus del rang i el declarat son diferents");
				end if;
			elsif (idtipus = idtsubrang) then
				--tipus dels limits i del tipus subrang iguals
				if (valesq < valdret) then
					--rang esq menor rang dret
					case (T) is
						when tsbool => Tdescript_decl := (tsbool, 4, valesq, valdret);
						when tscar => Tdescript_decl := (Tscar, 4, valesq, valdret);
						when tsent => Tdescript_decl := (Tsent, 4, valesq, valdret);
						when others => put_LINE("ERROR CT-decsubrang: ERROR UNCONTROLLED");
					end case;
					Tdescrip_decl := (Dtipus, Tdescript_decl);
					posa(ts, Idsubrang, Tdescrip_decl, E);
					if E then
						put_line("ERROR CT-decsubrang: el tipus que intentes declarar ja existeix");
					end if;
				else
					put_line("ERROR CT-decsubrang: el rang esq es major o igual q el dret");
				end if;
			else
				put_line("ERROR CT-decsubrang: els tipus del rang i el declarat fallen");
			end if;

		else
		
			Put_Line("ERROR CT-decsubrang: tipus 'new x' x no es d'un tipus valid");
			
		end if;
		

	else
		Put_Line("ERROR CT-decsubrang: tipus 'new x' x no existeix");	
	end if;





      --Agafam els tipus dels dos rangs
      --      Ct_Constant(Rang_Esq, Tsesq, Idesq);
            --Ct_Constant(Rang_Dret, Tsdret, Iddret);

      --Comparam si son del mateix tipus
            --if (Tsesq = Tsdret) then
         --Comparam si son del mateix tipus que Idtsubrang
         --Primer miram si Idtsubrang es d'un tipus existent
        
                --  if (Tsesq = Tdecl.Dt.Tt) then
               --Els tipus del rang i el tipus de type son iguals
        --             Put_Line("seguir un poc");
               --FALTA SEGUIR AQUI
         --         else
          --           Put_Line("ERROR CT-decsubrang: tipus dels rangs i el "&
         --                       "tipus del subrang declarat son diferents");
         --         end if;
         --      else
            
        --       end if;
        --    else
        --       Put_Line("ERROR CT-decsubrang: tipus dels rangs diferents");
       --     end if;

      --Lo darrer que farem sira comprovar que
      --Idsubrang (es a dir, l'id del 'nom' del
      --subrang) no existeix ja com un altre id
      --declarat. Ho farem amb l'error E a l'hora
      --de fer el posa.
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


end Decls.Ctipus;
