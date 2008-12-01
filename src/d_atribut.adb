-- ------------------------------------------------
--  Paquet de procediments dels atributs
-- ------------------------------------------------
--  Versió		:	0.1
--  Autors		:	José Ruiz Bravo
--					Biel Moyà Alcover
--					Álvaro Medina Ballester
-- ------------------------------------------------
--		En aquest fitxer tenim implementats les 
--	assignacions de cada tipus de token al tipus
--	atribut que li correspon. Cal destacar 
--	l'utilització de la taula de noms en els
--	casos d'identificadors i strings.
--
-- ------------------------------------------------

with 	u_lexica;

use  	u_lexica;

package body d_atribut is

		
	procedure mt_operador (l, c: in natural; op: tipus_operacio; a: out atribut) is
	
	begin	
	
        a := (a_operacio, l, c, op);
        
	end mt_operador;
	
	
	
	procedure mt_simbol (l, c: in natural; simbol: tipus_simbol; a: out atribut) is
	
	begin	
	
		a := (a_simbol, l, c,simbol);
		
	end mt_simbol;
	
	
	
	procedure mt_pclau (l, c: in natural; a: out atribut) is
	
	begin
	
		a := (atom, l, c);
		
	end mt_pclau;
	
	
	
	procedure mt_identificador (l, c: in natural; s: in string; a: out atribut) is
	
		id : id_nom := id_nul;
		
	begin
	
		posa_id(tn, id, s);
		a := (a_ident, l, c, id);
		
	end mt_identificador;
	
	
	
	procedure mt_string (l, c: in natural; s: in string; a: out atribut) is
	
		id : id_nom := id_nul;
		
	begin
	
		posa_str(tn, id, s);
		a := (a_lit_string, l, c, id);
		
	end mt_string;
	
	

	procedure mt_caracter (l, c: in natural; car: in string; a: out atribut) is
	
	begin
	
	   a := (a_lit_car, l, c, car(car'First+1));
	   
	end mt_caracter;
		
		
		
	procedure mt_numero (l, c: in natural; i: in string; a: out atribut) is
	
	begin
	
		a := (a_lit_num, l, c, Integer'value(i));
		
	end mt_numero;
	

end d_atribut;
