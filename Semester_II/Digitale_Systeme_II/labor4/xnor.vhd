LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shpXNOR IS
	PORT (
		A, B : IN STD_LOGIC;
		Y : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE Behavioral OF shpXNOR IS
	SIGNAL internal_Y : STD_LOGIC;
BEGIN
	PROCESS (A)
		VARIABLE internal_A : STD_LOGIC;
	BEGIN
		internal_Y <= 'X'; -- Y shall be 'X' for at least setup + hold time
		if A'STABLE(15 NS) THEN -- check if A was stable during setup time
			internal_A := A AFTER 5 NS; -- wait hold time
			IF A'STABLE(5 NS) THEN -- check if A was stable during hold time
				IF (A = '1' AND B = '1') OR (A = '0' AND B = '0') THEN
					internal_Y <= '1' AFTER 20 NS; -- pdelay = 25 - 5, cuz we waited 5 ns for hold time 
				ELSE internal_Y <= '0' AFTER 20 NS;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS (B)
		VARIABLE internal_B : STD_LOGIC;
	BEGIN
		internal_Y <= 'X';
		if B'STABLE(15 NS) THEN
			internal_B := B AFTER 5 NS; -- wait hold time
			IF B'STABLE(5 NS) THEN
				IF (A = '1' AND B = '1') OR (A = '0' AND B = '0') THEN
					internal_Y <= '1' AFTER 25 NS;
				ELSE internal_Y <= '0' AFTER 25 NS;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	Y <= internal_Y;
END ARCHITECTURE;