
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------
Entity Div_Frec is
	Port(	Velocidad 	: IN std_logic_vector(0 to 2);
			Reloj			: IN	std_logic;
		   Salida		: OUT	std_logic);
End Div_Frec;
--------------
Architecture funcional of Div_Frec IS
Signal Contador : std_logic_vector(25 downto 0); --valores 0 a 67108863;
signal Salida_int : std_logic;
begin
	process (Reloj)
	begin
		if reloj'event AND Reloj = '1' then		
			Contador <= Contador + 1;
			Salida <= Salida_int;
		end if;
	end process;

	Salida_int <= 	contador(25) WHEN velocidad = "000" ELSE
			contador(24) WHEN velocidad = "001" ELSE
			contador(23) WHEN velocidad = "010" ELSE
			contador(22) WHEN velocidad = "011" ELSE
			contador(21) WHEN velocidad = "100" ELSE
			contador(20) WHEN velocidad = "101" ELSE
			contador(19) WHEN velocidad = "110" ELSE
			contador(18) WHEN velocidad = "111" ELSE '0';
end funcional;

