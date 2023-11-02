LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Testbench_labor_2 IS
END ENTITY;

ARCHITECTURE Testbench OF Testbench_labor_2 IS

	-- Signale fuer die Eingabe- und Ausgabewerte
	
	-- Signals labor_2
	SIGNAL A, B : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL S, E : BIT;
	SIGNAL Y : BIT;
	
	-- Signals Adder4BitParity
	SIGNAL SUM : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL EVEN_PARITY, ODD_PARITY : BIT;
	
	-- Signal MUX_2TO1
	SIGNAL P_IN : BIT;

	-- Signals Testbench
	SIGNAL Y_XNOR_desired_cond : BIT;
	SIGNAL DESIRED_CONDITION : BIT;
	
BEGIN
	DUT: ENTITY WORK.labor_2
		PORT MAP (
			A => A,
			B => B,
			S => S,
			E => E,
			Y => Y
		);
		
	DUT2: ENTITY WORK.Adder4BitParity
		PORT MAP (
			A => A,
			B => B,
			SUM => SUM,
			EVEN_PARITY => EVEN_PARITY,
			ODD_PARITY => ODD_PARITY
		);
		
	DUT3: ENTITY WORK.MUX_2TO1
		PORT MAP(
			A => ODD_PARITY, 
			B => EVEN_PARITY, 
			S => S, 
			E => E,
			Y => P_IN
		);
		
	-- Testprozess
	PROCESS
	BEGIN
	
		-- only enabled outputs are interesting cuz otherwise nothing will be send through
		E <= '1';
		
		-- Testfall 1: Hoechster Zustand
		DESIRED_CONDITION <= '0'; -- falsch zur veranschaulichung
		
		A <= "1111";
		B <= "1111";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 2: Kleinster Zustand
		DESIRED_CONDITION <= '0';
		
		A <= "0000";
		B <= "0000";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 3: Zustand dazwischen 1
		DESIRED_CONDITION <= '0';
		
		A <= "0001";
		B <= "0000";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 4: Zustand dazwischen 2
		DESIRED_CONDITION <= '1';
		
		A <= "1001";
		B <= "0110";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 5: Zustand dazwischen 3
		DESIRED_CONDITION <= '1';
		
		A <= "1101";
		B <= "1110";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 6: Zustand dazwischen 4
		DESIRED_CONDITION <= '1';
		
		A <= "1110";
		B <= "0111";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 7: Zustand dazwischen 5
		DESIRED_CONDITION <= '0';
		
		A <= "0101";
		B <= "1100";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;

		-- Testfall 8: Zustand dazwischen 6
		DESIRED_CONDITION <= '0';
		
		A <= "0001";
		B <= "0100";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
-------------------------------------------------------------------------------------------------------------------------------
		
		-- Ab hier schaltet der MUX ausschließlich 0 durch, heißt alles wo die summen_parity 0 ist, ist Y = 1
		E <= '0';
		
		-- Testfall 9: Hoechster Zustand
		DESIRED_CONDITION <= '1';
		
		A <= "1111";
		B <= "1111";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 10: Kleinster Zustand
		DESIRED_CONDITION <= '1';
		
		A <= "0000";
		B <= "0000";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 11: Zustand dazwischen 1
		DESIRED_CONDITION <= '0';
		
		A <= "0001";
		B <= "0000";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 12: Zustand dazwischen 2
		DESIRED_CONDITION <= '1';
		
		A <= "1001";
		B <= "0110";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 13: Zustand dazwischen 3
		DESIRED_CONDITION <= '1';
		
		A <= "1101";
		B <= "1110";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 14: Zustand dazwischen 4
		DESIRED_CONDITION <= '0';
		
		A <= "1110";
		B <= "0111";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		  
		-- Testfall 15: Zustand dazwischen 5
		DESIRED_CONDITION <= '1';
		
		A <= "0101";
		B <= "1100";
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;

		-- Testfall 16: Zustand dazwischen 6
		DESIRED_CONDITION <= '1';
		
		A <= "0001";
		B <= "0100";
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_desired_cond <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Hier koennen weitere Testfaelle hinzugefuegt werden
		
		WAIT; -- Endlosschleife
	END PROCESS;
    
END ARCHITECTURE;
