library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;


entity juegotop is
port(
clk : in STD_LOGIC;
reset : in STD_LOGIC;
boton : in STD_LOGIC;
VS : out STD_LOGIC;
HS : out STD_LOGIC;
RED : out STD_LOGIC_VECTOR (2 downto 0);
GRN : out STD_LOGIC_VECTOR (2 downto 0);
BLUE : out STD_LOGIC_VECTOR (1 downto 0));
end juegotop;

architecture Behavioral of juegotop is

signal ejex,ejey : STD_LOGIC_VECTOR (9 downto 0);
signal vO3,fin,resets,title,fincol1,fincol2 : STD_LOGIC;
signal gapy1,gapy2 : UNSIGNED (7 downto 0);
signal REDa,RED_in,RED_bird,RED_col1,RED_col2,RED_titulo,RED_escenario,RED_punt : STD_LOGIC_VECTOR (2 downto 0);
signal GRNa,GRN_in,GRN_bird,GRN_col1,GRN_col2,GRN_titulo,GRN_escenario,GRN_punt : STD_LOGIC_VECTOR (2 downto 0);
signal BLUEa,BLUE_in,BLUE_bird,BLUE_col1,BLUE_col2,BLUE_titulo,BLUE_escenario,BLUE_punt : STD_LOGIC_VECTOR (1 downto 0);
type miestados is (reposo,func);
signal estado,p_estado : miestados;

