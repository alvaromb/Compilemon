-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio  :   0.3
--  Autors  :   Jose Ruiz Bravo
--              Biel Moya Alcover
--              Alvaro Medina Ballester
-- ------------------------------------------------
--  Implementacio dels procediments per al
-- tractament de la taula de noms:
--
--          - Buidat de la taula
--          - Insercio
--          - Insercio d'strings
--          - Consulta
--          - Funcio de hash
--
-- ------------------------------------------------


package body decls.d_taula_de_noms is

    -- Donam els valors per defecte de cada camp.
   procedure tbuida
     (tn : out taula_de_noms) is

   begin
      for i in tn.td'range loop
         tn.td(i) := id_nul;
      end loop;

      tn.nid := 1;
      tn.ncar := 1;
      tn.tid(1).seguent := id_nul;
   end tbuida;



   procedure posa_id
     (tn : in out taula_de_noms;
     idn : out id_nom;
     nom : in string) is

      -- Variable per el valor de la funcio de dispersio.
      p_tid : rang_dispersio;

      -- Index per recorrer la taula d'identificadors.
      idx : id_nom;
      Trobat : boolean;

      p : taula_identificadors renames tn.tid;
      d : taula_dispersio renames tn.td;

   begin
      p_tid := fdisp_tn(nom);
      Idx := d(P_Tid);
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
         p(idn).Pos_Tcar := Tn.Ncar;
         p(idn).Seguent := d(P_Tid);
         p(idn).Long_Paraula := Nom'Length;

         d(P_Tid) := Tn.Nid;

         posa_tc(tn, nom);
      end if;

   end posa_id;



   procedure posa_tc
     (tn : in out taula_de_noms;
     nom : in string) is

   begin
      tn.nid := tn.nid + 1;

      for i in 1 .. nom'Length loop
         tn.tc(tn.ncar) := nom(i);
         tn.ncar := tn.ncar + 1;
      end loop;

   end posa_tc;



   procedure posa_str
     (tn : in out taula_de_noms;
     ids : out rang_tcar;
       s : in string) is

      -- Index per recorrer la taula de caracters.
      jdx : rang_tcar;
      long : rang_tcar renames tn.ncar;

   begin
      -- Excepcio per a controlar tc plena
      if (long + s'Length) > rang_tcar'Last then
          raise E_Tcar_Plena;
      end if;

      -- Omplim la taula de caracters, desde la primera
      -- posicio lliure 'tn.ncar' renombrat a 'long'.
      jdx := long;
      ids := long;

      for i in 1..s'Length loop
          tn.tc(jdx) := s(i);
          jdx := jdx + 1;
      end loop;

      long := jdx + 1;
      tn.tc(jdx) := Ascii.nul;

    end posa_str;



    function cons_nom
      (tn : in taula_de_noms;
      idn : in id_nom)
      return string is

       It1, It2 : Rang_Tcar;

    begin
       It1 := Tn.Tid(Idn).Pos_Tcar;
       It2 := Rang_Tcar(Tn.Tid(Idn).Long_Paraula);
       It2 := It2 + It1 - 1;

       return String(Tn.Tc(it1 .. it2));

    end cons_nom;



    function cons_str
      (tn : in taula_de_noms;
      ids : in rang_tcar)
      return string is

       idx : rang_tcar;

    begin
       idx := ids;
       while (tn.tc(idx) /= Ascii.nul) loop
           idx := idx+1;
       end loop;

       return string(tn.tc(ids..idx-1));

    end cons_str;


    function fdisp_tn
      (nom : in string)
      return rang_dispersio is

       a : array (nom'Range) of integer;
       r : array (1..2*nom'Last) of integer;

       k, c, m, n : integer;

       base : constant Integer :=
         Character'Pos(Character'Last)+1;

    begin
        n := nom'Last;
        m := nom'Length;

        for i in 1..n loop
           a(i) := character'Pos(nom(i));
        end loop;

        for i in 1..2*n loop
           r(i) := 0;
        end loop;

        for i in 1..n loop
           c := 0; k := i - 1;
           for j in 1..n loop
               c := c + r(k+j) + a(i) + a(j);
               r(k+j) := c mod base;
               c := c/base;
           end loop;
           r(k+n+1) := r(k+n+1) + c;
        end loop;

        c := (r(n+1) * base + r(n)) mod (max_id);

        return rang_dispersio(c);

    end fdisp_tn;


end decls.d_taula_de_noms;
