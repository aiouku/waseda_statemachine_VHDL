LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.ALL;

ENTITY state_machine_struct IS
    PORT(x       : IN  std_logic_vector(1 DOWNTO 0);
         clock   : IN  std_logic;
         reset   : IN  std_logic;
         y       : OUT std_logic_vector(1 DOWNTO 0));
END state_machine_struct;

ARCHITECTURE structure OF state_machine_struct IS

    COMPONENT myand2
        PORT(a, b : IN  std_logic;
             c    : OUT std_logic);
    END COMPONENT;

    COMPONENT myor2
        PORT(a, b : IN  std_logic;
             c    : OUT std_logic);
    END COMPONENT;

    COMPONENT mynot
        PORT(a : IN  std_logic;
             b : OUT std_logic);
    END COMPONENT;

    COMPONENT mydiff
        PORT(d, clock, reset : IN  std_logic;
             q               : OUT std_logic);
    END COMPONENT;

    -- 状態 q1 q0 (フリップフロップ出力)
    SIGNAL q0, q1         : std_logic;
    -- 反転信号
    SIGNAL nq0, nq1       : std_logic;
    SIGNAL nx0, nx1       : std_logic;
    -- 次状態と出力
    SIGNAL d1_in, d0_in   : std_logic;
    SIGNAL y1_out, y0_out : std_logic;

    -- D1 中間信号
    SIGNAL d1_t1, d1_t2, d1_t3a, d1_t3 : std_logic;
    SIGNAL d1_or1 : std_logic;

    -- D0 中間信号
    SIGNAL d0_a1, d0_a2, d0_t1     : std_logic;
    SIGNAL d0_b1, d0_b2, d0_t2     : std_logic;
    SIGNAL d0_c_or, d0_c1, d0_t3   : std_logic;
    SIGNAL d0_or1                  : std_logic;

    -- y1 中間信号
    SIGNAL y1_a1, y1_t1            : std_logic;
    SIGNAL y1_b1, y1_b2, y1_t2     : std_logic;
    SIGNAL y1_c1, y1_t3            : std_logic;
    SIGNAL y1_or1                  : std_logic;

    -- y0 中間信号
    SIGNAL y0_a1, y0_t1            : std_logic;
    SIGNAL y0_t2                   : std_logic;
    SIGNAL y0_c_or, y0_c1, y0_t3   : std_logic;
    SIGNAL y0_or1                  : std_logic;

