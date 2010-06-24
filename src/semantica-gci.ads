

package Semantica.gci is

	Campo_Nul : constant Camp := (Tc => Const, Idc => Var_Nul);

	type T_Param is record
    	Base, Despl : num_Var;
   	end record;


	package Pila_Param is new Pilas (T_Param);
	use Pila_Param;
	Pparam : Pila_Param.Pila;

	procedure Genera (
      Instr : in     tInstruccio;
      C1    : in     Camp;
      C2    : in     Camp;
      C3    : in     Camp)

   procedure Ct_Decprocediment
     (A : in Pnode);


end Semantica.gci;
