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
--
-- ------------------------------------------------


package body decls.d_taula_de_noms is

    -- Donam els valors per defecte de cada camp.
    procedure tbuida (tn : out taula_de_noms) is

    begin

        for i in tn.td'range loop
            tn.td(i) := id_nul;
        end loop;

        tn.nid := 1;
        Tn.Ncar := 1;

        tn.tid(1).seguent := id_nul;

    end tbuida;



    procedure posa_id   (tn : in out taula_de_noms;
                        idn : out id_nom;
                        nom : in string) is

        -- Variable per el valor de la funcio de dispersio.
        p_tid : rang_dispersio;

        -- Index per recorrer la taula d'identificadors.
        idx : id_nom;
        Trobat : boolean;

        p : taula_identificadors renames tn.tid;

    begin

       p_tid := fdisp_tn(nom);
       Idx := Tn.Td(P_Tid);
       Trobat := False;

       while not Trobat and Idx/=Id_Nul loop
          if (Nom = Cons_Nom(Tn, Idx)) then
             Trobat := True;
          else
             Idx := p(Idx).Seguent;
          end if;
       end loop;

       if not Trobat then
          Idn := Tn.Nid;
          p(idn).Pos_Tcar := Tn.Ncar;
          p(idn).Seguent := Tn.Td(P_Tid);
          p(idn).Long_Paraula := Nom'Length;

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



    function cons_nom  (tn : in taula_de_noms;
                       idn : in id_nom)
                       return string is

       It1, It2 : Rang_Tcar;

    begin

       It1 := Tn.Tid(Idn).Pos_Tcar;
       It2 := Rang_Tcar(Tn.Tid(Idn).Long_Paraula);
       It2 := It2 + It1 - 1;

       return String(Tn.Tc(it1 .. it2));


    end cons_nom;



    function cons_str   (tn : in taula_de_noms;
                        ids : in rang_tcar)
                        return string is

        idx : rang_tcar;

    begin

        idx := ids;

        while (tn.tc(idx) /= '$') loop
            idx := idx+1;
        end loop;

        return string(tn.tc(ids..idx-1));

    end cons_str;


end decls.d_taula_de_noms;
