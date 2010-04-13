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
      --D := (Dconst, Idb, -1, Nv);
	  D := (Dconst, Idb, -1);
      Posa(Ts, Idt, D, E);

      Posa_Id(Tn, Idf, "false");
      Nv := Nv + 1;
      --D := (Dconst, Idb, 0, Nv);
      D := (Dconst, Idb, 0);
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
		Idproc : Id_nom renames A.Fd1.Fid5.Id12;
        ida : cursor_arg;
   begin
      Ct_M1;
      Ct_Decprocediment(A.Fd1);
      ida := primer_arg(ts,Idproc);
	  if (arg_valid(ida)) then 

		put_line("Ct_Programa: El procediment principal no pot tenir params");

	  end if;
	  
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
         Put_Line("ERROR CT_Decprocediment: identificadors de procediment diferents");
      end if;

      Cons_Tnode(Decls, Tdecls);
      if Tdecls /= Tnul then
         Ct_Declaracions(Decls);
      end if;
      Ct_Bloc(Bloc);
	  surtbloc(ts);
   end Ct_Decprocediment;


   procedure Ct_Encap
     (A : in Pnode;
      I : out Id_Nom) is

      Tproc : Descrip;
      E : Boolean;
	  idx_Arg : cursor_arg;
	  ida : id_nom;
	  dn : descrip;

   begin
      Put_line("CT_ENCAP");
      if A.Tipus = Pencap then
          
         Ct_Pencap(A, I);
		 entrabloc(Ts);
		 idx_Arg := primer_arg(ts, I);
		 while arg_valid(idx_Arg) loop

			cons_arg(ts,idx_arg, ida,dn);
		    posa(ts, ida,dn,e);
			if E then
				Put_Line("ERROR CT_ENCAP: Error compilador :impossible posar param");
			end if;
		    idx_Arg := succ_arg(ts, idx_arg);
		end loop;
		 
      else
		  
         I := A.Id12; 
         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, I, Tproc, E);
		 if E then
			Put_Line("ERROR CT_ENCAP: Error el id del proccediment ja existeix");
		 end if;
		 Entrabloc(Ts);

      end if;

   end Ct_Encap;


   procedure Ct_Pencap
     (A : in Pnode;
      I : out Id_Nom) is

      Param : Pnode renames A.Fd1;
      Fesq : Pnode renames A.Fe1;
      --Id : Id_Nom renames A.Fe1.Id12;
      Tproc : Descrip;
      E : Boolean;

   begin
      Put_line("CT_pencap: ");

      if Fesq.Tipus = Identificador then

         np := np + 1;
         Tproc := (Dproc, np);
         Posa(Ts, A.Fe1.Id12, Tproc, E);
         if E then
			Put_Line("ERROR CT_ENCAP: Error el id del proccediment ja existeix");
		 end if;
         I := fesq.Id12;
		 
      else
         Ct_Pencap(Fesq, I);
      end if;
      Ct_Param(Param, I);
   end Ct_Pencap;


   procedure Ct_Param
     (A : in Pnode;
	  I : in Id_Nom) is

      idPar : id_nom renames A.Fe2.id12;
      mArg : mMode renames A.Fc2.M12;
      idTipus : id_nom renames A.Fd2.id12;

	  d : Descrip;
	  dArg : Descrip;
	  E : boolean;

   begin
	    Put_line("CT_Param");

   		d := cons(ts, idtipus);
   	    if d.td /= dtipus then
	        Put_Line("ERROR CT_Param: El tipus del parametre no es correcte"&d.td'img);
		end if;

		case mArg is
			when Surt | Entrasurt =>  nv := nv + 1;
						   dArg := (dvar, idtipus, nv);
			when Entra =>   nv := nv + 1;
						   dArg := (dargc, nv, idtipus);
			when others => null;
		end case;
		
		posa_arg(ts, I, idPar, dArg, E);
		if E then
			Put_Line("ERROR CT_Param: Error al enregistrar l'argument");
		end if;
		

   end Ct_Param;


   procedure Ct_Declaracions
     (A : in Pnode) is

      Decl : Pnode renames A.Fd1;
      Decls : Pnode renames A.Fe1;
      Tnode : Tipusnode;
      Idrec : Id_Nom;
	  Ocup  : Despl;

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
         when Dregistre | Dencapregistre 
             |Firecord => Ocup := 0;					
					      Ct_Decregistre(Decl, Idrec,Ocup);
         when Dsubrang    => Ct_Decsubrang(Decl);
         when Procediment => Ct_Decprocediment(Decl);
         when others => Put_Line("ERROR CT_Declaracions:(DEBUG)tipus declarat inexistent "&Tnode'img);
      end case;

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

   begin
      Put_line("CT_DECLSVAR");
      if Tnode = Identificador then
        
		 Tdecl := Cons(Ts, A.Id12);
         if (Tdecl.Td /= Dtipus) then 
			 Put_Line("ERROR CT_DECLSVAR: el tipus no existeix");
         end if;

		Idtipus := A.Id12;

      elsif Tnode = Declmultvar then
         Ct_Declsvar(A.Fd1, Idtipus);
         Put_Line("CT_DECLSVAR:(DEBUG) diferents variables amb mateix tipus...");
         Posa_Idvar(A.Fe1.Id12, Idtipus, E);
      end if;

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
      if (Tdecl.Td /= Dtipus) then
            Put_Line("ERROR CT-const: No es d'un tipus o el tipus no existeix");
	  end if;
      Ct_Constant(Val, Tsubj, Ids);
      if (Tsubj /= Tdecl.Dt.Tt) then
            Put_Line("ERROR CT-const: tipus subj diferent");
  	  end if;

      if (Val.Val < Tdecl.Dt.Linf) or (Val.Val > Tdecl.Dt.Lsup) then
               Put_Line("ERROR CT-const: el valor de la constant "&
                       "surt del rang");
      end if;

      -- Guardam la constant
      --Tconst := (dconst, IdTipus, Val.val, Nv);
	  Tconst := (dconst, IdTipus, Val.val);
      Posa(Ts, Id, Tconst, E);
      Put_Line("CT_CONST: (DEBUG)El valor de la constant es: "&Val.val'img);                        
      if E then
      		Put_Line("ERROR-CT-const: var ja existent");
      end if;

   end Ct_Decconst;


   procedure Ct_Deccol
     (A : in Pnode) is

      Darray : Descrip;
      Dtarray : Descrip;
      Fesq : Pnode renames A.Fe1;
      Idtipus_Array : Id_Nom renames A.Fd1.Id12;
      Idarray : Id_Nom;
	  Ncomponents : Despl;

   begin
      Dtarray := Cons(Ts, Idtipus_Array);
      if (Dtarray.Td /= Dtipus) then
		 Put_Line("ERROR-CT-deccol: el tipus de l'array no existeix");
	  end if;

      Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray, Ncomponents);
      Darray := Cons(Ts, Idarray); --Falta control d'errors?
	  Darray.Dt.Tcamp := Idtipus_Array;
	  Darray.Dt.Ocup := Ncomponents * Dtarray.Dt.Ocup;
	  Actualitza(Ts, Idarray, Darray);
   end Ct_Deccol;


   procedure Ct_Pcoleccio
     (A : in Pnode;
      Idtipus_Array : in Id_Nom;
      Idarray : out Id_Nom;
	  Ncomponents : out Despl) is

      Fesq : Pnode renames A.Fe1;
      Idrang : Id_Nom renames A.Fd1.Id12;
      E : Boolean;

      Dtarray : Descriptipus;
      Darray : Descrip;
	  Di : Descrip;

   begin
      if (A.Tipus = Pcoleccio) then
         Ct_Pcoleccio(Fesq, Idtipus_Array, Idarray, Ncomponents);
         Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posa_idx, error "&
                       "del compilador, array no creat");
         end if;

		 Di := Cons(Ts, Idrang);
		 if E then
			Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'index de l'array");
		 end if;
         Ncomponents := Ncomponents + Despl(Di.Dt.Lsup - Di.Dt.Linf + 1);

      elsif (A.Tipus = Pdimcoleccio) then
         Dtarray := (Tsarr, 0, Idtipus_Array);
         Darray := (Dtipus, Dtarray);
         Idarray := Fesq.Id12;
		 
         Posa(Ts, Idarray, Darray, E);
         if E then
            Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'array");
         end if;
         
		 Di := cons(ts, Idrang);
		 if not (Di.td = dtipus and then Di.dt.tt <= tsent) then
			 Put_Line("ERROR CT-pcoleccio: error al posar el tipus "&
                       "de l'index de l'array");
		 end if;

		 Posa_Idx(Ts, Idarray, Idrang, E);
         if E then
            Put_Line("ERROR CT-pdimcoleccio: error al posa_idx, error "&
                       "del compilador, array no creat, idarr: "&
                       Idarray'Img);
         end if;

         Ncomponents := Despl(Di.Dt.Lsup - Di.Dt.Linf + 1);
      end if;
   end Ct_Pcoleccio;


   procedure Ct_Decregistre
     (A : in Pnode;
      Idrecord : out Id_Nom;
	  Ocup: in out despl) is

     -- Tipus : Tipusnode renames A.Tipus;
      Drecord : Descrip;
      Dtrecord : Descriptipus;
     -- Camp : Pnode renames A.Fc2;
     -- Tcamp : Pnode renames A.Fd2;
      E : Boolean;

   begin
	  
      if (A.Tipus = Dregistre) then
         Dtrecord := (Tsrec, 0);
         Drecord := (Dtipus, Dtrecord);
         Posa(Ts, A.Fe2.Id12, Drecord, E);
         Idrecord := A.Fe2.Id12;
         if E then
            Put_Line("ERROR CT-registre: el id del record "&
                       "ja existeix");
         end if;

         Ct_Dregistre_Camp(A.Fe2.Id12, A.Fc2, A.Fd2,Ocup);

      elsif (A.Tipus = Dencapregistre) then
	     
         Ct_Decregistre(A.Fe2, Idrecord, Ocup);
         Ct_Dregistre_Camp(Idrecord, A.Fc2, A.Fd2,Ocup);
	
	  elsif (A.Tipus = Firecord) then
			Ct_Decregistre(A.F6, Idrecord,Ocup);
			Drecord := cons(ts,Idrecord);
			Drecord.dt.ocup := ocup;
			actualitza(ts, Idrecord,Drecord);
      end if;

   end Ct_Decregistre;


   procedure Ct_Dregistre_Camp
     (Idrecord : in Id_Nom;
      Camp : in Pnode;
      Tcamp : in Pnode;
	  Ocup: in out Despl) is

      Idtcamp : Id_Nom renames Tcamp.Id12;
      Dtcamp : Descrip;
      Idcamp : Id_Nom renames Camp.Id12;
      Desc_Camp : Descrip;
      E : Boolean;

   begin
      Dtcamp := Cons(Ts, Idtcamp);
      if (Dtcamp.Td /= Dtipus) then

         Put_Line("ERROR CT-dregistre-camp: el tipus del camp no "&
                    "existeix o no es d'un tipus");
      end if;
      --desplnul provisional
      Desc_Camp := (Dcamp, Idtcamp, Nul_Despl);
      Posacamp(Ts, Idrecord, Idcamp, Desc_Camp, E);
	
	  Ocup := Ocup + Dtcamp.dt.ocup; 

      if E then
         Put_Line("ERROR CT-dregistre-camp: ja existeix un camp amb "&
                    "el mateix id en aquest record");
      end if;
   end Ct_Dregistre_Camp;


   procedure Ct_Dsubrang_Limit -- NO ES UTIL
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

   end Ct_Dsubrang_Limit;--NO ES UTIL


   procedure Ct_Decsubrang
     (A : in Pnode) is

      Idsubrang : Id_Nom renames A.Fe5.Id12;
      Idtsubrang : Id_Nom renames A.Fc5.Id12;
 
      --Suposarem que limit nomes pot ser 'const'
      Rang_Esq : Pnode renames A.Fd5;
      Rang_Dret : Pnode renames A.Fid5;
      Tsub : Tipussubjacent;

      Tsesq : Tipussubjacent;
      Tsdret : Tipussubjacent;
      Idesq : Id_Nom;
      Iddret : Id_Nom;
      Valesq : Valor;
      Valdret : Valor;

      Tdecl : Descrip;
      Tdescrip_decl : Descrip;
      Tdescript_decl : Descriptipus;

      E : Boolean;

   begin

      Tdecl := Cons(Ts, Idtsubrang);
      --Miram si el tipus sobre el qual es vol crear

      if(Tdecl.Td /= Dtipus) then

			  Put_Line("ERROR CT-decsubrang: tipus 'new x' x no existeix: ");
	  end if;

      --Miram el fill esquerra
	  Ct_Constant(Rang_Esq, Tsesq, Idesq);
	  Valesq := Rang_Esq.val;
      --Miram el fill dret
	  Ct_Constant(Rang_Dret, Tsdret, Iddret);
	  Valdret := Rang_Dret.val;

      -- Comparam els tipus
      if (Tsesq /= Tsdret) then
      		Put_line("ERROR Ct_subrang: Tipus subjacents diferents dels valors del rang");
      end if;

   	  Tsub := Tsesq;                  

      if (Tsub /= Tdecl.dt.tt) then
           Put_line("ERROR Ct_subrang: Tipus subjacents diferents del tipus del subrang");
	  end if;
             
      if (valesq > valdret) then
		
		Put_line("ERROR Ct_subrang: El valor esquerra no pot ser major al de la dreta");
	  end if;

	 if (valesq < Tdecl.dt.linf ) then
		
		Put_line("ERROR Ct_subrang: Valor esquerra inferior al permes");
	 
	 end if;

	if (valdret > Tdecl.dt.lsup ) then
		
		Put_line("ERROR Ct_subrang: Valor dret superior al permes");
	
	end if; 

	case Tsub is
		
		when tsent =>  Tdescript_decl := (tsent, 4, valesq, valdret);
		when tscar =>  Tdescript_decl := (tscar, 4, valesq, valdret);
   	    when others => Put_line("ERROR Ct_subrang: Tipus(sub) no valid per a un subrang");

	end case;

    Tdescrip_decl := (Dtipus, Tdescript_decl);
    Posa(ts, Idsubrang, Tdescrip_decl, E);

     if E then
     	Put_Line("ERROR CT-decsubrang: el tipus "&
                 "que intentes declarar ja existeix");
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
            case Op is
               when Suma | Resta | Mult | Div | Modul =>
                  T := Tesq;
                  Idtipus := Idesq;
               when Menor | Menorig | Major | Majorig
                 | Igual | Distint | Unio | Interseccio =>
                  T := Tsbool;
                  if Tesq = Tsbool then
                     Idtipus := Idesq;
                  else
                     Idtipus := Id_Nul;
                  end if;
                  if (Op = Unio) or (Op = Interseccio) then
                     if (Tesq /= Tsbool) or (Tdret /= Tsbool) then
                        Put_Line("ERROR CT-expressioc: operacio and|or "&
                                   "nomes permesa amb operands booleans");
                     end if;
                  elsif (Op = Menor) or (Op = Menorig) or (Op = Major)
                    or (Op = Majorig) then
                     if (Tesq /= Tsent) or (Tdret /= Tsent) then
                        Put_Line("ERROR CT-expressioc: operacions <, <=, "&
                                   ">=, > nomes permeses amb operands "&
                                   "sencers");
                     end if;
                  end if;
               when others =>
                  Put_Line("ERROR CT-expressioc: operacio no "&
                             "reconeguda");
            end case;
         else
            Put_Line("ERROR CT-expressioc: una expressio no es pot "&
                       "composar amb dos tipus diferents");
            case Op is
               when Menor | Menorig | Major | Majorig | Igual
                 | Distint | Unio | Interseccio =>
                  T := Tsbool;
                  Idtipus := Id_Nul;
               when Suma | Resta | Mult | Div | Modul =>
                  T := Tsent;
                  Idtipus := Id_Nul;
               when others => Put_Line("ERROR CT-expressioc: operacio "&
                                         "no reconeguda i error del "&
                                         "compilador");
            end case;
         end if;
      else
        if (Tesq = Tdret) then
            if (Idesq /= Id_Nul) then
               case Op is
                  when Suma | Resta | Mult | Div | Modul
                    | Unio | Interseccio =>
                     T := Tesq;
                     Idtipus := Idesq;
                     if (Op = Unio) or (Op = Interseccio) then
                        if T /= Tsbool then
                           Put_Line("ERROR CT-expressioc: no es pot "&
                                      "realitzar una operacio "&Op'Img&
                                      "amb un tipus no boolea");
                        end if;
                     elsif (Op /= Unio) and (Op /= Interseccio) then
                        if T /= Tsent then
                           Put_Line("ERROR CT-expressioc: no es pot "&
                                      "realitzar una operacio "&Op'Img&
                                      "amb un tipus no sencer");
                        end if;
                     end if;
                  when Menor | Menorig | Major | Majorig =>
                     T := Tsbool;
                     Idtipus := Id_Nul;
                     if (Tesq /= Tsent) or (Tdret /= Tsent) then
                        Put_Line("ERROR CT-expressioc: no es pot "&
                                   "realitzar una operacio "&Op'Img&
                                   "amb un tipus no sencer");
                     end if;
                  when Igual | Distint =>
                     T := Tsbool;
                     Idtipus := Id_Nul;
                  when others =>
                     Put_Line("ERROR CT-expressioc: operacio no permesa "&
                             "i error del compilador");
               end case;

            elsif (Iddret /= Id_Nul) then
               case Op is
                  when Suma | Resta | Mult | Div | Modul
                    | Unio | Interseccio =>
                     T := Tdret;
                     Idtipus := Iddret;
                     if (Op = Unio) or (Op = Interseccio) then
                        if T /= Tsbool then
                           Put_Line("ERROR CT-expressioc: no es pot "&
                                      "realitzar una operacio "&Op'Img&
                                      "amb un tipus no boolea");
                        end if;
                     elsif (Op /= Unio) and (Op /= Interseccio) then
                        if T /= Tsent then
                           Put_Line("ERROR CT-expressioc: no es pot "&
                                      "realitzar una operacio "&Op'Img&
                                      "amb un tipus no sencer");
                        end if;
                     end if;
                  when Menor | Menorig | Major | Majorig =>
                     T := Tsbool;
                     Idtipus := Id_Nul;
                     if (Tesq /= Tsent) or (Tdret /= Tsent) then
                        Put_Line("ERROR CT-expressioc: no es pot "&
                                   "realitzar una operacio "&Op'Img&
                                   "amb un tipus no sencer");
                     end if;
                  when Igual | Distint =>
                     T := Tsbool;
                     Idtipus := Id_Nul;
                  when others =>
                     Put_Line("ERROR CT-expressioc: operacio no permesa i "&
                                "error del compilador");
               end case;

            else
               case Op is
                  when Suma | Resta | Mult | Div | Modul =>
                     if Tesq = Tsent then
                        T := Tesq;
                     else
                        T := Tsent;
                        Put_Line("ERROR CT-expressioc: no es pot "&
                                   "realitzar una operacio "&Op'Img&
                                   "amb un tipus no sencer");
                     end if;
                     Idtipus := Id_Nul;
                  when Menor | Menorig | Major | Majorig
                    | Igual | Distint | Unio | Interseccio =>
                     if (Op = Unio) or (Op = Interseccio) then
                        if Tesq /= Tsbool then
                           Put_Line("ERROR CT-expressioc: and|or nomes"&
                                      " es poden fer amb tipus booleans");
                        end if;
                        T := Tsbool;
                     elsif (Op = Menor) or (Op = Menorig) or (Op = Major) or
                       (Op = Majorig) then
                        if Tesq /= Tsent then
                           Put_Line("ERROR CT-expressioc: els operadors "&
                                      "<, <=, >=, > nomes es poden emprar "&
                                      "amb sencers");
                        end if;
                        T := Tsbool;
                     else
                        T := Tsbool;
                     end if;
                     Idtipus := Id_Nul;
                  when others =>
                     Put_Line("ERROR CT-expressioc: operacio no permesa i"&
                                "error del compilador");
               end case;

            end if;
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

	--T : Tipussubjacent;
   	--Idtipus : Id_Nom;
	D : Descrip;
	

   begin
      case (A.Tipus) is
         when Bloc =>
            Ct_Bloc(A.Fe1);
            Ct_Bloc(A.Fd1);
         when Repeticio =>
            Ct_Srep(A);
		 when identificador => 
            Put_Line("CT_Bloc : IDENTIFICADOR");			
			D := cons(ts, a.id12);
			if d.td /= dproc then
	            Put_Line("CT_Bloc : Aquest id no es correspon a un procediment");				
			end if;
  		 --when Referencia => 
			--Ct_Referencia(A);	
		 when condicionalS =>
			Ct_Sconds(A);
		 when condicionalC =>
			Ct_Scondc(A); ----
         when others =>
            Put_Line("blocothers"&A.Tipus'img);
      end case;
   end Ct_Bloc;


   procedure Ct_Srep
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Exp : Pnode renames A.Fe1;
	  Bloc : Pnode renames A.fd1;

   begin
      Ct_Expressio(Exp, Tsexp, Idtipus_Exp);
	  if tsexp /= tsbool then 
	      Put_Line("Ct : La expresion para un bucle debe ser un booleano");		
	  end if;
	  Ct_Bloc(Bloc);
   end Ct_Srep;


   procedure Ct_Sconds
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Cond : Pnode renames A.Fe1;
	  Bloc : Pnode renames A.fd1;

   begin
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp);
	  if tsexp /= tsbool then 
	      Put_Line("Ct : La expresion para un condicional debe ser un booleano");		
	  end if;
	  Ct_Bloc(Bloc);
   end Ct_Sconds;


   procedure Ct_Scondc
     (A : in Pnode) is

      Tsexp : Tipussubjacent;
      Idtipus_exp : Id_Nom;
      Cond : Pnode renames A.Fe2;
	  Bloc : Pnode renames A.fc2;
	  Blocelse : Pnode renames A.fd2;

   begin
      Put_Line("Ct_CondCompost : Entram dins un condicional compost");		
      Ct_Expressio(Cond, Tsexp, Idtipus_Exp);
	  if tsexp /= tsbool then 
	      Put_Line("Ct : La expresion para un condicional compuesto debe ser un booleano");		
	  end if;
	  Ct_Bloc(Bloc);
	  Ct_Bloc(Blocelse);
   end Ct_Scondc;



--   procedure Ct_Referencia
--     (A : in Pnode) is

--   begin

--      case (A.Tipus) is

--	  	when id => ;
--		when referencia =>
--		when pri => 

--	  end case;

--   end Ct_referencia;
	

end Decls.Ctipus;
