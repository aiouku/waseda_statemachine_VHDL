LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY mynot is
	PORT(a : IN std_logic;
		  b : OUT std_logic);
	END mynot;
	
	ARCHITECTURE behave OF mynot IS
	BEGIN
		PROCESS(a)
		BEGIN 
			IF(a ='1') THEN
				b <= '0';
			ELSIF (a = '0') THEN
				b <= '1';
			ELSE
				b <= 'X';
			END IF;
		END PROCESS;
	END behave;