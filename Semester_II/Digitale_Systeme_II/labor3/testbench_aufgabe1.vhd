LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY testbench_aufgabe1 IS
END ENTITY;

ARCHITECTURE Testbench OF testbench_aufgabe1 IS
    
    SIGNAL CLK : STD_LOGIC := '0';
    
    -- signals dt_dlatch
    SIGNAL D : STD_LOGIC := '1';
    SIGNAL Q_l : STD_LOGIC;
    
    -- signals dt_dflipflop
    SIGNAL Q_ff : STD_LOGIC;
    
BEGIN
    DUT: ENTITY WORK.dt_dlatch
        PORT MAP (
            D,
            E => CLK,
            Q => Q_l
        );
    DUT2: ENTITY WORK.dt_dflipflop
        PORT MAP (
            D,
            CLK,
            Q => Q_ff
        );
        
    CLK <= NOT CLK AFTER 5 NS;
      
    PROCESS
    BEGIN
    
        D <= '0' AFTER 10 NS, '1' AFTER 20 NS, '0' AFTER 30 NS, '1' AFTER 50 NS;
        
        WAIT;
    
    END PROCESS;
END ARCHITECTURE;
