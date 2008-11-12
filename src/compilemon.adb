--------------------------------------------------------------------------------
--  *  Prog name compilemon.adb
--  *  Project name compilemon
--  *
--  *  Version 1.0
--  *  Last update 22/10/08
--  *
--  *  Created by Biel MoyÃ  Alcover on 22/10/08.
--  *  Copyright (c) 2008 __MyCompanyName__.
--  *  All rights reserved.
--  *    or (keep only one line or write your own)
--  *  GNAT modified GNU General Public License Ã¡Ã©Ã©
--  *
--------------------------------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
with decls.d_taula_de_noms; use decls.d_taula_de_noms;
with ada.command_line; use ada.command_line;
WITH Compilemon_Io; USE Compilemon_Io;
WITH U_Lexica; USE U_Lexica;
with d_token;use d_token;


procedure compilemon is
   Tn : Taula_De_Noms;
   Tk : Token;

begin
    tbuida(tn);
    Open_Input(Argument(1));
    Tk := Yylex;

    while tk /= end_of_input loop
      Put_Line(Token'Image(Tk));
      Tk:= Yylex;
    END LOOP;
   
    close_input;

 
END Compilemon;



