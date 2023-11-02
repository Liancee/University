LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Testbench_Adder4BitParity IS
END ENTITY;

ARCHITECTURE Testbench OF Testbench_Adder4BitParity IS


	-- Signale fuer die Eingabe- und Ausgabewerte
	SIGNAL A, B : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL SUM : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL EVEN_PARITY, ODD_PARITY : BIT;

BEGIN
	DUT: ENTITY WORK.Adder4BitParity
		PORT MAP (
			A => A,
			B => B,
			SUM => SUM,
			EVEN_PARITY => EVEN_PARITY,
			ODD_PARITY => ODD_PARITY
		);

	-- Testprozess
	PROCESS
	BEGIN
		-- Testfall 1: Hoechster Zustand
		A <= "1111";
		B <= "1111";
		WAIT FOR 10 ns;
        
		-- Testfall 2: Kleinster Zustand
		A <= "0000";
		B <= "0000";
		WAIT FOR 10 ns;
        
		-- Testfall 3: Zustand dazwischen 1
		A <= "0001";
		B <= "0000";
		WAIT FOR 10 ns;
        
		-- Testfall 4: Zustand dazwischen 2
		A <= "1001";
		B <= "0110";
		WAIT FOR 10 ns;
		
		-- Testfall 5: Zustand dazwischen 3
		A <= "1101";
		B <= "1110";
		WAIT FOR 10 ns;
        
		-- Testfall 6: Zustand dazwischen 4
		A <= "1110";
		B <= "0111";
		WAIT FOR 10 ns;

		-- Testfall 7: Zustand dazwischen 5
		A <= "0101";
		B <= "1100";
		WAIT FOR 10 ns;
		
		-- Testfall 8: Zustand dazwischen 6
		A <= "0001";
		B <= "0100";
		WAIT FOR 10 ns;
		
		-- Hier koennen weitere Testfaelle hinzugefuegt werden
        
		WAIT; -- Endlosschleife
	END PROCESS;
END ARCHITECTURE;

