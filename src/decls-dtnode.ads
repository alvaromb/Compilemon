with Decls.Dgenerals,
  Decls.D_Taula_De_Noms,
  Decls.Dtdesc;

use Decls.Dgenerals,
  Decls.D_Taula_De_Noms,
  Decls.Dtdesc;

package Decls.Dtnode is

   --pragma pure;

   type Mmode is
     (Entra,
      Surt,
      Entrasurt);

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


   type Node;

   type Pnode is access Node;

   type Tipusnode is
     (Programa, 
      Repeticio, 
      CondicionalS, 
      CondicionalC, 
      Expressio, 
      ExpressioUnaria, -- Not E, -E
      Pencap,
      Procediment,
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
      Declmultvar, 
      Tnul,
      Mode,
      Encappri,
      Firecord,
      Fireferencia);

   type node (Tipus : Tipusnode := tnul) is record
      case Tipus is
         when tnul  => null;

         when Programa =>
            Proc : Pnode;

         when repeticio | condicionalS
           | declaracions | bloc | assignacio | pri
           | dcoleccio | Pdimcoleccio | Referencia
           | pcoleccio | dvariable
           | Declmultvar | encappri | Pencap => fe1, fd1: pnode;

         when CondicionalC | dconstant | dregistre
           | Dencapregistre | Param => fe2, fc2, fd2: pnode;

         when expressio => fe3, fd3: pnode;
                           op3: operacio;

         when ExpressioUnaria => f4: pnode;
                                 op4: operacio;

         when Procediment | dsubrang =>
            fe5, fc5, fd5, fid5: pnode;

         when identificador => id12 : Id_Nom;
                               l1, c1 : natural;

         when Firecord | Fireferencia => f6 : pnode;

         when const => val : valor;
            l2, c2 : natural;
            Tconst : Tipus_Atribut;

         when Mode => M12 : Mmode;

        end case;
    end record;

end Decls.Dtnode;
