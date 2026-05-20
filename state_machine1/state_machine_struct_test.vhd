LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY state_machine_struct_test IS
END state_machine_struct_test;

ARCHITECTURE state_machine_struct_test_bench OF state_machine_struct_test IS

    COMPONENT state_machine_struct IS
        PORT(x     : IN  std_logic_vector(1 DOWNTO 0);
             clock : IN  std_logic;
             reset : IN  std_logic;
             y     : OUT std_logic_vector(1 DOWNTO 0));
    END COMPONENT;

    SIGNAL clock, reset : std_logic;
    SIGNAL x, y         : std_logic_vector(1 DOWNTO 0);

BEGIN
    sm: state_machine_struct PORT MAP(x=>x, clock=>clock, reset=>reset, y=>y);

    PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR 50 ns;
        clock <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    PROCESS
    BEGIN
        -- リセット (st1へ)
        x <= "00";
        reset <= '1';
        WAIT FOR 75 ns;
        reset <= '0';

        -- st1での自己ループ確認
        x <= "00";  WAIT FOR 100 ns;  -- st1→st1 (y=10)
        x <= "01";  WAIT FOR 100 ns;  -- st1→st1 (y=01)
        x <= "11";  WAIT FOR 100 ns;  -- st1→st1 (y=01)

        -- st1→st2 へ遷移
        x <= "10";  WAIT FOR 100 ns;  -- st1→st2 (y=10)

        -- st2→st3 (無条件)
        x <= "00";  WAIT FOR 100 ns;  -- st2→st3 (y=01)

        -- st3での自己ループ確認
        x <= "00";  WAIT FOR 100 ns;  -- st3→st3 (y=00)
        x <= "10";  WAIT FOR 100 ns;  -- st3→st3 (y=00)
        x <= "11";  WAIT FOR 100 ns;  -- st3→st3 (y=00)

        -- st3→st4
        x <= "01";  WAIT FOR 100 ns;  -- st3→st4 (y=10)

        -- st4での自己ループ確認
        x <= "00";  WAIT FOR 100 ns;  -- st4→st4 (y=01)
        x <= "01";  WAIT FOR 100 ns;  -- st4→st4 (y=01)

        -- st4→st2 (再びst2を経由)
        x <= "10";  WAIT FOR 100 ns;  -- st4→st2 (y=11)

        -- st2→st3
        x <= "11";  WAIT FOR 100 ns;  -- st2→st3 (y=01)

        -- st3→st4
        x <= "01";  WAIT FOR 100 ns;  -- st3→st4 (y=10)

        -- st4→st1 で一巡完了
        x <= "11";  WAIT FOR 100 ns;  -- st4→st1 (y=10)

        -- 終端
        x <= "00";  WAIT FOR 100 ns;  -- st1→st1 (y=10)

        WAIT;
    END PROCESS;
END state_machine_struct_test_bench;

CONFIGURATION state_machine_struct_test_conf OF state_machine_struct_test IS
    FOR state_machine_struct_test_bench
    END FOR;
END state_machine_struct_test_conf;