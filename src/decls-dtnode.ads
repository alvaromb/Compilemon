with Decls.Dgenerals,decls.D_Taula_De_Noms;

use Decls.Dgenerals,decls.D_Taula_De_Noms;

package Decls.Dtnode is

   --pragma pure;

   type Mmode is
     (Entra,
      Surt,
      Entrasurt);

   type Operacio is
     (Suma, --
      Resta, --
      Mult, --
      Div, --
      Menor, --
      Menorig, --
      Major, --
      Majorig, --
      Igual, --
      Distint, --
      Modul, --
      Unio, --
      Interseccio, --
      Negacio); --

   type valor is new integer;

   type Node;

   type Pnode is access Node;

   type Tipusnode is
     (Programa, --
      M1,
      Repeticio, --
      CondicionalS, --
      CondicionalC, --
      Expressio, --
      ExpressioUnaria, -- Not E, -E
      Pencap,
      Procediment, -- Fe = encap, Fc = declaracions, Fd = bloc
      Dvariable, --
      Dconstant, --
      Dcoleccio, --
      Dregistre, --
      Dencapregistre, --
      Dsubrang, --
      Identificador,
      Const, --
      Declaracions, --
      Bloc,
      Assignacio,
      Referencia, --
      Pri,
      Param,
      Pcoleccio, --
      Pdimcoleccio, --
      Asigvalvar, --
      Declmultvar, --
      Tnul,
      Mode,
      encappri);

   type node (n: Tipusnode := tnul) is record
      case n is
         when m1 | tnul => null;
         when programa | repeticio | condicionalS
           | declaracions | bloc | assignacio | pri
           | dcoleccio | Pdimcoleccio | Referencia
           | pcoleccio | dvariable | Asigvalvar 
           | Declmultvar | encappri => fe1, fd1: pnode;

         when CondicionalC | dconstant | dregistre 
		   | dencapregistre => fe2, fc2, fd2: pnode;

         when expressio => fe3, fd3: pnode;
                              op3: operacio;

         when expressioUnaria => f4: pnode;
                                    op4: operacio;

         when procediment | dsubrang => fe5, fc5, fd5, fid5: pnode;

         when Param =>
            fe10, fd10 : pnode;
                   m10 : pnode;

         when Pencap => f11 : pnode;
                         m11 : Mmode;

         when identificador => id12 : Id_Nom;
                               l1, c1 : natural;

         when const => val : Valor;
            l2, c2 : natural;

         when Mode => M12 : Mmode;

         --when Referencia => F13 : Pnode;


        end case;
    end record;

end Decls.Dtnode;
