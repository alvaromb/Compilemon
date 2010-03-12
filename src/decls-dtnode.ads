with Decls.Dgenerals;

use Decls.Dgenerals;

package Decls.Dtnode is

   --pragma pure;
   type Operacio is
     (Suma,
      Resta,
      Mult,
      Div,
      Menor,
      Menorig,
      Major,
      Majorig,
      Igual,
      Distint,
      Modul,
      Unio,
      Interseccio,
      Negacio);

   type Mode is
     (Entra,
      Surt,
      Entrasurt);

   type Node;
   type Pnode is access Node;
   type Tipusnode is
     (Programa,
      M1,
      Repeticio,
      CondicionalS,
      CondicionalC,
      Expressio,
      ExpressioUnaria, -- Not E, -E
	  Pencap,
      Procediment, -- Fe = encap, Fc = declaracions, Fd = bloc
      Dvariable,
      Dconstant,
      Dcoleccio,
      Dregistre,
	  Dencapregistre,
      Dsubrang,
      Identificador,
      Const,
      Declaracions,
      Bloc,
      Assignacio,
      Referencia,
      Pri,
	  Param,
	  Pcoleccio,
	  Pdimcoleccio,
	  Tnul); 

	type node (n: tipusnode := tnul) is record
		case n is
			when programa | repeticio | condicionalS 
			 			  |	declaracions | bloc | assignacio
						  | pri | pencap => fe, fd: pnode;
			when m1 | tnul => null;
			when CondicionalC => fe, fc, fd: pnode;
			when expressio => fe, fd: pnode; 
							  op: operacio;
			when expressioUnaria => f: pnode; 
							  		op: operacio;
			when procediment => fe, fc, fd: pnode;
								id : idnom;
			when dvariable | dcoleccio 
						   | pdimcoleccio | referencia => f : pnode;
													  id : idnom;
			when dconstant | dregistre => id1, id2 : idnom;
							  					f : pnode;
			when dencapregistre => id1, id2, id3 : idnom;
			when dsubrang => id1, id2 : idnom;
								fe, fd : pnode;

			when param => fe, fd : pnode;
						  m : mode;

			when pcoleccio => id1, id2 : idnom;

			when identificador => id : idnom;
			when const => a : atribut;

			when others => null; 
		end case;
	end record;



