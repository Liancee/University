LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dt_dflipflop IS
    PORT (
        D, CLK : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF dt_dflipflop IS
    SIGNAL internal_Q : STD_LOGIC := '0';
BEGIN
    PROCESS (D, CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '1') THEN
            internal_Q <= D;
        END IF;
    END PROCESS;
    Q <= internal_Q;
END ARCHITECTURE;