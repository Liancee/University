LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dt_dflipflop IS
    PORT (
        D, CLK : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF dt_dflipflop IS
    SIGNAL tmp : STD_LOGIC;
BEGIN
    PROCESS (D, CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            tmp <= D;
        END IF;
    END PROCESS;
    
    Q <= tmp;
END ARCHITECTURE;