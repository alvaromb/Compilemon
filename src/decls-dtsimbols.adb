-- DECLS-DTSIMBOLS.adb
-- Procediments de la taula de simbols

package body Decls.Dtsimbols is

   procedure printts
     (ts : in tsimbols;
      tn : in taula_de_noms) is
   begin
      New_Line;
      Put_Line("");
      Put_Line("tdesc ------------");
      for i in 1 .. (id_nom'Last-970) loop
         Put("tdesc["&i'img&"] := (");
         Put(ts.tdesc(i).np'img&", ");
         case ts.tdesc(i).d.td is
            when dnula => Put("dnula, ");
            when dtipus => Put("dtipus, ");
            when dvar => Put("dvar, ");
            when dproc => Put("dproc, ");
            when dconst => Put("dconst, ");
            when dargc => Put("dargc, ");
            when dcamp => Put("dcamp, ");
         end case;
         Put(ts.tdesc(i).s'img&") "&cons_nom(tn,i));
         New_Line;
      end loop;
      Put_Line("PROFUNDITAT: "&ts.prof'img);
   end printts;


   -- VERSIO 1: llenguatge simple sense estructura
   -- de blocs estil Fortran.
   procedure tbuida
     (ts : out tsimbols) is
      nul_desc : descrip(dnula);
   begin
      ts.prof := 1;
      ts.tambit(ts.prof) := nul_despl;
      for i in 1 .. id_nom'Last loop
         ts.tdesc(i) := (nul_nprof, nul_desc,
                         nul_despl);
      end loop;
   end tbuida;


   procedure posa
     (ts : in out tsimbols;
      id : in id_nom;
      d : in descrip;
      e : out boolean) is
      idespl : rang_despl;
   begin
      e := (ts.tdesc(id).np = ts.prof);
      if not e then
         ts.tambit(ts.prof) := ts.tambit(ts.prof) + 1;
         idespl := ts.tambit(ts.prof);
         while ts.texp(idespl).np = no_prof loop
            idespl:= idespl +1;
            ts.tambit(ts.prof) := 1 + ts.tambit(ts.prof);
         end loop;
         ts.texp(idespl) := (ts.tdesc(id).np,
                             ts.tdesc(id).d, id, 0);
         ts.tdesc(id) := (ts.prof, d, 0);
      end if;
   end posa;


   function cons
     (ts : in tsimbols;
      id : in id_nom)
     return descrip is
   begin
      return ts.tdesc(id).d;
   end cons;


   -- VERSIO 2: Normal, llenguatge amb blocs estil
   -- Pascal.
   procedure Entrabloc
     (Ts : in out Tsimbols) is
   begin
      Ts.Prof := Ts.Prof + 1;
      Ts.Tambit(Ts.Prof) := Ts.Tambit(Ts.Prof - 1);
   end Entrabloc;


   procedure surtbloc
     (ts : in out tsimbols;
      tn : in taula_de_noms) is
      idespl1 : rang_despl;
      idespl2 : rang_despl;
      id : id_nom;
   begin
      idespl1 := ts.tambit(ts.prof);
      ts.prof := ts.prof - 1;
      idespl2 := ts.tambit(ts.prof)+1;
      for idespl in reverse idespl2 .. idespl1 loop
         if ts.texp(idespl).np > no_prof then
            id := ts.texp(idespl).id;
            ts.tdesc(id).d := ts.texp(idespl).d;
            ts.tdesc(id).np := ts.texp(idespl).np;
            ts.tdesc(id).s := ts.texp(idespl).s;
         end if;
      end loop;
   end surtbloc;


   -- VERSIO 3: Blocs mes records.
   procedure posacamp
     (ts : in out tsimbols;
      idr : in id_nom;
      idc : in id_nom;
      d : in descrip;
      e : out boolean) is
      des : descrip;
      td : descriptipus;
      p : rang_despl;
      itdespl : rang_despl;
   begin
      des := ts.tdesc(idr).d;
      if des.td /= dtipus then e := TRUE; end if;

      td := des.dt;
      if td.tt /= tsrec then e := TRUE; end if;

      p := ts.tdesc(idr).s;
      while p /= 0 and then ts.texp(p).id /= idc loop
         p := ts.texp(p).s;
      end loop;

      e := (p /= 0);
      if not e then
         ts.tambit(ts.prof) := ts.tambit(ts.prof) + 1;
         itdespl := ts.tambit(ts.prof);
         ts.texp(itdespl) := (no_prof, d, idc,
                              ts.tdesc(idr).s);
         ts.tdesc(idr).s := itdespl;
      end if;
   end posacamp;


   function conscamp
     (ts : in tsimbols;
      idr : in id_nom;
      idc : in id_nom) return descrip is
      d : descrip;
      td : tdescrip;
      p : rang_despl;
      descnula : descrip(dnula);
   begin
      d := ts.tdesc(idr).d;
      td := d.td;
      p := ts.tdesc(idr).s;
      while p /= 0 and then ts.texp(p).id /= idc loop
         p := ts.texp(p).s;
      end loop;

      if p = 0 then
         return descnula;
      else
         return ts.texp(p).d;
      end if;
   end conscamp;


   -- VERSIO 4: Arrays.
   procedure posa_idx
     (ts : in out tsimbols;
      ida : in id_nom;
      idi : in id_nom;
      e : out boolean) is
      d : descrip;
      dt : descriptipus;
      p : rang_despl;
      pp : rang_despl;
      idespl : rang_despl;
   begin
      E := False;
      d := ts.tdesc(ida).d;
      if d.td /= dtipus then e := TRUE; end if;
      dt := d.dt;
      if dt.tt /= tsarr then e := TRUE; end if;

      p := ts.tdesc(ida).s;
      pp := 0;
      while p /= 0 loop
         pp := p;
         p := ts.texp(p).s;
      end loop;

      ts.tambit(ts.prof) := ts.tambit(ts.prof) + 1;
      idespl := ts.tambit(ts.prof);
      ts.texp(idespl) := (no_prof, (td => dnula),
                          idi, 0);

      if pp /= 0 then
         ts.texp(pp).s := idespl;
      else
         ts.tdesc(ida).s := idespl;
      end if;
   end posa_idx;


   function primer_idx
     (ts : in tsimbols;
      ida : in id_nom) return cursor_idx is
   begin
      return cursor_idx(ts.tdesc(ida).s);
   end primer_idx;


   function idx_valid
     (ci : in cursor_idx) return boolean is
   begin
      return ci > 0;
   end idx_valid;


   function succ_idx
     (ts : in tsimbols;
      ci : in cursor_idx) return cursor_idx is
   begin
      if idx_valid(ci) then
         return cursor_idx(ts.texp(rang_despl(ci)).s);
      else
         return 0; --Excepcio
      end if;
   end succ_idx;


   function cons_idx
     (ts : in tsimbols;
      ci : in cursor_idx) return id_nom is
   begin
      return  ts.texp(rang_despl(ci)).id;
   end cons_idx;


   -- PROCEDIMENTS
   procedure posa_arg
     (ts : in out tsimbols;
      idp : in id_nom;
      ida : in id_nom;
      da : in descrip;
      e : out boolean) is
      d : descrip;
      p : rang_despl;
      pp : rang_despl;
      idespl : rang_despl;
   begin
      e:= false;
      d := ts.tdesc(idp).d;
      if d.td /= dproc then e := TRUE; end if;

      p := ts.tdesc(idp).s;
      pp := 0;
      while p /= 0 loop
         pp := p;
         p := ts.texp(p).s;
      end loop;

      ts.tambit(ts.prof) := ts.tambit(ts.prof) + 1;
      idespl := ts.tambit(ts.prof);
      ts.texp(idespl) := (no_prof, da, ida, 0);
      if pp /= 0 then
         ts.texp(pp).s := idespl;
      else
         ts.tdesc(idp).s := idespl;
      end if;
   end Posa_Arg;


   function Primer_Arg
     (Ts : in Tsimbols;
      Idp : in Id_Nom) return Cursor_Arg is
   begin
      return cursor_arg(ts.tdesc(idp).s);
   end Primer_Arg;


   function Succ_Arg
     (ts : in tsimbols;
      ca : in cursor_arg) return cursor_arg is
   begin
      if arg_valid(ca) then
         return cursor_arg(ts.texp(rang_despl(ca)).s);
      else
         return 0; --Excepcio
      end if;
   end Succ_Arg;


   function Arg_Valid
     (Ca : in Cursor_Arg) return Boolean is
   begin
      return Ca > 0;
   end Arg_Valid;


   procedure cons_arg
     (ts : in tsimbols;
      ca : in cursor_arg;
      ida : out id_nom;
      Dn : out Descrip) is
   begin
      Ida := ts.texp(rang_despl(ca)).id;
      Dn := Ts.Texp(Rang_Despl(Ca)).D;
   end Cons_Arg;


   procedure Actualitza
     (Ts : in out Tsimbols;
      Id : in Id_Nom;
      D : in Descrip) is
   begin
      Ts.Tdesc(id).D := D;
   end Actualitza;

end Decls.Dtsimbols;
