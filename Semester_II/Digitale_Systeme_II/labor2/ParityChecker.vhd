LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY WORK;
USE WORK.ALL;

ENTITY ParityChecker IS
	PORT(
		A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		PARITY_IN : IN BIT;
		Y : OUT BIT
		
	);
END ENTITY;

ARCHITECTURE Mixed OF ParityChecker IS
	COMPONENT EvenParityGenerator IS
		PORT(       
			sum_input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			even_parity : OUT BIT
		);
	END COMPONENT;
	
	SIGNAL even_p: BIT;
	
BEGIN
	PG:
		EvenParityGenerator PORT MAP(
			sum_input => A,
			even_parity => even_p
		);
		
	PROCESS (even_p, PARITY_IN)
		BEGIN
			Y <= PARITY_IN XNOR even_p;
	END PROCESS;
END ARCHITECTURE;