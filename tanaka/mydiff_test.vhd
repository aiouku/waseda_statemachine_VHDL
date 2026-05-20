LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY mydiff_test IS 
END mydiff_test;

ARCHITECTURE mydiff_test_bench OF mydiff_test IS

	COMPONENT mydiff
		PORT(d, clock, reset : IN std_logic;
			  q : OUT std_logic);
		END COMPONENT;
		
		SIGNAL d, clock, reset, q : std_logic;
	BEGIN
		a1: mydiff PORT MAP(d => d, clock=> clock, reset => reset, q=>q);
		
		PROCESS
		BEGIN
			clock <= '0';
			WAIT FOR 50 ns; -- o = '1'がきたいされる
			
			clock <= '1';
			WAIT FOR 50 ns; -- o = '0'がきたいされる
		END PROCESS;
		
		process
			begin
				d<='1';
				reset<='1';
				wait for 25ns;
				
				reset<='0';
				wait for 50ns;
				
				d<='0';
				wait for 100ns;
				
				d<='1';
				wait for 100ns;
				wait;
			end process;
	END mydiff_test_bench;
	
	CONFIGURATION mydiff_test_conf OF mydiff_test IS
	 FOR mydiff_test_bench
	 END for;
	END mydiff_test_conf;