library ieee;
use ieee.std_logic_1164.all;

entity testbench_labor4_task3 is
end entity;

architecture Testbench of testbench_labor4_task3 is
    
    signal X, Clk, Reset : std_logic := '0';
	 signal Y_Actual : std_logic;
	 signal a, b, c : std_logic;
	 signal Y, Y_Desired : std_logic := '0';
    
begin

	DUT0: entity work.labor4_task3
		port map(
			X => X,
			Clk => Clk,
			Reset => Reset,
			Y => Y_Actual--,
			--output_a => a,
			--output_b => b,
			--output_c => c
		);
	
	Clk <= not Clk after 10 NS;
	
	process
	begin
        
		X <= '1' after 5 NS, '0' after 20 NS, '1' after 40 NS, '0' after 95 ns, -- tests before reset
		'1' after 140 NS, '0' after 155 NS, '1' after 175 NS, '0' after 220 ns; -- tests after reset
		Reset <= '1' after 140 NS;
      
		Y_Desired <= '1' after 60 ns, '0' after 80 ns, '1' after 100 ns, '0' after 140 ns;
        
		wait;
        
	end process;
    
    process (Y_Actual, Y_Desired)
    begin
        Y <= Y_Actual xnor Y_Desired;
    end process;
    
end architecture;