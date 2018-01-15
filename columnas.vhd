----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:56 11/13/2017 
-- Design Name: 
-- Module Name:    columnas - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity columnas is
	generic(
		colxinit : integer :=640);
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		resets : in STD_LOGIC;
		ejex,ejey : in UNSIGNED (9 downto 0);
		vO3 : in STD_LOGIC;
		gapy : in UNSIGNED (7 downto 0);
		RED,GRN : out STD_LOGIC_VECTOR (2 downto 0);
		BLUE : out STD_LOGIC_VECTOR (1 downto 0);
		fincol : out STD_LOGIC);
end columnas;

architecture Behavioral of columnas is
	signal colx,p_colx : UNSIGNED (11 downto 0) := to_unsigned(0,12);
begin
	
	dibuja : process(ejex,ejey,gapy,colx) is
	begin
		if((ejex >= colx and ejex < colx+50)and(ejey >= gapy+175 or ejey < gapy)) then
			RED<="000";GRN<="111";BLUE<="00";
		else
			RED<="000";GRN<="000";BLUE<="00";
		end if;
	end process;
	
	sinc : process(clk,reset,p_colx) is 
	begin
	if reset='1' then
		colx<=to_unsigned(colxinit,12);
	elsif rising_edge(clk) then
		colx<=p_colx;
	end if;
	end process;

	mov : process(colx,vO3,resets) is
	begin
		if (resets='1') then
			p_colx<=to_unsigned(colxinit,12);
			fincol<='0';
		else
			if(vO3='1') then
				p_colx<=colx-2;
			elsif(colx=0) then
				p_colx<=to_unsigned(640,12);
			else 
				p_colx<=colx;
			end if;
			if colx=4 then
				fincol<='1';
			else
				fincol<='0';
			end if;
		end if;
	end process;
end Behavioral;

