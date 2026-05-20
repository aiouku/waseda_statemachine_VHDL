LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY myand2_test IS 
END myand2_test;

ARCHITECTURE myand2_test_bench OF myand2_test IS

	COMPONENT myand2
		PORT(a, b : IN std_logic;
				  c : OUT std_logic);
		END COMPONENT;
		
		SIGNAL i0, i1, o : std_logic;
	BEGIN
		a1: myand2 PORT MAP(a => i0, b=> i1, c=> o);
		
		PROCESS
		BEGIN
			i0 <= '0';
			i1 <= '0';
			WAIT FOR 10 ns; -- o = '0'がきたいされる
			
			i0 <= '1';
			i1 <= '0';
			WAIT FOR 10 ns; -- o = '0'がきたいされる
			
			i0 <= '0';
			i1 <= '1';
			WAIT FOR 10 ns; -- o = '0'がきたいされる
			
			i0 <= '1';
			i1 <= '1';
			WAIT FOR 10 ns; -- o = '1'がきたいされる
			
			WAIT;
		END PROCESS;
	END myand2_test_bench;
	
	CONFIGURATION myand2_test_conf OF myand2_test IS
	 FOR myand2_test_bench
	 END for;
	END myand2_test_conf;