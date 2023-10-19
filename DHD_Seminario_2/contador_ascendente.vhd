
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity contador_ascendente is
	generic ( N : natural := 8;
				 modulo : natural := 256);
	Port(	Reloj		: IN	std_logic;
			Reset		: IN 	std_logic;
			EN			: IN  std_logic;
			MAX      : out std_logic;
			Salida		: OUT	std_logic_vector(N - 1 downto 0));
end contador_ascendente;

architecture funcional of contador_ascendente IS
signal contador : std_logic_vector(N - 1 downto 0);
begin
	process (Reloj, Reset, contador)
	begin
	if Reset='1' then 
		contador  <= (others => '0');
	elsif reloj'event AND Reloj = '1' then		
	  if EN = '1' then 
			if contador = modulo -1 then 
					contador <= (others => '0');
			else 
					contador <= contador + 1;
			end if;
	  end if;
	end if;	
	if (contador = modulo -1) then MAX <= '1'; else MAX <= '0'; end if;
	end process;
	
	Salida <= contador;
	
end funcional;
