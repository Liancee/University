LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY testbench_aufgabe2 IS
END ENTITY;

ARCHITECTURE Testbench OF testbench_aufgabe2 IS
    
    SIGNAL CLK : STD_LOGIC := '0';
    
    -- signals dt_dlatch
    SIGNAL D : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL Q : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    SIGNAL Q_Desired : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Y : STD_LOGIC;
    
BEGIN
    DUT: ENTITY WORK.aufgabe2
        PORT MAP (
            D => D,
            E => CLK,
            Q => Q
        );
        
    CLK <= NOT CLK AFTER 10 NS;
      
    PROCESS
    BEGIN
        
        D <= "1111" AFTER 5 NS, "1100" AFTER 25 NS, "0011" AFTER 35 NS;
        Q_Desired <= "0000", "1111" AFTER 10 NS, "1100" AFTER 30 NS, "0011" AFTER 35 NS;
        
        
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