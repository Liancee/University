library ieee;
use ieee.std_logic_1164.all;

entity labor4_task3 is

	port(
		X, Clk, Reset : in std_logic;
		Y : out std_logic
	);
	
end entity;

architecture Structural of labor4_task3 is

	constant FF_1_Clr_Placeholder : std_logic := '0';

	component D_FF 
		port(
			D, Clk, Clr : in std_logic;
			Q : out std_logic
		);
	end component;

	signal a, b, c : std_logic := '0';
	--signal extra_delta_cycle : std_logic := '0';
	
begin

	FF_1: D_FF 
		port map(
			D => X,
			Clk => Clk,
			Clr => FF_1_Clr_Placeholder,
			Q => a
		);
		
	FF_2: D_FF 
		port map(
			D => c,
			Clk => Clk,
			Clr => Reset,
			Q => b
		);
		
		Y <= b;
		
		c <= a xor b;

		--extra_delta_cycle <= a xor b;
		--c <= extra_delta_cycle;
		
		-- the beneath would remove a delta cycle but change the logic. there is a better solution for removing one
		-- by replacing the internal_Q signal with Q in 'D_FF.vhdl' note that Q doesn't have a default value then?
--	process(Clk)
--	begin
--		if (Clk'event and Clk = '0') then
--			c <= a xor b;
--		end if;
--	end process;

end architecture;