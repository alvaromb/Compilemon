-- DECLS-D_TAULA_DE_NOMS.adb
-- Procediments per a la taula de noms

package body Decls.D_Taula_De_Noms is

   -- Donam els valors per defecte de cada camp.
   procedure Tbuida
     (Tn : out Taula_De_Noms) is
   begin
      for I in Tn.Td'Range loop
         Tn.Td(I) := Id_Nul;
      end loop;

      Tn.Nid := 1;
      Tn.Ncar := 1;
      Tn.Tid(1).Seguent := Id_Nul;
   end Tbuida;


   procedure Posa_Id
     (Tn : in out Taula_De_Noms;
      idn : out Id_Nom;
      nom : in String) is

      -- Variable per el valor de la funcio de dispersio.
      P_Tid : Rang_Dispersio;

      -- Index per recorrer la taula d'identificadors.
      Idx : Id_Nom;
      Trobat : Boolean;

      P : Taula_Identificadors renames Tn.Tid;
      D : Taula_Dispersio renames Tn.Td;

   begin
      P_Tid := Fdisp_Tn(Nom);
      Idx := D(P_Tid);
      Trobat := False;

      while not Trobat and Idx/=Id_Nul loop
         if (Nom = Cons_Nom(Tn, Idx)) then
            Idn := idx;
            Trobat := True;
         else
            Idx := p(Idx).Seguent;
         end if;
      end loop;

      if not Trobat then
         Idn := Tn.Nid;
         P(Idn).Pos_Tcar := Tn.Ncar;
         P(Idn).Seguent := D(P_Tid);
         P(Idn).Long_Paraula := Nom'Length;
         D(P_Tid) := Tn.Nid;
         Posa_Tc(Tn, Nom);
      end if;
   end Posa_Id;


   procedure Posa_Tc
     (Tn : in out Taula_De_Noms;
      Nom : in String) is
   begin
      Tn.Nid := Tn.Nid + 1;
      for I in 1 .. Nom'Length loop
         Tn.Tc(Tn.Ncar) := Nom(I);
         Tn.Ncar := Tn.Ncar + 1;
      end loop;
   end Posa_Tc;


   procedure Posa_Str
     (Tn : in out Taula_De_Noms;
      Ids : out Rang_Tcar;
      S : in String) is

      -- Index per recorrer la taula de caracters.
      Jdx : Rang_Tcar;
      Long : Rang_Tcar renames Tn.Ncar;

   begin
      -- Excepcio per a controlar tc plena
      if (Long + S'Length) > Rang_Tcar'Last then
         raise E_Tcar_Plena;
      end if;

      -- Omplim la taula de caracters, desde la primera
      -- posicio lliure 'tn.ncar' renombrat a 'long'.
      Jdx := Long;
      Ids := Long;

      for I in 1..S'Length loop
         Tn.Tc(Jdx) := S(I);
         Jdx := Jdx + 1;
      end loop;
      Long := Jdx + 1;
      Tn.Tc(Jdx) := Ascii.Nul;

   end Posa_Str;


   function Cons_Nom
     (Tn : in Taula_De_Noms;
      Idn : in Id_Nom)
     Return String Is

      It1, It2 : Rang_Tcar;

   Begin
      If Idn /= Id_Nul Then
         It1 := Tn.Tid(Idn).Pos_Tcar;
         It2 := Rang_Tcar(Tn.Tid(Idn).Long_Paraula);
         It2 := It2 + It1 - 1;
         Return String(Tn.Tc(It1 .. It2));
      Else Return "Id_Nul";
      end If;
   end Cons_Nom;

   function Cons_Str
     (Tn : in Taula_De_Noms;
      Ids : in Rang_Tcar)
     return String is

      Idx : Rang_Tcar;

   begin
      Idx := Ids;
      while (Tn.Tc(Idx) /= Ascii.Nul) loop
         Idx := Idx+1;
      end loop;

      return String(Tn.Tc(Ids..Idx-1));

   end Cons_Str;


   function Fdisp_Tn
     (Nom : in String)
     return Rang_Dispersio is

      A : array (Nom'Range) of Integer;
      R : array (1..2*Nom'Last) of Integer;

      K, C, M, N : Integer;

      Base : constant Integer :=
        Character'Pos(Character'Last)+1;

   begin
      N := Nom'Last;
      M := Nom'Length;

      for I in 1..N loop
         A(I) := Character'Pos(Nom(I));
      end Loop;

      for I in 1..2*N loop
         R(I) := 0;
      end loop;

      for I in 1..N loop
         C := 0; K := I - 1;
         for J in 1..N loop
            C := C + R(K+J) + A(I) + A(J);
            R(K+J) := C mod Base;
            C := C/Base;
         end loop;
         R(K+N+1) := R(K+N+1) + C;
      end loop;

      C := (R(N+1) * Base + R(N)) mod (Max_Id);

      return Rang_Dispersio(C);

   end Fdisp_Tn;


end Decls.D_Taula_De_Noms;
