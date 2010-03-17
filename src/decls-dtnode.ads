with Decls.Dgenerals,decls.D_Taula_De_Noms;

use Decls.Dgenerals,decls.D_Taula_De_Noms;

package Decls.Dtnode is

    type Mmode is
     (Entra,
      Surt,
      Entrasurt);
   --pragma pure;
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
      Tnul);

   type node (n: tipusnode := tnul) is record
      case n is
         when m1 | tnul => null;
         when programa | repeticio | condicionalS
           | declaracions | bloc | assignacio | pri
           | dcoleccio | pdimcoleccio | referencia
           | pcoleccio | dvariable | Asigvalvar |
           Declmultvar => fe1, fd1: pnode;

         when CondicionalC | dconstant
           | dregistre | dencapregistre => fe2, fc2, fd2: pnode;

         when expressio => fe3, fd3: pnode;
                              op3: operacio;

         when expressioUnaria => f4: pnode;
                                    op4: operacio;

         when procediment | dsubrang => fe5, fc5, fd5, fid5: pnode;

         when param => fe10, fd10 : pnode;
                          m10 : Mmode;

         when pencap => f11 : pnode;
                           m11 : Mmode;

         when identificador => id12 : id_nom
                               l, c : natural;

         when const => val : valor
              l, c : natural;

        end case;
    end record;

end Decls.Dtnode;

