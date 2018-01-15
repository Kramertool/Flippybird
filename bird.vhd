----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:19:11 11/06/2017 
-- Design Name: 
-- Module Name:    bird - Behavioral 
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

entity bird is
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		resets : in STD_LOGIC;
		ejex,ejey : in UNSIGNED (9 downto 0);
		vO3 : in STD_LOGIC;
		boton : in STD_LOGIC;
		RED,GRN : out STD_LOGIC_VECTOR (2 downto 0);
		BLUE : out STD_LOGIC_VECTOR (1 downto 0));
end bird;

architecture Behavioral of bird is
	constant vyinit : integer := 12;
	signal posy,p_posy : UNSIGNED (9 downto 0) :=to_unsigned(0,10);
	signal vy,p_vy : unsigned (5 downto 0) :=to_unsigned(0,6);
	constant gravedad : integer :=1;
	Type miestado is (reposo,actposy,actvy,subir,aux);
	signal estado,p_estado : miestado;
	signal arriba,p_arriba : STD_LOGIC;
	
begin
	dibuja : process(ejex,ejey,posy) is
	begin
		if((ejex >= to_unsigned(248,10) and ejex < to_unsigned(280,10))and(ejey >= posy and ejey < posy+32)) then
			RED<="111";GRN<="100";BLUE<="00";
		else 
			RED<="000";GRN<="000";BLUE<="00";
		end if;
	end process;
	
	sinc : process(clk,p_estado,reset,p_vy,p_posy,p_arriba) is 
	begin
	if reset='1' then
		estado<=reposo;
		vy<=(others=>'0');
		posy<=to_unsigned(260,10);
		arriba<='0';
	elsif rising_edge(clk) then
		estado<=p_estado;
		vy<=p_vy;
		posy<=p_posy;
		arriba<=p_arriba;
	end if;
	end process;

	moore : process(vO3,posy,vy,estado,arriba,boton,resets) is
	begin
		if resets='1' then
			p_estado<=reposo;
			p_vy<=(others=>'0');
			p_posy<=to_unsigned(260,10);
			p_arriba<='0';
		else
			case estado is
				when reposo =>
					p_vy<=vy;
					p_arriba<=arriba;
					p_posy<=posy;
					if vO3='1' then
						p_estado<=actposy;
					elsif boton='1' and arriba='0' then
						p_estado<=aux;
					else
						p_estado<=reposo;
					end if;
				when actposy =>
					if arriba='1' then
						if posy-vy<=30 then
							p_posy<=to_unsigned(30,10);
						else
							p_posy<=posy-vy;
						end if;
					else
						if posy+vy >= 400 then
							p_posy<=to_unsigned(420,10);
						else
							p_posy<=posy+vy;
						end if;
					end if;
					p_estado<=actvy;
					p_vy<=vy;
					p_arriba<=arriba;
				when actvy =>
					if arriba='1' then
						if(vy>gravedad) then
							p_vy<=vy-gravedad;
							p_arriba<=arriba;
						else
							p_arriba<='0';
							p_vy<=vy;
						end if;
					else 
						if vy < 16 then
							p_vy<=vy+gravedad;
						else
							p_vy <= vy;
						end if;
						p_arriba<=arriba;
					end if;
					p_posy<=posy;
					if boton='1' then
						p_estado<=aux;
					else
						p_estado<=reposo;
					end if;
				when aux =>
					if boton='0' then
						p_estado<=subir;
					elsif vO3='1' then
						p_estado<=actposy;
					else
						p_estado<=aux;
					end if;
					p_vy<=vy;
					p_arriba<=arriba;
					p_posy<=posy;
				when subir =>
					p_arriba<='1';
					p_vy<=to_unsigned(vyinit,6);
					p_estado<=reposo;
					p_posy<=posy;
			end case;
		end if;
	end process;
end Behavioral;

