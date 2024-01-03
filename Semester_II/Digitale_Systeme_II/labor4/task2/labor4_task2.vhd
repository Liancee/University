library ieee;
use ieee.std_logic_1164.all;

entity labor4_task2 is

	port(
		X : in  std_logic_vector(2 downto 0);
		Y : out std_logic;
		output_c : out std_logic
	);
	
end entity;

architecture Structural of labor4_task2 is

	signal c : std_logic;

begin

	u0: entity work.xor_with_hold_propagation
		port map(
			A => X(0),
			B => X(1),
			Y => c
		);

	u1: entity work.xor_with_hold_propagation
		port map(
			A => X(2),
			B => c,
			Y => Y
		);
		
	output_c <= c;

end architecture;
