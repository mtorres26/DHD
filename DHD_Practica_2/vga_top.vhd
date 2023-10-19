
-- Descripci�n que visualiza franjas de colores en un monitor VGA
--
-- Basado en ejemplo de Hamblen, J.O., Hall T.S., Furman, M.D.:
-- Rapid Prototyping of Digital Systems : SOPC Edition, Springer 2008.
-- (Cap�tulo 10) 


LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

LIBRARY lpm;
USE lpm.lpm_components.ALL;


ENTITY vga_top IS

PORT(	
      CLOCK_50			     : IN STD_LOGIC;
		VGA_R		: OUT STD_LOGIC_vector(0 to 7);
		VGA_G		: OUT STD_LOGIC_vector(0 to 7);
		VGA_B		: OUT STD_LOGIC_vector(0 to 7);
		VGA_BLANK_N		: OUT STD_LOGIC;
		VGA_HS		: OUT STD_LOGIC;
		VGA_VS		: OUT STD_LOGIC;
		VGA_CLK		: OUT STD_LOGIC;
		BT1_UP, BT1_DOWN, BT2_UP, BT2_DOWN : IN STD_LOGIC
		
		);

END vga_top;

ARCHITECTURE funcional OF vga_top IS

	COMPONENT vga_PLL
		PORT(
			inclk0		: IN STD_LOGIC  := '0';
			c0		: OUT STD_LOGIC );
	END COMPONENT;
	
	COMPONENT controlador_vga_640_x_480_60
		PORT(	
			clock_25		: 	IN	STD_LOGIC;
			R,G,B       : 	IN STD_LOGIC;
			VGA_R, VGA_G, VGA_B : OUT	STD_LOGIC;
			vga_blank_N	:	OUT	STD_LOGIC;
			vga_hs		:	OUT     STD_LOGIC;
			vga_vs		:	OUT     STD_LOGIC;
			vga_clk		:	OUT     STD_LOGIC;
			pixel_y		:	OUT     STD_LOGIC_VECTOR(9 DOWNTO 0);
			pixel_x		:	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0));		
	END COMPONENT;
	
COMPONENT bola
	  PORT (
			Red, Green, Blue : OUT STD_LOGIC;
			vs : IN STD_LOGIC;
			pixel_Y, pixel_X : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			BT1_UP, BT1_DOWN : IN STD_LOGIC;
			BT2_UP, BT2_DOWN : IN STD_LOGIC
	  );
END COMPONENT;

SIGNAL clock_25 : STD_LOGIC;
SIGNAL R_Data, G_Data, B_Data : STD_LOGIC;
SIGNAL pixel_x, pixel_y	: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL vs_signal : STD_LOGIC;


BEGIN

vga_vs <= vs_signal;

	-- PLL para generar el reloj de 25 MHz
PLL: vga_pll PORT MAP (
		inclk0 => clock_50,
		c0 => clock_25);
		

	-- Controlador de la VGA
VGA:  controlador_vga_640_x_480_60 PORT MAP (	
		clock_25	=> clock_25,
		R => R_data,
		G => G_data,
		B => B_data,	
		vga_r	=> vga_R(7),
		vga_g => vga_g(7),
		vga_b => vga_b(7),
		vga_blank_n => vga_blank_n,
		vga_hs => vga_hs, 
		vga_vs => vs_signal, 
		vga_clk	=> vga_clk,
		pixel_y => pixel_y, 
		pixel_x => pixel_x);		
		
INST_BOLA : bola PORT MAP(
	  Red => R_data,
	  Green => G_data,
	  Blue => B_data,
	  vs => vs_signal,
	  pixel_Y => pixel_y,
	  pixel_X => pixel_x,
	  BT1_UP => BT1_UP,
	  BT1_DOWN => BT1_DOWN,
	  BT2_UP => BT2_UP,
	  BT2_DOWN => BT2_DOWN
);
			
			 	

END funcional;

