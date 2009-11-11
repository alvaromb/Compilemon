-- ------------------------------------------------
--  Paquet de declaracions dels tokens
-- ------------------------------------------------
--  Versio	:	0.1
--  Autors	:	Jose Ruiz Bravo
--				Biel Moya Alcover
--				Alvaro Medina Ballester
-- ------------------------------------------------
--		Definicio del tipus token.
--
-- ------------------------------------------------

package d_token is

	type token is 	(pc_procediment,
					pc_inici,
					pc_mentre,
					pc_per,
					pc_entre,
					pc_si,
					pc_sino,
					pc_fi,
					pc_fer,
					pc_constant,
					pc_tipus,
					pc_coleccio,
					pc_registre,
					pc_es,
					pc_llavors,
					pc_no,
					pc_opcio,
					pc_casos,
					pc_entra,
					pc_surt,
					pc_nou,
					pc_nul,
					pc_de,
					pc_modul,
					pc_inclou,
					pc_usa,
					pc_rang,
					s_assignacio,
					s_dospunts,
					s_final,
					s_coma,
					s_parentesiobert,
					s_parentesitancat,
					s_puntsrang,
					s_puntrec,
					pc_or,
					pc_and,
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
