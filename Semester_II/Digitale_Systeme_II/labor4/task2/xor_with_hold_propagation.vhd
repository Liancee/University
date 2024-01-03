library ieee;
use ieee.std_logic_1164.all;

entity xor_with_hold_propagation is

    port(
        A, B : in std_logic;
        Y : out std_logic
    );

end entity;

architecture Behavioral of xor_with_hold_propagation is

    signal hold : std_logic := '0';
	 signal internal_y : std_logic := '0';

begin

    process(A, B)
    begin
		  -- einen trigger für einen neuen process einbauen, der ein internal_y auf 'X' setzt und testen ob die nächsten zwei zeilen quasi nur vorgemerkt werden, da sonst 'X' erst nach den 3 ns gesetzt wird. Sonst einen zweiten process machen der auch auf A und B hoert und dort internal_y auf 'X' setzen. Dann noch 'Y <= internal_y' außerhalb setzen und unten 'internal_y <= A XNOR B after 2 ns;' schreiben
        -- internal_y <= 'X';
		  hold <= not hold after 3 ns; -- 3 ns hold time
    end process;

    process(hold)
    begin
        if (A'stable(3 ns) and B'stable(3 ns) and internal_y /= 'X') then
            internal_y <= A xor B after 2 ns; -- (propagation delay (5 ns)) - (already waited hold time (3 ns)) = 2 ns
			else
				internal_y <= 'X';
        end if;
    end process;

	 Y <= internal_y;

end architecture;
