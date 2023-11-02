LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY WORK;
USE WORK.ALL;

ENTITY labor_2 IS
	PORT(
		A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S, E : IN BIT;
		Y : OUT BIT;
		
		-- OUTS for Testbench
		SUM_T : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		ODD, EVEN, P_IN : OUT BIT
	);
END ENTITY;

ARCHITECTURE Structural OF labor_2 IS
	COMPONENT Adder4BitParity 
		PORT(
			A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			SUM : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			EVEN_PARITY, ODD_PARITY : OUT BIT
		);
	END COMPONENT;
	
	COMPONENT MUX_2TO1 
		PORT(
			A, B : IN BIT;
			S, E : IN BIT;
			Y : OUT BIT
		);
	END COMPONENT;
	
	COMPONENT ParityChecker 
		PORT(
			A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			PARITY_IN : IN BIT;
			Y : OUT BIT
		);
	END COMPONENT;
	
	SIGNAL sum : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL even_parity : BIT;
	SIGNAL odd_parity: BIT;
	SIGNAL parity_in : BIT;
	
BEGIN
	A4BP:
		Adder4BitParity PORT MAP(
			A => A,
			B => B,
			SUM => sum,
			EVEN_PARITY => even_parity,
			ODD_PARITY => odd_parity
		);
		
	MUX:
		MUX_2TO1 PORT MAP(
			A => odd_parity,
			B => even_parity,
			S => S,
			E => E,
			Y => parity_in
		);
		
	PC:
		ParityChecker PORT MAP(
			A => sum,
			PARITY_IN => parity_in,
			Y => Y
		);
		
	SUM_T <= sum;
	EVEN <= even_parity;
	ODD <= odd_parity;
	P_IN <= parity_in;
END ARCHITECTURE;