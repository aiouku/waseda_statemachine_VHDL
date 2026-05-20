LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY state_machine2 IS
	PORT(x, clock, reset : IN std_logic;
						y0, y1 : OUT std_logic);
END state_machine2;

ARCHITECTURE behave OF state_machine2 IS
	
	TYPE states IS (st1,st2,st3,st4);
	SIGNAL present_state:states;
	SIGNAL next_state:states;
BEGIN
	clkd: PROCESS(clock,reset)
	BEGIN
		IF (reset='1') THEN
			present_state<=st1;
		ELSIF(clock'EVENT and clock='1')THEN
			present_state<=next_state;
		END IF;
	END PROCESS clkd;
	
	state_trans: PROCESS(present_state, x)
	BEGIN
		CASE present_state IS
		
			WHEN st1=>
				y0<='0';
				y1<='0';
				IF (x='1') THEN
					next_state<=st2;
				ELSE
					next_state<=st1;
				END IF;

			WHEN st2=>
				y0<='1';
				y1<='0';
				next_state<=st3;
				
			WHEN st3=>
				y0<='1';
				y1<='1';
				next_state<=st4;
			
			WHEN st4=>
				y0<='0';
				y1<='1';
				IF (x='1') THEN
					next_state<=st4;
				ELSE
					next_state<=st1;
				END IF;
		
		END CASE;
	END PROCESS state_trans;
END behave;