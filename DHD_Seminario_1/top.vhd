LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Top IS
	PORT(
		Velocidad			: IN	STD_LOGIC_VECTOR(2 downto 0);
		Reloj					: IN	STD_LOGIC;
		Reset					: IN STD_LOGIC;
		SegDigit1, SegDigit2	: OUT	STD_LOGIC_VECTOR(0 TO 6));
END Top;

ARCHITECTURE estructural OF Top IS

	COMPONENT Div_Frec is 
	Port(	Velocidad 	: IN 	std_logic_vector(2 downto 0);
			Reloj			: IN	std_logic;
			Salida		: OUT	std_logic);
	END COMPONENT;

	COMPONENT contador_8bits is 
	Port(	Reloj		: IN	std_logic;
			Reset		: IN	std_logic;
			Salida	: OUT	std_logic_vector(7 downto 0));
	END COMPONENT;

	COMPONENT dec_7seg is 
	PORT(hex_digit		: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seg_digit		: OUT	STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;

	
	SIGNAL   CKcont : std_logic;
	SIGNAL   Cuenta: std_logic_vector(7 downto 0);


BEGIN
	

	DivisorFrecuencia: Div_Frec PORT MAP(
								Velocidad => Velocidad,
								Reloj =>    Reloj,
								Salida =>   CKcont);
								
	
	Contador8: contador_8bits PORT MAP(
								Reloj => CKcont,
								Reset => Reset,
								Salida =>  Cuenta);
								
	Digito1: dec_7seg PORT MAP(
								hex_digit =>  Cuenta(3 downto 0),
		 						seg_digit => SegDigit1);
								
	Digito2: dec_7seg PORT MAP(
								hex_digit =>  Cuenta(7 downto 4),
			 					seg_digit => SegDigit2);


END estructural;


