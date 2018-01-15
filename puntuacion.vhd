----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:37:43 11/13/2017 
-- Design Name: 
-- Module Name:    escenario - Behavioral 
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

entity puntuacion is
	port(
		ejex,ejey : in UNSIGNED (9 downto 0);
		RED,GRN : out STD_LOGIC_VECTOR (2 downto 0);
		BLUE : out STD_LOGIC_VECTOR (1 downto 0));
end puntuacion;

architecture Behavioral of puntuacion is

begin
	dibuja : process(ejex,ejey) is
	begin
		if((ejex >= to_unsigned(0,10) and ejex < to_unsigned(64,10)) and
			(ejey >= to_unsigned(0,10) and ejey < to_unsigned(480,10))) then
			RED<="111";GRN<="111";BLUE<="11";
		else
			RED<="000";GRN<="000";BLUE<="00";
		end if;
	end process;
end Behavioral;

