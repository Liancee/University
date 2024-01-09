library ieee;
use ieee.std_logic_1164.all;

entity xor_with_hold_propagation is

    port(
        X : in std_logic_vector(1 downto 0);
        Y : out std_logic := '0'
    );

end entity;

architecture Behavioral of xor_with_hold_propagation is
	
	signal internal_y : std_logic := '0';

begin
	process
	begin
		wait on X(0), X(1);
		if (internal_y /= 'X') then
			Y <= 'X';
			internal_y <= 'X';
			wait for 3 ns; -- wait for hold time
			if (X(0)'stable(3 ns) and X(1)'stable(3 ns)) then
				Y <= internal_y'last_value;
				wait for 2 ns; -- propagation delay (5 ns)) - (already waited hold time (3 ns)) = 2 ns
				Y <= X(0) xor X(1);
				internal_y <= X(0) xor X(1);
			end if;
		end if;
	end process;
end architecture;