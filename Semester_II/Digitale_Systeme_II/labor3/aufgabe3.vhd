LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aufgabe3 IS
    PORT (
        D : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Structural OF aufgabe3 IS

    COMPONENT dt_dflipflop PORT (
        D, CLK : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
    END COMPONENT;
    
    SIGNAL QS : STD_LOGIC_VECTOR (3 DOWNTO 0);
    
BEGIN
        dflipflop1: dt_dflipflop PORT MAP (
            D => D,
            CLK => CLK,
            Q => QS(3)
        );
            
        dflipflop2: dt_dflipflop PORT MAP (
            D => QS(3),
            CLK => CLK,
            Q => QS(2)
        );
         
        dflipflop3: dt_dflipflop PORT MAP (
            D => QS(2),
            CLK => CLK,
            Q => QS(1)
        );
            
        dflipflop4: dt_dflipflop PORT MAP (
            D => QS(1),
            CLK => CLK,
            Q => QS(0)
        );
        
    Q <= QS;
END ARCHITECTURE;
    
    