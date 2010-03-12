

with decls-dtnode;

use decls-dtnode;


package decls.d_arbre is


	type arbre is private;


	procedure abuit(p: out arbre);
	--Se ha pensado crear un 'creanode' por cada 'when': 
		-- 1º parametro servira para el linkaje
		-- 2º parametro servira para el tipo de nodo
		-- Siguientes parametros informacion y nodos hijos

--	procedure posa(r: in out arbre; e: in character);
--	function consulta(i: in arbre) return character;
--	function existeix(r: in arbre) return boolean;
--	function fe(r: in arbre) return arbre;
--	function fc(r: in arbre) return arbre;
--	function fd(r: in arbre) return arbre;
--	function empelta(op: in character; fe: in arbre; fd: in arbre) return arbre;
--	procedure inordre_r(r: in arbre);


private
	
	arbre : pnode;



end decls.d_arbre;
