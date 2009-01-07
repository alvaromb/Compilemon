-- ------------------------------------------------
--  Paquet de procediments de les funcions hash
-- ------------------------------------------------
--  Versio	:	0.2
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Procediments de les funcions de hash:
--			- Hashing quadràtic
--
-- ------------------------------------------------

package body decls.d_hash is

	function fdisp_tn (nom : in string) return rang_dispersio is
		
		a : array (nom'Range) of integer;
		r : array (1..2*nom'Last) of integer;
		
		k, c, m, n : integer;
		
		base : constant integer := character'pos(character'Last)+1;
		
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
		
		c := (r(n+1) * base + r(n)) mod (tam_dispersio);
		
		return rang_dispersio(c);
		
	end fdisp_tn;
	
	
end decls.d_hash;

