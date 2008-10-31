-- Generador de n's aleatorios
-- para el Hash de Pearson

with Ada.text_io;
use Ada.text_io;
with Ada.Command_line;
use Ada.Command_line;
with Ada.Integer_text_io;
use Ada.Integer_text_io;
with Text_io;

procedure random is
	type matriz is array (0..255) of integer;
	m: matriz;
	k: integer;
	s: integer;
	fichero: File_Type;
	
	puta: string := "putamierda";
	mierda: string := "mierdaperra";
begin
	for i in m'Range loop
		m(i) := i;
	end loop;
	
	k := 7;
	Create(fichero, Name => "vector.txt");
	for i in 0..3 loop
		for j in 0..255 loop
			s := m(i);
			k := (k+s) mod 256;
			m(i) := m(k);
			m(k) := s;
		end loop;
	end loop;
	
	
	
	-- Pintamos el array pa ver si ta bien
	-- Guardamos el array en un fichero de texto
	for i in 0..255 loop
		Put(m(i));
		new_line;
		put(m(i)'img);
		Text_io.Put_Line(fichero, m(i)'img);
	end loop;
	
	Close(fichero);
	
	put("CACA"); new_line;
	
	put(character'POS(puta(1))); new_line;
	put(character'POS(mierda(1))); new_line;
	put(character'POS(mierda(7))); new_line;
	
end random;