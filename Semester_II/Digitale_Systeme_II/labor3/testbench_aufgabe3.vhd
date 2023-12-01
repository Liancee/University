LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY testbench_aufgabe3 IS
END ENTITY;

ARCHITECTURE Testbench OF testbench_aufgabe3 IS
    
    SIGNAL CLK : STD_LOGIC := '0';
    
    -- signals dt_dflipflop
    SIGNAL D : STD_LOGIC := '1';
    SIGNAL Q : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    SIGNAL Q_Desired : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Y : STD_LOGIC;
    
BEGIN
    DUT: ENTITY WORK.aufgabe3
        PORT MAP (
            D => D,
            CLK => CLK,
            Q => Q
        );
        
    CLK <= NOT CLK AFTER 5 NS;
      
    PROCESS
    BEGIN
        
        D <= '0' AFTER 10 NS,
        '1' AFTER 25 NS,
        '0' AFTER 35 NS,
        '0' AFTER 40 NS, -- schickt triple 0
        '1' AFTER 70 NS, -- schickt triple 1
        '0' AFTER 100 NS,
        '1' AFTER 115 NS;
        
        Q_Desired <= "0000",
        "1000" AFTER 5 NS,
        "0100" AFTER 15 NS,
        "1010" AFTER 25 NS,
        "0101" AFTER 35 NS,
        "0010" AFTER 45 NS,
        "0001" AFTER 55 NS,
        "0000" AFTER 65 NS,
        "1000" AFTER 75 NS,
        "1100" AFTER 85 NS,
        "1110" AFTER 95 NS,
        "0111" AFTER 105 NS,
        "1011" AFTER 115 NS;
        
        
        WAIT;
        
    END PROCESS;
    
    PROCESS (Q, Q_Desired)
    BEGIN
        Y <= (Q(0) XNOR Q_Desired(0)) AND
             (Q(1) XNOR Q_Desired(1)) AND
             (Q(2) XNOR Q_Desired(2)) AND
             (Q(3) XNOR Q_Desired(3));
    END PROCESS;
    
END ARCHITECTURE;