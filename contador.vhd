----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:58:51 10/23/2017 
-- Design Name: 
-- Module Name:    contador - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
Generic (Nbit: INTEGER := 8);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
enable : in STD_LOGIC;
resets : in STD_LOGIC;
Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end contador;

architecture Behavioral of contador is
signal pQ,Q1 : UNSIGNED (Nbit-1 downto 0);
begin

comb:process(Q1,resets,enable) is
begin
	if resets='1' then
		pQ<=(others=>'0');
	elsif enable='1' then
		pQ<=Q1+1;
	else
		pQ<=Q1;
	end if;
end process;

Q<=STD_LOGIC_VECTOR(Q1);

sinc:process(clk,reset,pQ) is
begin
	if reset='1' then
		Q1<=(others=>'0');
	elsif rising_edge(clk) then
		Q1<=pQ;
	end if;
end process;



end Behavioral;

