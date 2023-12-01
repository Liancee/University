LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dt_dlatch IS
    PORT (
        D, E : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF dt_dlatch IS
    SIGNAL internal_Q : STD_LOGIC := '0';
BEGIN
    PROCESS (D, E)
    BEGIN
        IF (E = '1') THEN
            internal_Q <= D;
        END IF;
    END PROCESS;
    Q <= internal_Q;
END ARCHITECTURE;
    