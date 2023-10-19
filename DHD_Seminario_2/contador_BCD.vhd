
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity contador_BCD is
	Port(	Reloj		: IN	std_logic;
			Reset		: IN 	std_logic;
			MAX      : out std_logic;
			Salida		: OUT	std_logic_vector(7 downto 0));
end contador_BCD;

architecture funcional of contador_BCD IS

component contador_ascendente is
	generic ( N : natural ;
				 modulo : natural );
	Port(	Reloj		: IN	std_logic;
			Reset		: IN 	std_logic;
			EN			: IN  std_logic;
			MAX      : out std_logic;
			Salida		: OUT	std_logic_vector(N - 1 downto 0));
end component;

signal Digito0, Digito1 : std_logic_vector(3 downto 0);
signal Max_unidades, Max_decenas : std_logic;
begin
	
	Unidades: contador_ascendente 
				generic map (N => 4, modulo => 10)
				port map (
					Reloj		=> Reloj,
					Reset		=> Reset,
					EN			=> '1',
					MAX      => Max_unidades,
					Salida	=> Digito0
				);
	Decenas: contador_ascendente 
				generic map (N => 4, modulo => 6)
				port map (
					Reloj		=> Reloj,
					Reset		=> Reset,
					EN			=> Max_unidades,
					MAX      => Max_decenas,
					Salida	=> Digito1
				);
	Salida <= Digito1 & Digito0;
	MAX <= Max_decenas and Max_unidades;
	
end funcional;
