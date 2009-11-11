-- ------------------------------------------------
--  Paquet de declaracions dels tokens
-- ------------------------------------------------
--  Versió	:	0.2
--  Autors	:	José Ruiz Bravo
--				Biel Moyà Alcover
--				Álvaro Medina Ballester
-- ------------------------------------------------
--		Definició del tipus token.
--
-- ------------------------------------------------

package d_token is

	type token is  (pc_procedure,
					pc_begin,
					pc_while,
					--pc_entre,
					pc_if,
					pc_else,
					pc_end,
					pc_do,
					pc_constant,
					pc_type,
					pc_array,
					pc_record,
					pc_is,
					pc_then,
					pc_not,
					pc_in,
					pc_out,
					pc_new,
					pc_null,
					pc_of,
					pc_mod,
					pc_range,
					pc_and,
					pc_or,
					s_assignacio,
					s_dospunts,
					s_final,
					s_coma,
					s_parentesiobert,
					s_parentesitancat,
					s_puntsrang,
					s_puntrec,
					op_menor,
					op_menorigual,
					op_majorigual,
					op_major,
					op_igual,
					op_distint,
					op_suma,
					op_resta,
					op_multiplicacio,
					op_divisio,
					id,
					cadena,
					const,
					Error,
					End_of_Input);
			
					
end d_token;
