library ieee;
use ieee.std_logic_1164.all;

entity xor_with_hold_propagation is

    port(
        X : in std_logic_vector(2 downto 0);
        Y : out std_logic := '0'
    );

end entity;

architecture Behavioral of xor_with_hold_propagation is
	
	signal internal_y : std_logic := '0';
	signal internal_c, c : std_logic := '0';

begin
	process
	begin
		wait on X(0), X(1);
		if (c /= 'X') then
			c <= 'X';
			wait for 3 ns; -- wait for hold time
			if (X(0)'stable(3 ns) and X(1)'stable(3 ns)) then
				c <= internal_c'last_value;
				wait for 2 ns; -- propagation delay (5 ns)) - (already waited hold time (3 ns)) = 2 ns
				c <= X(0) xor X(1);
				internal_c <= X(0) xor X(1);
			else 
				internal_c <= 'X';
			end if;
		end if;
	end process;

	process
	begin
		wait on X(2), internal_c;
		if (internal_y /= 'X') then
			Y <= 'X';
			internal_y <= 'X';
			wait for 3 ns; -- wait for hild time
			if (c'stable(3 ns) and X(2)'stable(3 ns) and internal_c /= 'X') then
				Y <= internal_y'last_value;
				wait for 2 ns; -- propagation delay (5 ns)) - (already waited hold time (3 ns)) = 2 ns
				Y <= X(2) xor c;
				internal_y <= X(2) xor c;
				wait for 0 ns;
			end if;
		end if;
	end process;

end architecture;