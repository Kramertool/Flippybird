----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:10 11/14/2017 
-- Design Name: 
-- Module Name:    aleatorio - Behavioral 
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
use ieee.math_real.all;
library work;
use PCK_CRC8_D8.all;

entity aleatorio is
Generic(
	seedinit : std_logic_vector(7 downto 0) := "01110101");
Port(
	clk: in STD_LOGIC;
	reset : in STD_LOGIC;
	resets : in STD_LOGIC;
	fincol : in STD_LOGIC;
	gapy : out unsigned (7 downto 0));
end aleatorio;

architecture Behavioral of aleatorio is

signal seed,p_seed : Unsigned (7 downto 0) := unsigned(seedinit);
signal gap,p_gap : Unsigned (7 downto 0) := to_unsigned(0,8);
constant seedinit2 : STD_LOGIC_VECTOR (7 downto 0) := "11001110";

begin

--gapy<=gap/2;
--sinc : process (clk,reset,p_gap,p_seed,gap,seed) is
--begin
--	if (reset='1') then
--		gap<=seed;
--		seed<=unsigned(seedinit);
--	elsif(rising_edge(clk))then
--		gap<=p_gap;
--		seed<=p_seed;
--	end if;
--end process;
--
--comb:process(resets,gap,seed,fincol) is
--begin
--	if(resets='1')then
--		p_gap<=(others=>'0');
--		p_seed<=unsigned(seedinit);
--	elsif fincol='1' then
--		p_gap<=seed;
--		p_seed<=seed;
--	else
--		p_gap<=gap;
--		p_seed<=seed+1;
--	end if;
--end process;

gapy<=gap;
sinc : process (clk,reset,p_gap,p_seed,gap,seed) is
begin
	if (reset='1') then
		gap<=seed;
		seed<=unsigned(seedinit);
	elsif(rising_edge(clk))then
		gap<=p_gap;
		seed<=p_seed;
	end if;
end process;

comb:process(resets,gap,seed,fincol) is
begin
	if(resets='1')then
		p_gap<=(others=>'0');
		p_seed<=unsigned(seedinit);
	elsif fincol='1' then
		p_gap<=seed;
		p_seed<=seed;
	else
		p_gap<=gap;
		p_seed<=nextCRC8_D8(seed,unsigned(seedinit2));
	end if;
end process;

end Behavioral;