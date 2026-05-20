LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY mydiff is
	PORT(d, clock, reset : IN std_logic;
		  q : OUT std_logic);
	END mydiff;
	
	ARCHITECTURE behave OF mydiff IS
	BEGIN
		PROCESS(clock, reset)
		BEGIN 
			IF(reset ='1') THEN
				q <= '0';
			ELSIF (clock'event and clock='1') THEN
				q <= d;
			END IF;
		END PROCESS;
	END behave;