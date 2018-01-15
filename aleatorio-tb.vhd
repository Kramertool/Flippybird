--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:24:19 12/14/2017
-- Design Name:   
-- Module Name:   C:/Xilinx/FINAL/test2/test/aleatorio-tb.vhd
-- Project Name:  test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: aleatorio
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
library work;
use PCK_CRC8_D8.all;
 
ENTITY aleatorio_tb IS
END aleatorio_tb;
 
ARCHITECTURE behavior OF aleatorio_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aleatorio
	 Generic(
	seedinit : std_logic_vector(7 downto 0) := "01110101");
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         resets : IN  std_logic;
			fincol : in STD_LOGIC;
         gapy : OUT  unsigned(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal resets : std_logic := '0';
	signal fincol :  STD_LOGIC := '0';

 	--Outputs
   signal gapy : unsigned(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aleatorio 
	Generic map(
	seedinit => "01110101")
	PORT MAP (
          clk => clk,
          reset => reset,
          resets => resets,
			 fincol => fincol,
          gapy => gapy
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset<='1';
      -- hold reset state for 100 ns.
      wait for 10 ns;
		
		reset<='0';
		wait for 1 ns;
		resets<='1';
		wait for 1 ns;
		resets<='0';
		

      wait for 1 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 2 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 2 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 2 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 1 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 10 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 10 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait for 10 ns;
		fincol<='1';
		wait for clk_period/2;
		fincol<='0';
		wait;

      -- insert stimulus here 

      wait;
   end process;

END;
