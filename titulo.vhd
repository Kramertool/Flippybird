library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity titulo is
port(
	ejex,ejey : in UNSIGNED (9 downto 0);
	RED,GRN : out STD_LOGIC_VECTOR (2 downto 0);
	BLUE : out STD_LOGIC_VECTOR (1 downto 0));
end titulo;

architecture Behavioral of titulo is

begin
	dibuja : process(ejex,ejey) is
	begin
		if((ejex >= to_unsigned(120,10) and ejex < to_unsigned(520,10)) and (ejey >= to_unsigned(100,10) and ejey < to_unsigned(220,10))) then
			RED<="111";GRN<="000";BLUE<="00";
		else
			RED<="000";GRN<="000";BLUE<="00";
		end if;
	end process;

end Behavioral;

