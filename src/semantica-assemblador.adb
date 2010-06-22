package body Semantica.Assemblador is

   -- Caracter TAB per els comentaris
   Tab : constant Character := Ascii.Ht;

   -- Procediments per inserir les instruccions
   -- de codi assemblador. Tenim per els tres
   -- tipus de instruccions C3@:
   --    Instruccio amb 0 operadors
   procedure Instruccio_0_Op
     (Instruccio : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio);
   end Instruccio_0_Op;

   --    Instruccio amb 1 operador
   procedure Instruccio_1_Op
     (Instruccio,
        Operand : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio &
                 Tab & Operand);
   end Instruccio_1_Op;

   --    Instruccio amb 2 operadors
   procedure Instruccio_2_Op
     (Instruccio,
        Operand1,
        Operand2 : in String) is
   begin
      Put_Line(Fitxer_Asmbl, Tab & Instruccio &
                 Tab & Operand1 & Tab & ", " &
                 Operand2);
   end Instruccio_2_Op;


end Semantica.Assemblador;


