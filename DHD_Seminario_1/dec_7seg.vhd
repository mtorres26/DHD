LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

-- Conversor de hexadecimal a codigo de 7 segmentos
-- Los LEDs se iluminan en baja

ENTITY dec_7seg IS
	
	PORT(hex_digit		: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seg_digit		: OUT STD_LOGIC_VECTOR(0 TO 6));

END dec_7seg;

ARCHITECTURE a OF dec_7seg IS
	
BEGIN
	PROCESS  (Hex_digit)
		
	BEGIN
		
	  CASE Hex_digit IS
         WHEN "0000" =>
             seg_digit <= "0000001";
         WHEN "0001" =>
             seg_digit <= "1001111";
         WHEN "0010" =>
             seg_digit <= "0010010";
         WHEN "0011" =>
             seg_digit <= "0000110";
         WHEN "0100" =>
             seg_digit <= "1001100";
       	 WHEN "0101" =>
             seg_digit <= "0100100";
       	 WHEN "0110" =>
             seg_digit <= "0100000";
    	 WHEN "0111" =>
             seg_digit <= "0001111";
 	     WHEN "1000" =>
             seg_digit <= "0000000";
     	 WHEN "1001" =>
             seg_digit <= "0000100"; 
         WHEN "1010" =>
             seg_digit <= "0001000";
       	 WHEN "1011" =>
             seg_digit <= "1100000"; 
       	 WHEN "1100" =>
             seg_digit <= "0110001"; 
       	 WHEN "1101" =>
       		 seg_digit <= "1000010"; 
      	 WHEN "1110" =>
      	     seg_digit <= "0110000"; 
      	 WHEN "1111" =>
      	     seg_digit <= "0111000"; 
	   	 WHEN OTHERS =>
        	 seg_digit <= "1000001";
	  END CASE;
	END PROCESS;
	
	

END a;

