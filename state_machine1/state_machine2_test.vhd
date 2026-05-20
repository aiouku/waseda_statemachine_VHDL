LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY state_machine2_test IS
END state_machine2_test;

ARCHITECTURE state_machine2_test_bench OF state_machine2_test IS

	COMPONENT state_machine2 IS
		PORT(x, clock,reset: IN std_logic;
			y0,y1:OUT std_logic);
	END COMPONENT;
	
	SIGNAL clock,reset,x,y0,y1:std_logic;
	
BEGIN
	sm1: state_machine2 PORT MAP(x=>x, clock=>clock,reset=>reset,y0=>y0,y1=>y1);
	
	PROCESS
	BEGIN
		clock <= '0';
		WAIT FOR 50ns;
		
		clock <= '1';
		WAIT FOR 50ns;
	END PROCESS;
	
	PROCESS
	BEGIN
		x<='1';
		reset<='1';
		WAIT FOR 25ns;
		
		reset<='0';
		WAIT FOR 50ns;
		
		x<='0';
		WAIT FOR 100ns;
		
		x<='1';
		WAIT FOR 200ns;
		
		x<='0';
		WAIT FOR 200ns;
		
		WAIT;
	END PROCESS;
END state_machine2_test_bench;

CONFIGURATION state_machine2_test_conf OF state_machine2_test IS
	FOR state_machine2_test_bench
	END FOR;
END state_machine2_test_conf;