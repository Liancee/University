ENTITY MUX_2TO1 IS 
	PORT(
		A, B : IN BIT;
		S, E : IN BIT;
		Y : OUT BIT
    );
END ENTITY;

ARCHITECTURE Behavioral OF MUX_2TO1 IS
BEGIN
	PROCESS (E, S)
	BEGIN
		IF E = '1' THEN
			IF S = '0' THEN
				Y <= A;
			ELSE
				Y <= B;
			END IF;
		ELSE
			Y <= '0';
		END IF;
    END PROCESS;
END ARCHITECTURE;