COMPONENT VGA_driver
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		RED_in : IN std_logic_vector(2 downto 0);
		GRN_in : IN std_logic_vector(2 downto 0);
		BLUE_in : IN std_logic_vector(1 downto 0);          
		VS : OUT std_logic;
		HS : OUT std_logic;
		vO3 : OUT std_logic;
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0);
		eje_x : OUT std_logic_vector(9 downto 0);
		eje_y : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;
	
	COMPONENT bird
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		resets : in STD_LOGIC;
		ejex : IN std_logic_vector(9 downto 0);
		ejey : IN std_logic_vector(9 downto 0);
		vO3 : IN std_logic;
		boton : IN std_logic;          
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT columnas
	generic(
		colxinit : integer :=640);
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		resets : in STD_LOGIC;
		ejex : IN std_logic_vector(9 downto 0);
		ejey : IN std_logic_vector(9 downto 0);
		vO3 : IN std_logic;
		gapy : IN UNSIGNED (7 downto 0);          
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0);
		fincol : out STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT titulo
	PORT(
		ejex : IN std_logic_vector(9 downto 0);
		ejey : IN std_logic_vector(9 downto 0);       
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT aleatorio
	Generic(
	seedinit : std_logic_vector(7 downto 0) := "01110101");
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		resets : in STD_LOGIC;   
		fincol : in STD_LOGIC;
		gapy : OUT unsigned(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT escenario
	PORT(
		ejex : IN std_logic_vector(9 downto 0);
		ejey : IN std_logic_vector(9 downto 0);          
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT puntuacion
	PORT(
		ejex : IN std_logic_vector(9 downto 0);
		ejey : IN std_logic_vector(9 downto 0);          
		RED : OUT std_logic_vector(2 downto 0);
		GRN : OUT std_logic_vector(2 downto 0);
		BLUE : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

begin

RED<=REDa;
GRN<=GRNa;
BLUE<=BLUEa;



Inst_VGA_driver: VGA_driver PORT MAP(
		clk => clk,
		reset => reset,
		RED_in => RED_in,
		GRN_in => GRN_in,
		BLUE_in => BLUE_in,
		VS => VS,
		HS => HS,
		vO3 => vO3,
		RED => REDa,
		GRN => GRNa,
		BLUE => BLUEa,
		eje_x => ejex,
		eje_y => ejey
	);
	
Inst_bird: bird PORT MAP(
		clk => clk,
		reset => reset,
		resets => resets,		
		ejex => ejex,
		ejey => ejey,
		vO3 => vO3,
		boton => boton,
		RED => RED_bird,
		GRN => GRN_bird,
		BLUE => BLUE_bird
	);
	
col1: columnas 
generic map(
		colxinit => 640)
PORT MAP(
		clk => clk,
		reset => reset,
		resets => resets,
		ejex => ejex,
		ejey => ejey,
		vO3 => vO3,
		gapy => gapy1,
		RED => RED_col1,
		GRN => GRN_col1,
		BLUE => BLUE_col1,
		fincol => fincol1
	);
	
ale1: aleatorio 
Generic map(
	seedinit => "01010111")
PORT MAP(
		clk => clk,
		reset => reset,
		resets => resets,
		fincol =>fincol1,
		gapy => gapy1
	);
	
col2: columnas 

generic map(
		colxinit => 960)
PORT MAP(
		clk => clk,
		reset => reset,
		resets => resets,
		ejex => ejex,
		ejey => ejey,
		vO3 => vO3,
		gapy => gapy2,
		RED => RED_col2,
		GRN => GRN_col2,
		BLUE => BLUE_col2,
		fincol => fincol2
	);
	
ale2: aleatorio 
Generic map(
	seedinit => "01101010")
PORT MAP(
		clk => clk,
		reset => reset,
		resets => resets,
		fincol =>fincol2,
		gapy => gapy2
	);

Inst_titulo: titulo 
PORT MAP(
		ejex => ejex,
		ejey => ejey,
		RED => RED_titulo,
		GRN => GRN_titulo,
		BLUE => BLUE_titulo
	);
	
Inst_escenario: escenario 
PORT MAP(
		ejex => ejex,
		ejey => ejey,
		RED => RED_escenario,
		GRN => GRN_escenario,
		BLUE => BLUE_escenario
	);
	
Inst_puntuacion: puntuacion 
PORT MAP(
		ejex => ejex,
		ejey => ejey,
		RED => RED_punt,
		GRN => GRN_punt,
		BLUE => BLUE_punt
	);
	
sinc: process(clk,reset,p_estado) is 
begin
	if(reset='1')then
		estado<=reposo;
	elsif(rising_edge(clk))then
		estado<=p_estado;
	end if;
end process;



fsm : process(estado,boton,fin) is 
begin
	case estado is
		when reposo =>
			title<='1';
			resets<='1';
			if (boton='1') then
				p_estado<=func;
			else
				p_estado<=reposo;
			end if;
		when func =>
			title<='0';
			resets<='0';
			if (fin='1') then
				p_estado<=reposo;
			else 
				p_estado<=func;
			end if;
	end case;
end process;

dibuja : process(RED_bird,RED_col1,RED_col2,RED_titulo,RED_escenario,RED_punt,GRN_bird,GRN_col1,GRN_col2,GRN_titulo,GRN_escenario,GRN_punt,BLUE_bird,BLUE_col1,BLUE_col2,BLUE_titulo,BLUE_escenario,BLUE_punt,title) is
begin
	if title='0' then
		if(not(RED_bird="000" and GRN_bird="000" and BLUE_bird="00")and(not(RED_col1="000" and GRN_col1="000" and BLUE_col1="00")or not(RED_col2="000" and GRN_col2="000" and BLUE_col2="00"))) then
			fin<='0'; --CAMBIAR
			RED_in<="000";GRN_in<="000";BLUE_in<="00";
		else
			fin<='0';
			if(not(RED_punt="000" and GRN_punt="000" and BLUE_punt="00"))then
				RED_in<=RED_punt;GRN_in<=GRN_punt;BLUE_in<=BLUE_punt;
			else
				if(not(RED_bird="000" and GRN_bird="000" and BLUE_bird="00"))then
					RED_in<=RED_bird;GRN_in<=GRN_bird;BLUE_in<=BLUE_bird;
				elsif(not(RED_col1="000" and GRN_col1="000" and BLUE_col1="00"))then
					RED_in<=RED_col1;GRN_in<=GRN_col1;BLUE_in<=BLUE_col1;
				elsif(not(RED_col2="000" and GRN_col2="000" and BLUE_col2="00"))then
					RED_in<=RED_col2;GRN_in<=GRN_col2;BLUE_in<=BLUE_col2;
				else
					RED_in<=RED_escenario;GRN_in<=GRN_escenario;BLUE_in<=BLUE_escenario;
				end if;
			end if;
		end if;
	else
		fin<='0';
		if (not(RED_titulo="000" and GRN_titulo="000" and BLUE_titulo="00")) then
			RED_in<=RED_titulo;GRN_in<=GRN_titulo;BLUE_in<=BLUE_titulo;
		else
			RED_in<="001";GRN_in<="001";BLUE_in<="11";
		end if;
	end if;
end process;

end Behavioral;

