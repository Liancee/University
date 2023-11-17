LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dt_dlatch IS
    PORT (
        D, E, CLK : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF dt_dlatch IS
    SIGNAL tmp : STD_LOGIC;
BEGIN
    PROCESS (D, E, CLK)
    BEGIN
        IF (CLK = '1' AND E = '1') THEN
            tmp <= D;
        END IF;
    END PROCESS;
    
    Q <= tmp;
END ARCHITECTURE;
    