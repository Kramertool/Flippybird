----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:20:59 10/23/2017 
-- Design Name: 
-- Module Name:    comparador - Behavioral 
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

entity comparador is
Generic (Nbit: integer :=8;
End_Of_Screen: integer :=10;
Start_Of_Pulse: integer :=20;
End_Of_Pulse: integer := 30;
End_Of_Line: integer := 40);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
data : in STD_LOGIC_VECTOR (Nbit-1 downto 0);
O1 : out STD_LOGIC;
O2 : out STD_LOGIC;
O3 : out STD_LOGIC);
end comparador;

architecture Behavioral of comparador is
signal dataint : integer;
signal pO1,pO2,pO3 : STD_LOGIC;
begin

dataint<=to_integer(Unsigned(data));

comb:process(dataint) is
begin

if dataint>End_Of_Screen then
pO1<='1';
else
pO1<='0';
end if;

if Start_Of_Pulse<dataint AND dataint<End_Of_Pulse then
pO2<='0';
else
pO2<='1';
end if;

if dataint=End_Of_Line then
pO3<='1';
else
pO3<='0';
end if;

end process;

sinc:process(clk,reset,pO1,pO2,pO3) is
begin

if reset='1' then
O1<='0';
O2<='0';
O3<='0';
elsif rising_edge(clk) then

O1<=pO1;
O2<=pO2;
O3<=pO3;

end if;
end process;
end Behavioral;

