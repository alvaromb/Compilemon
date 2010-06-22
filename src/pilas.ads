generic

   type Tipus_Element is private;

package pilas is

	Memoria_Agotada : exception;

	type Pila is limited private;

	procedure Pila_Buida 
		(P : out Pila);

	function Es_Buida 
		(P : Pila) return Boolean;

	procedure Cim 
		(P       : in     Pila; 
		 Element :    out Tipus_Element);

	procedure Empilar 
		(P       : in out Pila; 
		 Element : in     Tipus_Element);

	procedure Desempilar
		(P : in out Pila);

	procedure Destruir 
		(P : in out Pila);

private

   type Component;
   type Pila is access Component;

end pilas;

