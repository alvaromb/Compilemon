-- ------------------------------------------------
--  Paquet de declaracions de la taula de noms
-- ------------------------------------------------
--  Versio  :   0.2
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
--
-- ------------------------------------------------


package body decls.d_taula_de_noms is

    -- Donam els valors per defecte de cada camp, sempre
    -- que un camp no sigui utilitzat valdra 0.
    procedure tbuida (tn : out taula_de_noms) is

    begin

        for i in tn.td'range loop
            tn.td(i) := id_nul;
        end loop;

        tn.nid := 1;
        tn.ncar := 0;

        tn.tid(1).seguent := id_nul;

    end tbuida;



    function par_iguals (par1, par2 : in string) return boolean is

        it_p1 : integer;
        it_p2 : integer;

    begin

        if par1'Length = par2'Length then

            it_p1 := par1'First;
            it_p2 := par2'First;

            while it_p1 < par2'Length and par2(it_p2) = par1(it_p1) loop
                it_p1 := it_p1 + 1;
                it_p2 := it_p2 + 1;
            end loop;

            if par1(it_p1) = par2(it_p2) then
                return true;
            end if;

        end if;

        return false;

    end par_iguals;



    procedure posa_id   (tn : in out taula_de_noms;
                        idn : out id_nom;
                        nom : in string) is

        -- Variable per el valor de la funcio de dispersio.
        p_tid : rang_dispersio;

        -- Indexos per recorrer la taula d'identificadors.
        idx : id_nom;
        Trobat : boolean;

        -- Index per recorrer la taula de caracters.
        jdx : rang_tcar;

        p : taula_identificadors renames tn.tid;

    begin

       p_tid := fdisp_tn(nom);
       Idx := Tn.Td(P_Tid);
       Trobat := False;

       while not Trobat and Idx/=Id_Nul loop
          if (Nom = Cons_Nom(Tn, Idx)) then
             Trobat := True;
          else
             Idx := Tn.Tid(Idx).Seguent;
          end if;
       end loop;

       if not Trobat then
          Idx := Tn.Nid;

          Tn.Tid(Idx).Pos_Tcar := Tn.Ncar;
          Tn.Tid(Idx).Seguent := Tn.Td(P_Tid);
          Tn.Tid(Idx).Long_Paraula := Nom'Length;

          Tn.Td(P_Tid) := Tn.Nid;

          Tn.Nid := Tn.Nid + 1;
          for I in 1 .. Nom'Length loop
             Tn.Tc(Tn.ncar) := Nom(I);
             Tn.Ncar := Tn.Ncar + 1;
          end loop;
          Tn.Tc(Tn.Ncar) := '$';
          Tn.Ncar := Tn.Ncar + 1;
       end if;

    end posa_id;



    procedure posa_str  (tn : in out taula_de_noms;
                            ids : out rang_tcar;
                              s : in string) is

        -- Index per recorrer la taula de caracters.
        jdx : rang_tcar;

    begin

        -- Excepcio per a controlar tc plena
        if (tn.ncar + s'Length) > rang_tcar'Last then
            raise E_Tcar_Plena;
        end if;

        -- Omplim la taula de caracters, desde la primera
        -- posicio lliure 'ncar'.
        jdx := tn.ncar;
        ids := tn.ncar;

        for i in 1..s'Length loop

            tn.tc(jdx) := s(i);
            jdx := jdx + 1;

        end loop;

        tn.ncar := jdx + 1;
        tn.tc(jdx) := '$';


    end posa_str;



    function cons_nom (tn : in taula_de_noms; idn : in id_nom) return string is

    begin

        return string(tn.tc(tn.tid(idn).pos_tcar .. tn.tid(idn).pos_tcar+rang_tcar(tn.tid(idn).long_paraula)-1));

    end cons_nom;



    function cons_str   (tn : in taula_de_noms; ids : in rang_tcar) return string is

        idx : rang_tcar;

    begin

        idx := ids;

        while (tn.tc(idx) /= '$') loop
            idx := idx+1;
        end loop;

        return string(tn.tc(ids..idx-1));

    end cons_str;


end decls.d_taula_de_noms;
