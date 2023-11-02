LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder IS
	PORT(
		a, b, cIn : IN STD_LOGIC;
		sum, cOut : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE Behavioral OF FullAdder IS
BEGIN
	PROCESS(a, b, cIn)
		BEGIN
			sum <= (a XOR b XOR cIn);
			cOut <= (a AND b) OR (a AND cIn) OR (b AND cIn);
	END PROCESS;
END ARCHITECTURE;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY WORK;
USE WORK.ALL;

ENTITY Adder4BitParity IS
	PORT(
		A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SUM : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		EVEN_PARITY, ODD_PARITY : OUT BIT
	);
END ENTITY;

ARCHITECTURE Structure OF Adder4BitParity IS
	COMPONENT FullAdder 
		PORT(
			a, b, cIn : IN STD_LOGIC;
			sum, cOut : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT EvenParityGenerator IS
	PORT(       
		sum_input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		even_parity : OUT BIT
		);
	END COMPONENT;

	SIGNAL carry_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL carry_in :  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sum_in : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL even_p : BIT;
	
BEGIN
	carry_in <= ((carry_sig(2 downto 0)) &'0');
 
	ADDERS:
	FOR i IN 0 TO 3 GENERATE
		BEGIN
		ADDER:
			FullAdder PORT MAP(
            a => A(i), 
            b => B(i),
            cIn => carry_in(i),
				sum => sum_in(i),
				cOut => carry_sig(i)            
			);
	END GENERATE;
	
	sum_in(4) <= carry_sig(3); -- Last carry_out is put in the sums first position
	
	PG:
		EvenParityGenerator PORT MAP(
			sum_input => sum_in,
			even_parity => even_p
		);

	-- setting our outputs
	EVEN_PARITY <= even_p;
	ODD_PARITY <= NOT even_p;
	SUM <= sum_in;
    
END ARCHITECTURE;


