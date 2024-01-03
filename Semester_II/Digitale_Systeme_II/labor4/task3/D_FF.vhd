library ieee;
use ieee.std_logic_1164.all;

entity D_FF is

	port(
		D, Clk, Clr : in std_logic;
		Q : out std_logic
	);
	
end entity;

architecture Behavioral of D_FF is

	signal internal_Q : STD_LOGIC := '0';
	
begin

	process(Clk, Clr)
   begin
	
		if (Clr = '1') then
			internal_Q <= '0';
		elsif (Clk'event and Clk = '0') then
			internal_Q <= D;
		end if;
		
	end process;
	
	Q <= internal_Q;
	
end architecture;