

-- Descripción de una procesador que ejecuta cuatro instrucciones. 
-- Basado en ejemplo de Hamblen, J.O., Hall T.S., Furman, M.D.:
-- Rapid Prototyping of Digital Systems : SOPC Edition, Springer 2008.
-- (Capítulo 9) 


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY procesador_v2_0 IS
PORT( clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		AC_out : out std_logic_vector(15 downto 0);
		IR_out : out std_logic_vector(15 downto 0);
		PC_out : out std_logic_vector(7 downto 0);
		MEMq : in std_logic_vector(15 downto 0);
		MEMdata: out std_logic_vector(15 downto 0);
		MEMwe : out std_logic;
		MEMadr : out std_logic_vector(7 downto 0)
		);
END procesador_v2_0;

ARCHITECTURE rtl OF procesador_v2_0 IS
	TYPE STATE_TYPE IS ( reset_pc, fetch1, decode, add1, add2, sub1, sub2,
								nand1, nand2, load1, store0, store1, jump);
	SIGNAL state: STATE_TYPE;
	SIGNAL IR, AC, TEMP: STD_LOGIC_VECTOR(15 DOWNTO 0 ); -- CAMBIO REALIZADO: PONER TEMP
	SIGNAL PC : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	
	BEGIN
	
	
	-- Asignaciones a puertos de salida
	--	
	AC_out <= AC;
	IR_out <= IR;
	PC_out <= PC;


FSMD: PROCESS ( CLOCK, RESET, state, PC, AC, IR, TEMP )

BEGIN

-- Asignaciones a REGISTROS en datapath y MAQUINA DE ESTADOS de la unidad de control
IF reset = '1' THEN
	state <= reset_pc;
	ELSIF clock'EVENT AND clock = '1' THEN
	 CASE state IS   
		WHEN reset_pc =>
			PC	<= "00000000";
			AC <= "0000000000000000";
			state <= fetch1;		
		WHEN fetch1 =>
			IR <= MEMq;
			PC <= PC + 1;
			state <= decode;	
		WHEN decode =>
			CASE IR( 15 DOWNTO 8 ) IS
				WHEN "00000000" =>
					state <= add1;
				WHEN "00000001" =>
					state <= store0;
				WHEN "00000010" =>
					state <= load1;
				WHEN "00000011" =>
					state <= jump;
				WHEN "00000100" =>
					state <= sub1;
				WHEN "00000101" =>
					state <= nand1;
				WHEN OTHERS =>
					state <= fetch1;
			END CASE;
		WHEN add1 =>
			TEMP <= MEMq;
			state <= add2;	
		WHEN add2 =>
			AC <= AC + TEMP;
			state <= fetch1;
		WHEN store0 =>
			state <= store1;
		WHEN store1 =>
			state <= fetch1;				
		WHEN load1 =>
			AC <= MEMq;
			state <= fetch1;			
		WHEN jump =>
			PC <= IR( 7 DOWNTO 0 );
			state <= fetch1;	
		WHEN sub1 =>
			TEMP <= MEMq;
			state <= sub2;
		WHEN sub2 =>
			AC <= AC - TEMP;
			state <= fetch1;
		WHEN nand1 =>
			TEMP <= MEMq;
			state <= nand2;
		WHEN nand2 =>
			AC <= AC NAND TEMP;
			state <= fetch1;
		WHEN OTHERS =>
			state <= fetch1;	
	 END CASE;
	END IF;
	
-- Asignaciones a BUSES de entrada a MEMORIA (Direcciones, Datos y control de escritura)
 
	CASE state IS
		WHEN reset_pc =>
			MEMadr <= "00000000";
			MEMwe <= '0';
			MEMdata <= (others =>'-'); 
		WHEN add2 | store1 | load1 | sub2 | nand2 =>
			MEMadr <= PC;
			MEMwe <= '0';
			MEMdata <= (others =>'-');
		WHEN store0  => 
			MEMadr <= IR(7 downto 0);
			MEMwe <= '1';
			MEMdata <= AC;
		WHEN others =>  
			MEMadr <= IR(7 downto 0);
			MEMwe <= '0';
			MEMdata <= (others =>'-');
	end case;
	
END PROCESS;


END rtl;