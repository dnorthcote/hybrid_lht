-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_333_Zhou\hdlsrc\parallel_lht\Parallel_LHT_Accumulator.vhd
-- Created: 2020-02-27 22:35:22
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Parallel_LHT_Accumulator
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Accumulator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Parallel_LHT_pkg.ALL;

ENTITY Parallel_LHT_Accumulator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_tdata                      :   IN    std_logic;  -- ufix1
        s_axis_tuser                      :   IN    std_logic;
        s_axis_tlast                      :   IN    std_logic;
        hough_param                       :   IN    vector_of_std_logic_vector9(0 TO 179);  -- ufix9 [180]
        m_axis_tvalid                     :   OUT   std_logic;
        m_axis_tdata                      :   OUT   std_logic_vector(8 DOWNTO 0);  -- ufix9
        m_axis_tuser                      :   OUT   std_logic;
        m_axis_tlast                      :   OUT   std_logic
        );
END Parallel_LHT_Accumulator;


ARCHITECTURE rtl OF Parallel_LHT_Accumulator IS

  -- Component Declarations
  COMPONENT Accumulator_Controller
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          sof                             :   IN    std_logic;
          eof                             :   IN    std_logic;
          ntheta                          :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          nrho                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          mode                            :   OUT   std_logic;
          read_rsvd                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          clear                           :   OUT   std_logic;
          index                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          valid                           :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Accumulator_with_Switches
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          hough_address                   :   IN    vector_of_std_logic_vector9(0 TO 179);  -- ufix9 [180]
          edge_rsvd                       :   IN    std_logic;
          mode                            :   IN    std_logic;
          read_address                    :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          clear                           :   IN    std_logic;
          theta_index                     :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          hps                             :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Accumulator_Controller
    USE ENTITY work.Accumulator_Controller(rtl);

  FOR ALL : Accumulator_with_Switches
    USE ENTITY work.Accumulator_with_Switches(rtl);

  -- Signals
  SIGNAL HDL_Counter_out1                 : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Compare_To_Constant3_out1        : std_logic;
  SIGNAL Constant1_out1                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Constant2_out1                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL mode                             : std_logic;
  SIGNAL read_rsvd                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL clear                            : std_logic;
  SIGNAL index                            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL valid                            : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Delay4_out1                      : std_logic;
  SIGNAL AND1_out1                        : std_logic;
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Delay4_out1_1                    : std_logic;
  SIGNAL Accumulator_with_Switches_out1   : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL Accumulator_with_Switches_out1_unsigned : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Constant_out1                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Multiport_Switch2_out1           : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL index_unsigned                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL read_unsigned                    : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL Compare_To_Constant2_out1        : std_logic;
  SIGNAL Delay3_out1                      : std_logic;

BEGIN
  u_Accumulator_Controller : Accumulator_Controller
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              sof => s_axis_tuser,
              eof => Compare_To_Constant3_out1,
              ntheta => std_logic_vector(Constant1_out1),  -- uint16
              nrho => std_logic_vector(Constant2_out1),  -- uint16
              mode => mode,
              read_rsvd => read_rsvd,  -- uint16
              clear => clear,
              index => index,  -- uint16
              valid => valid
              );

  u_Accumulator_with_Switches : Accumulator_with_Switches
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              hough_address => hough_param,  -- ufix9 [180]
              edge_rsvd => AND1_out1,
              mode => mode,
              read_address => read_rsvd,  -- uint16
              clear => clear,
              theta_index => index,  -- uint16
              hps => Accumulator_with_Switches_out1  -- ufix9
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 334
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#000#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF s_axis_tuser = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#000#, 9);
        ELSIF s_axis_tlast = '1' THEN 
          IF HDL_Counter_out1 >= to_unsigned(16#14E#, 9) THEN 
            HDL_Counter_out1 <= to_unsigned(16#000#, 9);
          ELSE 
            HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#001#, 9);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Constant3_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(16#14E#, 9) ELSE
      '0';

  Constant1_out1 <= to_unsigned(16#00B3#, 16);

  Constant2_out1 <= to_unsigned(16#01D9#, 16);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= valid;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= mode;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  AND1_out1 <= s_axis_tvalid AND s_axis_tdata;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= Delay4_out1;
        delayMatch_reg(1) <= delayMatch_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Delay4_out1_1 <= delayMatch_reg(1);

  Accumulator_with_Switches_out1_unsigned <= unsigned(Accumulator_with_Switches_out1);

  Constant_out1 <= to_unsigned(16#000#, 9);

  
  Multiport_Switch2_out1 <= Accumulator_with_Switches_out1_unsigned WHEN Delay4_out1_1 = '0' ELSE
      Constant_out1;

  m_axis_tdata <= std_logic_vector(Multiport_Switch2_out1);

  index_unsigned <= unsigned(index);

  
  Compare_To_Constant1_out1 <= '1' WHEN index_unsigned = to_unsigned(16#0000#, 16) ELSE
      '0';

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= Compare_To_Constant1_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  read_unsigned <= unsigned(read_rsvd);

  
  Compare_To_Constant_out1 <= '1' WHEN read_unsigned = to_unsigned(16#0000#, 16) ELSE
      '0';

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Compare_To_Constant_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  AND_out1 <= Delay_out1 AND Delay1_out1;

  
  Compare_To_Constant2_out1 <= '1' WHEN read_unsigned = to_unsigned(16#01D9#, 16) ELSE
      '0';

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Compare_To_Constant2_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  m_axis_tvalid <= Delay2_out1;

  m_axis_tuser <= AND_out1;

  m_axis_tlast <= Delay3_out1;

END rtl;

