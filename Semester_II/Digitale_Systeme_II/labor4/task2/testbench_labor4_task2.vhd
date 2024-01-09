library ieee;
use ieee.std_logic_1164.all;

entity testbench_labor4_task2 is
end entity;

architecture Testbench of testbench_labor4_task2 is

	--signal X : std_logic_vector(2 downto 0) := "000";
	--signal P : std_logic := '0';
	--signal c: std_logic;
	signal X : std_logic_vector(1 downto 0) := "00";
	signal Y : std_logic := '0';

    --SIGNAL Q_Desired : STD_LOGIC_VECTOR(3 DOWNTO 0);
    --SIGNAL Y : STD_LOGIC;

begin

--	DUT0: entity work.labor4_task2
--		port map(
--			X => X,
--			Y => P,
--			output_c => c
--		);

	DUT0: entity work.xor_with_hold_propagation
		port map(
			X => X,
			Y => Y
		);

	process
	begin

		X(0) <= '1' after 20 NS, '0' after 50 NS,  '0' after 82 NS, '1' after 85 NS;
		X(1) <= '1' after 40 NS, '0' after 80 NS, '1' after 81 NS, '0' after 90 NS;
		--X(2) <= '1' after 60 NS, '0' after 61 NS, '1' after 65 NS;

--        Q_Desired <= "0000",
--        "1000" AFTER 5 NS,
--        "0100" AFTER 15 NS,
--        "1010" AFTER 25 NS,
--        "0101" AFTER 35 NS,
--        "0010" AFTER 45 NS,
--        "0001" AFTER 55 NS,
--        "0000" AFTER 65 NS,
--        "1000" AFTER 75 NS,
--        "1100" AFTER 85 NS,
--        "1110" AFTER 95 NS,
--        "0111" AFTER 105 NS,
--        "1011" AFTER 115 NS;

		wait;

	end process;

--    PROCESS (Q, Q_Desired)
--    BEGIN
--        Y <= (Q(0) XNOR Q_Desired(0)) AND
--             (Q(1) XNOR Q_Desired(1)) AND
--             (Q(2) XNOR Q_Desired(2)) AND
--             (Q(3) XNOR Q_Desired(3));
--    END PROCESS;

end architecture;
