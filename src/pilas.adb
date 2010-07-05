with Ada.Unchecked_Deallocation;

package body pilas is

   type Component is record
      Cim   : Tipus_Element;
      Resta : Pila;
   end record;

   procedure Allibera_Memoria is
      new Ada.Unchecked_Deallocation
     (Object => Component,
      Name => Pila);

   procedure Pila_Buida
     (P : out Pila) is
   begin
      P := null;
   end Pila_Buida;


   function Es_Buida
     (P : Pila) return Boolean is
   begin
      return P = null;
   end Es_Buida;


   procedure Cim
     (P : in Pila;
      Element : out Tipus_Element) is
   begin
      pragma Assert
        (P /= null, "Intent d'accedir a cim de pila buida");
      Element := P.all.Cim;
   end Cim;



   procedure Empilar
     (P : in out Pila;
      Element : in Tipus_Element) is
   begin
      P := new Component'(Cim => Element, Resta => P);
   exception
      when Storage_Error => raise Memoria_Agotada;
   end Empilar;


   procedure Desempilar
     (P : in out Pila) is
      Antic : Pila;
   begin
      pragma Assert
        (P /= null, "Intent de desempilar una pila buida");
      Antic := P;
      P := P.all.Resta;
      Allibera_Memoria(Antic);
   end Desempilar;


   procedure Destruir
     (P : in out Pila) is
      Antic : Pila;
   begin
      while P /= null loop
         Antic := P;
         P := P.all.Resta;
         Allibera_Memoria(Antic);
      end loop;
   end Destruir;

end pilas;

