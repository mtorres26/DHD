

-- Descripci�n de una bola cuadrada que se mueve hacia arriba y hacia abajo, 
-- respetando los m�rgenes superior e inferior de la pantalla.
--
-- Basado en ejemplo de Hamblen, J.O., Hall T.S., Furman, M.D.:
-- Rapid Prototyping of Digital Systems : SOPC Edition, Springer 2008.
-- (Cap�tulo 10) 


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY bola IS
	PORT(
		Red,Green,Blue : OUT std_logic;
	   vs : IN std_logic;
		pixel_Y, pixel_X : IN std_logic_vector(9 downto 0);
		BT1_UP, BT1_DOWN : IN STD_LOGIC;
      BT2_UP, BT2_DOWN : IN STD_LOGIC
		);
END bola;

architecture funcional of bola is
	-- bola
	SIGNAL Bola_on : std_logic;
	SIGNAL Desplaza_Bola_Y: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL Desplaza_Bola_X: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL Bola_Y  : STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(240,10); -- mitad de Y
	SIGNAL Bola_X : STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(320,10); -- mitad de X
	CONSTANT Size_bola: STD_LOGIC_VECTOR(9 DOWNTO 0):= CONV_STD_LOGIC_VECTOR(8,10);

	
	-- palas
	SIGNAL Pala1_on : std_logic;
	SIGNAL Desplaza_Pala1_Y: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL Pala1_Y  : STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(240,10); -- Se inicializa en mitad
	CONSTANT Pala1_X: STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(10,10);
	
	SIGNAL Pala2_on : std_logic;
	SIGNAL Desplaza_Pala2_Y: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL Pala2_Y  : STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(240,10); -- Se inicializa en mitad
	CONSTANT Pala2_X: STD_LOGIC_VECTOR(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(630,10);

	-- Mismo tamaño pa las dos
	CONSTANT Size_Pala_Y: STD_LOGIC_VECTOR(9 DOWNTO 0):= CONV_STD_LOGIC_VECTOR(32,10);
	CONSTANT Size_Pala_X: STD_LOGIC_VECTOR(9 DOWNTO 0):= CONV_STD_LOGIC_VECTOR(8,10);
BEGIN

Red	<= Bola_on or Pala1_on or Pala2_on;
Green	<= Bola_on or Pala1_on or Pala2_on;
Blue	<= Bola_on or Pala1_on or Pala2_on;


------------ BOLA -------------
Dibujar_Bola: Process (Bola_Y, pixel_X, pixel_Y)
BEGIN
	-- Chequear coordenadas X e Y para identificar el area de la bola
	-- Poner Bola_on a '1' para visualizar la bola
	IF (Bola_X <= pixel_X + Size_bola) AND
		(Bola_X + Size_bola >= pixel_X) AND
		(Bola_Y <= pixel_Y + Size_bola) AND
		(Bola_Y + Size_bola >= pixel_Y ) THEN
		Bola_on <= '1';
	ELSE
		Bola_on <= '0';
	END IF;
END process Dibujar_Bola;


Mover_Bola: PROCESS (vs)
BEGIN
	-- Actualizar la posici�n de la bola en cada refresco de pantalla
	IF vs'event and vs = '1' THEN
		-- Detectar los bordes superior e inferior de la pantalla
			IF Bola_Y + Size_bola >= CONV_STD_LOGIC_VECTOR(479,10) THEN
				Desplaza_Bola_Y <= CONV_STD_LOGIC_VECTOR(-2,10);
			ELSIF  Bola_Y <= Size_bola  THEN
				Desplaza_Bola_Y <= CONV_STD_LOGIC_VECTOR(2,10);
			END IF;
			
			
			IF Bola_X + Size_bola >= CONV_STD_LOGIC_VECTOR(639,10) THEN
				Desplaza_Bola_X <= CONV_STD_LOGIC_VECTOR(-2,10);
			ELSIF  Bola_X <= Size_bola  THEN
				Desplaza_Bola_X <= CONV_STD_LOGIC_VECTOR(2,10);
			END IF;
			
			
			IF (Bola_X + Size_bola + Size_Pala_X >= Pala2_X) AND
					(Bola_Y + Size_Pala_Y > Pala2_Y) AND
					(Bola_Y < Pala2_Y + Size_Pala_Y) THEN
						Desplaza_bola_X <= CONV_STD_LOGIC_VECTOR(-2, 10);
			END IF;
			
			IF (Bola_X <= Pala1_X + Size_Pala_X + Size_bola) AND
					(Bola_Y + Size_Pala_Y > Pala1_Y) AND
					(Bola_Y < Pala1_Y + Size_Pala_Y) THEN
						Desplaza_bola_X <= CONV_STD_LOGIC_VECTOR(2, 10);
			END IF;
			
			
			-- Calcular la siguiente posicion de la bola
			Bola_Y <= Bola_Y + Desplaza_Bola_Y;
			Bola_X <= Bola_X + Desplaza_Bola_X;
	END IF;
	
END process Mover_Bola;


Dibujar_Pala: Process (Pala1_Y, Pala2_Y, pixel_X, pixel_Y)
BEGIN
	-- Chequear coordenadas X e Y para identificar el area de la pala
	-- Poner Pala_on a '1' para visualizar la pala
	IF (Pala1_Y <= pixel_Y + Size_Pala_Y) AND
		(Pala1_Y + Size_Pala_Y >= pixel_Y) AND
		(Pala1_X <= pixel_X + Size_Pala_X) AND
		(Pala1_X + Size_Pala_X >= pixel_X) THEN
		Pala1_on <= '1';
	ELSE
		Pala1_on <= '0';
	END IF;
	
	IF (Pala2_Y <= pixel_Y + Size_Pala_Y) AND
		(Pala2_Y + Size_Pala_Y >= pixel_Y) AND 
		(Pala2_X <= pixel_X + Size_Pala_X) AND
		(Pala2_X + Size_Pala_X >= pixel_X) THEN
		Pala2_on <= '1';
	ELSE
		Pala2_on <= '0';
	END IF;
	
END process Dibujar_Pala;



Mover_Pala: PROCESS (vs)
BEGIN
	-- Actualizar la posici�n de la pala en cada refresco de pantalla
	IF vs'event and vs = '1' THEN
		-- Detectar los bordes superior e inferior de la pantalla		
			IF BT1_UP = '0' AND BT1_DOWN = '1' AND Pala1_Y + Size_Pala_Y <= CONV_STD_LOGIC_VECTOR(479,10) THEN
				Desplaza_Pala1_Y <= CONV_STD_LOGIC_VECTOR(2,10);
			ELSIF BT1_UP = '1' AND BT1_DOWN = '0' AND Pala1_Y >= Size_Pala_Y THEN
				Desplaza_Pala1_Y <= CONV_STD_LOGIC_VECTOR(-2,10);
			ELSE
				Desplaza_Pala1_Y <= CONV_STD_LOGIC_VECTOR(0,10);
			END IF;
			
			IF BT2_UP = '0' AND BT2_DOWN = '1' AND Pala2_Y + Size_Pala_Y <= CONV_STD_LOGIC_VECTOR(479,10) THEN
				Desplaza_Pala2_Y <= CONV_STD_LOGIC_VECTOR(2,10);
			ELSIF BT2_UP = '1' AND BT2_DOWN = '0' AND Pala2_Y >= Size_Pala_Y THEN
				Desplaza_Pala2_Y <= CONV_STD_LOGIC_VECTOR(-2,10);
			ELSE
				Desplaza_Pala2_Y <= CONV_STD_LOGIC_VECTOR(0,10);
			END IF;
			
			-- Calcular la siguiente posicion de la pala
			Pala1_Y <= Pala1_Y + Desplaza_Pala1_Y;
			Pala2_Y <= Pala2_Y + Desplaza_Pala2_Y;
	END IF;
	
	
	
END process Mover_Pala;

END funcional;