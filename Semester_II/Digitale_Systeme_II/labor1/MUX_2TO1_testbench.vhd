LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Testbench_MUX_2TO1 IS
END ENTITY;

ARCHITECTURE Testbench OF Testbench_MUX_2TO1 IS


	-- Signale fuer die Eingabe- und Ausgabewerte
	SIGNAL A, B, S, E  : BIT;
	SIGNAL Y : BIT;
	
	-- Signals Testbench
	SIGNAL Y_XNOR_DESIRED_CONDITION : BIT;
	SIGNAL DESIRED_CONDITION : BIT;

BEGIN
	DUT: ENTITY WORK.MUX_2TO1
		PORT MAP(
			A => A, 
			B => B, 
			S => S, 
			E => E,
			Y => Y
		);

	-- Testprozess
	PROCESS
	BEGIN
	
		-- only enabled outputs are interesting cuz otherwise nothing will be send through
		E <= '1';
		
		-- Testfall 1: Hoechster Zustand
		DESIRED_CONDITION <= '1';
		
		A <= '1';
		B <= '1';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 2: Kleinster Zustand
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '0';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 3: Zustand dazwischen 1
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '0';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 4: Zustand dazwischen 2
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '1';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 5: Zustand dazwischen 3
		DESIRED_CONDITION <= '1';
		
		A <= '0';
		B <= '1';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 6: Zustand dazwischen 4
		DESIRED_CONDITION <= '1';
		
		A <= '1';
		B <= '0';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 7: Zustand dazwischen 5
		DESIRED_CONDITION <= '0';
		
		A <= '1';
		B <= '0';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;

		-- Testfall 8: Zustand dazwischen 6
		DESIRED_CONDITION <= '1';
		
		A <= '1';
		B <= '1';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
-------------------------------------------------------------------------------------------------------------------------------
		
		E <= '0';
		
		-- Testfall 1: Hoechster Zustand
		DESIRED_CONDITION <= '0';
		
		A <= '1';
		B <= '1';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 2: Kleinster Zustand
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '0';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 3: Zustand dazwischen 1
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '0';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 4: Zustand dazwischen 2
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '1';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 5: Zustand dazwischen 3
		DESIRED_CONDITION <= '0';
		
		A <= '0';
		B <= '1';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Testfall 6: Zustand dazwischen 4
		DESIRED_CONDITION <= '0';
		
		A <= '1';
		B <= '0';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
        
		-- Testfall 7: Zustand dazwischen 5
		DESIRED_CONDITION <= '0';
		
		A <= '1';
		B <= '0';
		S <= '1';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;

		-- Testfall 8: Zustand dazwischen 6
		DESIRED_CONDITION <= '0';
		
		A <= '1';
		B <= '1';
		S <= '0';
		WAIT FOR 0.1 ns;
		Y_XNOR_DESIRED_CONDITION <= Y XNOR DESIRED_CONDITION;
		WAIT FOR 10 ns;
		
		-- Hier koennen weitere Testfaelle hinzugefuegt werden
        
		WAIT; -- Endlosschleife
	END PROCESS;
    
END ARCHITECTURE;