BEGIN
    -- フリップフロップ (状態保持)
    dff0: mydiff PORT MAP(d=>d0_in, clock=>clock, reset=>reset, q=>q0);
    dff1: mydiff PORT MAP(d=>d1_in, clock=>clock, reset=>reset, q=>q1);

    -- 反転信号生成
    n_q0: mynot PORT MAP(a=>q0,   b=>nq0);
    n_q1: mynot PORT MAP(a=>q1,   b=>nq1);
    n_x0: mynot PORT MAP(a=>x(0), b=>nx0);
    n_x1: mynot PORT MAP(a=>x(1), b=>nx1);

    ------------------------------------------------------------
    -- D1 = (nq1 AND q0) OR (q1 AND nq0) OR (q1 AND q0 AND nx1)
    ------------------------------------------------------------
    d1_and1:  myand2 PORT MAP(a=>nq1,    b=>q0,    c=>d1_t1);
    d1_and2:  myand2 PORT MAP(a=>q1,     b=>nq0,   c=>d1_t2);
    d1_and3a: myand2 PORT MAP(a=>q1,     b=>q0,    c=>d1_t3a);
    d1_and3:  myand2 PORT MAP(a=>d1_t3a, b=>nx1,   c=>d1_t3);
    d1_or_a:  myor2  PORT MAP(a=>d1_t1,  b=>d1_t2, c=>d1_or1);
    d1_or_b:  myor2  PORT MAP(a=>d1_or1, b=>d1_t3, c=>d1_in);

    ------------------------------------------------------------
    -- D0 = (nq1 AND nq0 AND x1 AND nx0)
    --    OR (q1 AND nq0 AND nx1 AND x0)
    --    OR (q1 AND q0 AND (nx1 OR nx0))
    ------------------------------------------------------------
    -- 第1項: nq1 AND nq0 AND x1 AND nx0
    d0_a_1: myand2 PORT MAP(a=>nq1,   b=>nq0,   c=>d0_a1);
    d0_a_2: myand2 PORT MAP(a=>x(1),  b=>nx0,   c=>d0_a2);
    d0_a_3: myand2 PORT MAP(a=>d0_a1, b=>d0_a2, c=>d0_t1);

    -- 第2項: q1 AND nq0 AND nx1 AND x0
    d0_b_1: myand2 PORT MAP(a=>q1,    b=>nq0,   c=>d0_b1);
    d0_b_2: myand2 PORT MAP(a=>nx1,   b=>x(0),  c=>d0_b2);
    d0_b_3: myand2 PORT MAP(a=>d0_b1, b=>d0_b2, c=>d0_t2);

    -- 第3項: q1 AND q0 AND (nx1 OR nx0)
    d0_c_or1: myor2  PORT MAP(a=>nx1,   b=>nx0,    c=>d0_c_or);
    d0_c_a1:  myand2 PORT MAP(a=>q1,    b=>q0,     c=>d0_c1);
    d0_c_a2:  myand2 PORT MAP(a=>d0_c1, b=>d0_c_or, c=>d0_t3);

    -- 3項のOR
    d0_or_a: myor2 PORT MAP(a=>d0_t1,  b=>d0_t2, c=>d0_or1);
    d0_or_b: myor2 PORT MAP(a=>d0_or1, b=>d0_t3, c=>d0_in);

    ------------------------------------------------------------
    -- y1 = (nq1 AND nq0 AND nx0)
    --    OR (q1 AND nq0 AND nx1 AND x0)
    --    OR (q1 AND q0 AND x1)
    ------------------------------------------------------------
    -- 第1項: nq1 AND nq0 AND nx0
    y1_a_1: myand2 PORT MAP(a=>nq1,   b=>nq0,  c=>y1_a1);
    y1_a_2: myand2 PORT MAP(a=>y1_a1, b=>nx0,  c=>y1_t1);

    -- 第2項: q1 AND nq0 AND nx1 AND x0
    y1_b_1: myand2 PORT MAP(a=>q1,    b=>nq0,   c=>y1_b1);
    y1_b_2: myand2 PORT MAP(a=>nx1,   b=>x(0),  c=>y1_b2);
    y1_b_3: myand2 PORT MAP(a=>y1_b1, b=>y1_b2, c=>y1_t2);

    -- 第3項: q1 AND q0 AND x1
    y1_c_1: myand2 PORT MAP(a=>q1,    b=>q0,   c=>y1_c1);
    y1_c_2: myand2 PORT MAP(a=>y1_c1, b=>x(1), c=>y1_t3);

    -- 3項のOR
    y1_or_a: myor2 PORT MAP(a=>y1_t1,  b=>y1_t2, c=>y1_or1);
    y1_or_b: myor2 PORT MAP(a=>y1_or1, b=>y1_t3, c=>y1_out);

    ------------------------------------------------------------
    -- y0 = (nq1 AND nq0 AND x0)
    --    OR (nq1 AND q0)
    --    OR (q1 AND q0 AND (nx1 OR nx0))
    ------------------------------------------------------------
    -- 第1項: nq1 AND nq0 AND x0
    y0_a_1: myand2 PORT MAP(a=>nq1,   b=>nq0,  c=>y0_a1);
    y0_a_2: myand2 PORT MAP(a=>y0_a1, b=>x(0), c=>y0_t1);

    -- 第2項: nq1 AND q0
    y0_b_1: myand2 PORT MAP(a=>nq1, b=>q0, c=>y0_t2);

    -- 第3項: q1 AND q0 AND (nx1 OR nx0)
    y0_c_or1: myor2  PORT MAP(a=>nx1,   b=>nx0,    c=>y0_c_or);
    y0_c_a1:  myand2 PORT MAP(a=>q1,    b=>q0,     c=>y0_c1);
    y0_c_a2:  myand2 PORT MAP(a=>y0_c1, b=>y0_c_or, c=>y0_t3);

    -- 3項のOR
    y0_or_a: myor2 PORT MAP(a=>y0_t1,  b=>y0_t2, c=>y0_or1);
    y0_or_b: myor2 PORT MAP(a=>y0_or1, b=>y0_t3, c=>y0_out);

    -- 出力
    y(0) <= y0_out;
    y(1) <= y1_out;
END structure;