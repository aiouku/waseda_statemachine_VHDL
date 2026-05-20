LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY state_machine_behave IS
    PORT(x        : IN  std_logic_vector(1 DOWNTO 0);
         clock    : IN  std_logic;
         reset    : IN  std_logic;
         y        : OUT std_logic_vector(1 DOWNTO 0));
END state_machine_behave;

ARCHITECTURE behave OF state_machine_behave IS
    TYPE states IS (st1, st2, st3, st4);
    SIGNAL present_state : states;
    SIGNAL next_state    : states;
BEGIN
    clkd: PROCESS(clock, reset)
    BEGIN
        IF (reset = '1') THEN
            present_state <= st1;
        ELSIF (clock'EVENT AND clock = '1') THEN
            present_state <= next_state;
        END IF;
    END PROCESS clkd;

    state_trans: PROCESS(present_state, x)
    BEGIN
        CASE present_state IS

            WHEN st1 =>
                CASE x IS
                    WHEN "00" => y <= "10"; next_state <= st1;
                    WHEN "01" => y <= "01"; next_state <= st1;
                    WHEN "10" => y <= "10"; next_state <= st2;
                    WHEN "11" => y <= "01"; next_state <= st1;
                    WHEN OTHERS => y <= "00"; next_state <= st1;
                END CASE;

            WHEN st2 =>
                y <= "01";
                next_state <= st3;

            WHEN st3 =>
                CASE x IS
                    WHEN "00" => y <= "00"; next_state <= st3;
                    WHEN "01" => y <= "10"; next_state <= st4;
                    WHEN "10" => y <= "00"; next_state <= st3;
                    WHEN "11" => y <= "00"; next_state <= st3;
                    WHEN OTHERS => y <= "00"; next_state <= st3;
                END CASE;

            WHEN st4 =>
                CASE x IS
                    WHEN "00" => y <= "01"; next_state <= st4;
                    WHEN "01" => y <= "01"; next_state <= st4;
                    WHEN "10" => y <= "11"; next_state <= st2;
                    WHEN "11" => y <= "10"; next_state <= st1;
                    WHEN OTHERS => y <= "00"; next_state <= st1;
                END CASE;

        END CASE;
    END PROCESS state_trans;
END behave;