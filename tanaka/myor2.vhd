LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY myor2 is
	PORT(a, b : IN std_logic;
			  c : OUT std_logic);
	END myor2;
	
	ARCHITECTURE behave OF myor2 IS
	BEGIN
		PROCESS(a, b)
		BEGIN 
			IF(a ='1' OR b = '1') THEN
				c <= '1';
			ELSIF (a = '0' AND b = '0') THEN
				c <= '0';
			ELSE
				c <= 'X';
			END IF;
		END PROCESS;
	END behave;