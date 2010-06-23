

package Semantica.gci is


	type T_Param is record
    	Base, Despl : num_Var;
   	end record;


	package Pila_Param is new Pilas (T_Param);
	use Pila_Param;
	Pparam : Pila_Param.Pila;

   procedure Ct_Decprocediment
     (A : in Pnode);

end Semantica.gci;
