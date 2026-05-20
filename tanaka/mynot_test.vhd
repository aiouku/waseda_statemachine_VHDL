LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY mynot_test IS 
END mynot_test;

ARCHITECTURE mynot_test_bench OF mynot_test IS

	COMPONENT mynot
		PORT(a : IN std_logic;
			  b : OUT std_logic);
		END COMPONENT;
		
		SIGNAL i, o : std_logic;
	BEGIN
		a1: mynot PORT MAP(a => i, b=> o);
		
		PROCESS
		BEGIN
			i <= '0';
			WAIT FOR 10 ns; -- o = '1'がきたいされる
			
			i <= '1';
			WAIT FOR 10 ns; -- o = '0'がきたいされる
			
			WAIT;
		END PROCESS;
	END mynot_test_bench;
	
	CONFIGURATION mynot_test_conf OF mynot_test IS
	 FOR mynot_test_bench
	 END for;
	END mynot_test_conf;