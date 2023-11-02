LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EvenParityGenerator IS
	PORT(
		sum_input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		even_parity : OUT BIT
	);
END ENTITY;

ARCHITECTURE Behavioral OF EvenParityGenerator IS
BEGIN
	PROCESS (sum_input)
		VARIABLE count : INTEGER := 0;
	BEGIN
		-- counting for 1s to determine parity
		count := 0;
		FOR i IN 0 TO 4 LOOP
			IF sum_input(i) = '1' THEN
				count := count + 1;
			END IF;
		END LOOP;
		
		-- determining parities
		IF (count mod 2 = 0) THEN
			even_parity <= '0';
		ELSE
			even_parity <= '1';
		END IF;
	END PROCESS;
END ARCHITECTURE;