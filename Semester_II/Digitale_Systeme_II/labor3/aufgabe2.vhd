LIBRARY IEEE;
LIBRARY WORK;

USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.ALL;

ENTITY aufgabe2 IS
    PORT (
        E : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Structural OF aufgabe2 IS
    
    COMPONENT dt_dlatch
        PORT (
            D, E : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    dlatch1:
        dt_dlatch PORT MAP (
            D => D(3),
            E => E,
            Q => Q(3)
        );
        
    dlatch2:
        dt_dlatch PORT MAP (
            D => D(2),
            E => E,
            Q => Q(2)
        );
     
    dlatch3:
        dt_dlatch PORT MAP (
            D => D(1),
            E => E,
            Q => Q(1)
        );
        
    dlatch4:
        dt_dlatch PORT MAP (
            D => D(0),
            E => E,
            Q => Q(0)
        );
END ARCHITECTURE;