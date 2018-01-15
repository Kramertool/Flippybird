library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_driver is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
RED_in : in STD_LOGIC_VECTOR (2 downto 0);
GRN_in : in STD_LOGIC_VECTOR (2 downto 0);
BLUE_in : in STD_LOGIC_VECTOR (1 downto 0);
VS : out STD_LOGIC;
HS : out STD_LOGIC;
vO3 : out STD_LOGIC;
RED : out STD_LOGIC_VECTOR (2 downto 0);
GRN : out STD_LOGIC_VECTOR (2 downto 0);
BLUE : out STD_LOGIC_VECTOR (1 downto 0);
eje_x : out STD_LOGIC_VECTOR (9 downto 0);
eje_y : out STD_LOGIC_VECTOR (9 downto 0));
end VGA_driver;

architecture Behavioral of VGA_driver is

signal clk_pixel,p_clk_pixel,Blank_H,Blank_V : STD_LOGIC;
signal hO1,hO2,hO3,vO1,vO2,vO3a,enable_contv : STD_LOGIC;
signal eje_xa,eje_ya : STD_LOGIC_VECTOR (9 downto 0);

component contador is
Generic (Nbit: INTEGER := 8);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
enable : in STD_LOGIC;
resets : in STD_LOGIC;
Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end component;

component comparador is
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
end component;

begin

enable_contv<= clk_pixel AND hO3;
p_clk_pixel <= not clk_pixel;
vO3<=vO3a;
eje_x<=eje_xa;
eje_y<=eje_ya;

div_frec : process(clk,reset) is
begin
if reset='1' then
clk_pixel<='0';
elsif rising_edge(clk) then
clk_pixel<=p_clk_pixel;
end if;
end process;	

gen_color:process(Blank_H,Blank_V,RED_in,GRN_in,BLUE_in) is
begin
if(Blank_H='1' or Blank_V='1') then
RED<=(others=>'0');GRN<=(others=>'0');BLUE<=(others=>'0');
else
RED<=RED_in; GRN<=GRN_in; BLUE<=BLUE_in;
end if;
end process;

conth : contador
GENERIC MAP (Nbit=>10)
PORT MAP(
clk=>clk,
reset=>reset,
enable=>clk_pixel,
resets=>hO3,
Q=>eje_xa);

contv : contador
GENERIC MAP (Nbit=>10)
PORT MAP(
clk=>clk,
reset=>reset,
enable=>enable_contv,
resets=>vO3a,
Q=>eje_ya);

comph : comparador
GENERIC MAP(
Nbit=>10,
End_Of_Screen=>639,
Start_Of_Pulse=>655,
End_Of_Pulse=>751,
End_Of_Line=>799)
PORT MAP(
clk=>clk,
reset=>reset,
data=>eje_xa,
O1=>hO1,
O2=>hO2,
O3=>hO3);

compv : comparador
GENERIC MAP(
Nbit=>10,
End_Of_Screen=>479,
Start_Of_Pulse=>489,
End_Of_Pulse=>491,
End_Of_Line=>520)
PORT MAP(
clk=>clk,
reset=>reset,
data=>eje_ya,
O1=>vO1,
O2=>vO2,
O3=>vO3a);

comb:process(hO1,hO2,vO1,vO2) is
begin
HS<=hO2;
VS<=vO2;
Blank_h<=hO1;
Blank_v<=vO1;
end process;

end Behavioral;

