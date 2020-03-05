-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_768p\hdlsrc\hybrid_lht\Hybrid_LHT_Accumulator.vhd
-- Created: 2020-03-05 09:47:46
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Hybrid_LHT_Accumulator
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Accumulator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Hybrid_LHT_Accumulator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_tuser                      :   IN    std_logic;
        s_axis_tlast                      :   IN    std_logic;
        hough_param                       :   IN    vector_of_std_logic_vector11(0 TO 59);  -- ufix11 [60]
        edge_rsvd                         :   IN    std_logic;  -- ufix1
        shift                             :   IN    vector_of_std_logic_vector6(0 TO 59);  -- ufix6 [60]
        m_axis_tvalid                     :   OUT   std_logic;
        m_axis_tdata                      :   OUT   std_logic_vector(10 DOWNTO 0);  -- ufix11
        m_axis_tuser                      :   OUT   std_logic;
        m_axis_tlast                      :   OUT   std_logic
        );
END Hybrid_LHT_Accumulator;


ARCHITECTURE rtl OF Hybrid_LHT_Accumulator IS

  -- Component Declarations
  COMPONENT Accumulator_Controller
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          sof                             :   IN    std_logic;
          eof                             :   IN    std_logic;
          ntheta                          :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          nrho                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          nshift                          :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          shift                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
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
          shift                           :   IN    vector_of_std_logic_vector6(0 TO 59);  -- ufix6 [60]
          hough_address                   :   IN    vector_of_std_logic_vector11(0 TO 59);  -- ufix11 [60]
          edge_rsvd                       :   IN    std_logic;
          mode                            :   IN    std_logic;
          read_address                    :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          clear                           :   IN    std_logic;
          theta_index                     :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          hps                             :   OUT   std_logic_vector(10 DOWNTO 0)  -- ufix11
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Accumulator_Controller
    USE ENTITY work.Accumulator_Controller(rtl);

  FOR ALL : Accumulator_with_Switches
    USE ENTITY work.Accumulator_with_Switches(rtl);

  -- Signals
  SIGNAL HDL_Counter_out1                 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Compare_To_Constant3_out1        : std_logic;
  SIGNAL Constant1_out1                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Constant2_out1                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Constant3_out1                   : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL shift_1                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL mode                             : std_logic;
  SIGNAL read_rsvd                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL clear                            : std_logic;
  SIGNAL index                            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL valid                            : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL reduced_reg                      : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL mode_1                           : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL kconst                           : unsigned(5 DOWNTO 0);  -- ufix6_En2
  SIGNAL kconst_1                         : unsigned(5 DOWNTO 0);  -- ufix6_En2
  SIGNAL shift_unsigned                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Data_Type_Conversion_out1        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Data_Type_Conversion_out1_1      : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Gain_mul_temp                    : unsigned(11 DOWNTO 0);  -- ufix12_En2
  SIGNAL Gain_out1                        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Gain_out1_1                      : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Gain_out1_scalarexpand           : vector_of_unsigned6(0 TO 59);  -- ufix6 [60]
  SIGNAL shift_unsigned_1                 : vector_of_unsigned6(0 TO 59);  -- ufix6 [60]
  SIGNAL shift_2                          : vector_of_unsigned6(0 TO 59);  -- ufix6 [60]
  SIGNAL Switch_out1                      : vector_of_unsigned6(0 TO 59);  -- ufix6 [60]
  SIGNAL Switch_out1_1                    : vector_of_std_logic_vector6(0 TO 59);  -- ufix6 [60]
  SIGNAL AND1_out1                        : std_logic;
  SIGNAL mode_2                           : std_logic;
  SIGNAL Accumulator_with_Switches_out1   : std_logic_vector(10 DOWNTO 0);  -- ufix11
  SIGNAL Accumulator_with_Switches_out1_unsigned : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Constant_out1                    : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Multiport_Switch2_out1           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Compare_To_Constant4_out1        : std_logic;
  SIGNAL Delay5_out1                      : std_logic;
  SIGNAL index_unsigned                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL delayMatch3_reg                  : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL read_unsigned                    : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL delayMatch4_reg                  : std_logic_vector(0 TO 2);  -- ufix1 [3]
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
              nshift => std_logic_vector(Constant3_out1),  -- ufix3
              shift => shift_1,  -- uint16
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
              shift => Switch_out1_1,  -- ufix6 [60]
              hough_address => hough_param,  -- ufix11 [60]
              edge_rsvd => AND1_out1,
              mode => mode,
              read_address => read_rsvd,  -- uint16
              clear => clear,
              theta_index => index,  -- uint16
              hps => Accumulator_with_Switches_out1  -- ufix11
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 768
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF s_axis_tuser = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#000#, 10);
        ELSIF s_axis_tlast = '1' THEN 
          IF HDL_Counter_out1 >= to_unsigned(16#300#, 10) THEN 
            HDL_Counter_out1 <= to_unsigned(16#000#, 10);
          ELSE 
            HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#001#, 10);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Constant3_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(16#300#, 10) ELSE
      '0';

  Constant1_out1 <= to_unsigned(16#003B#, 16);

  Constant2_out1 <= to_unsigned(16#04FF#, 16);

  Constant3_out1 <= to_unsigned(16#2#, 3);

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


  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        reduced_reg(0) <= mode;
        reduced_reg(1) <= reduced_reg(0);
      END IF;
    END IF;
  END PROCESS reduced_process;

  mode_1 <= reduced_reg(1);

  
  switch_compare_1 <= '1' WHEN mode_1 > '0' ELSE
      '0';

  kconst <= to_unsigned(16#2C#, 6);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        kconst_1 <= kconst;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  shift_unsigned <= unsigned(shift_1);

  Data_Type_Conversion_out1 <= shift_unsigned(5 DOWNTO 0);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Data_Type_Conversion_out1_1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Data_Type_Conversion_out1_1 <= Data_Type_Conversion_out1;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Gain_mul_temp <= kconst_1 * Data_Type_Conversion_out1_1;
  Gain_out1 <= Gain_mul_temp(7 DOWNTO 2);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Gain_out1_1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Gain_out1_1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Gain_out1_scalarexpand(0) <= Gain_out1_1;
  Gain_out1_scalarexpand(1) <= Gain_out1_1;
  Gain_out1_scalarexpand(2) <= Gain_out1_1;
  Gain_out1_scalarexpand(3) <= Gain_out1_1;
  Gain_out1_scalarexpand(4) <= Gain_out1_1;
  Gain_out1_scalarexpand(5) <= Gain_out1_1;
  Gain_out1_scalarexpand(6) <= Gain_out1_1;
  Gain_out1_scalarexpand(7) <= Gain_out1_1;
  Gain_out1_scalarexpand(8) <= Gain_out1_1;
  Gain_out1_scalarexpand(9) <= Gain_out1_1;
  Gain_out1_scalarexpand(10) <= Gain_out1_1;
  Gain_out1_scalarexpand(11) <= Gain_out1_1;
  Gain_out1_scalarexpand(12) <= Gain_out1_1;
  Gain_out1_scalarexpand(13) <= Gain_out1_1;
  Gain_out1_scalarexpand(14) <= Gain_out1_1;
  Gain_out1_scalarexpand(15) <= Gain_out1_1;
  Gain_out1_scalarexpand(16) <= Gain_out1_1;
  Gain_out1_scalarexpand(17) <= Gain_out1_1;
  Gain_out1_scalarexpand(18) <= Gain_out1_1;
  Gain_out1_scalarexpand(19) <= Gain_out1_1;
  Gain_out1_scalarexpand(20) <= Gain_out1_1;
  Gain_out1_scalarexpand(21) <= Gain_out1_1;
  Gain_out1_scalarexpand(22) <= Gain_out1_1;
  Gain_out1_scalarexpand(23) <= Gain_out1_1;
  Gain_out1_scalarexpand(24) <= Gain_out1_1;
  Gain_out1_scalarexpand(25) <= Gain_out1_1;
  Gain_out1_scalarexpand(26) <= Gain_out1_1;
  Gain_out1_scalarexpand(27) <= Gain_out1_1;
  Gain_out1_scalarexpand(28) <= Gain_out1_1;
  Gain_out1_scalarexpand(29) <= Gain_out1_1;
  Gain_out1_scalarexpand(30) <= Gain_out1_1;
  Gain_out1_scalarexpand(31) <= Gain_out1_1;
  Gain_out1_scalarexpand(32) <= Gain_out1_1;
  Gain_out1_scalarexpand(33) <= Gain_out1_1;
  Gain_out1_scalarexpand(34) <= Gain_out1_1;
  Gain_out1_scalarexpand(35) <= Gain_out1_1;
  Gain_out1_scalarexpand(36) <= Gain_out1_1;
  Gain_out1_scalarexpand(37) <= Gain_out1_1;
  Gain_out1_scalarexpand(38) <= Gain_out1_1;
  Gain_out1_scalarexpand(39) <= Gain_out1_1;
  Gain_out1_scalarexpand(40) <= Gain_out1_1;
  Gain_out1_scalarexpand(41) <= Gain_out1_1;
  Gain_out1_scalarexpand(42) <= Gain_out1_1;
  Gain_out1_scalarexpand(43) <= Gain_out1_1;
  Gain_out1_scalarexpand(44) <= Gain_out1_1;
  Gain_out1_scalarexpand(45) <= Gain_out1_1;
  Gain_out1_scalarexpand(46) <= Gain_out1_1;
  Gain_out1_scalarexpand(47) <= Gain_out1_1;
  Gain_out1_scalarexpand(48) <= Gain_out1_1;
  Gain_out1_scalarexpand(49) <= Gain_out1_1;
  Gain_out1_scalarexpand(50) <= Gain_out1_1;
  Gain_out1_scalarexpand(51) <= Gain_out1_1;
  Gain_out1_scalarexpand(52) <= Gain_out1_1;
  Gain_out1_scalarexpand(53) <= Gain_out1_1;
  Gain_out1_scalarexpand(54) <= Gain_out1_1;
  Gain_out1_scalarexpand(55) <= Gain_out1_1;
  Gain_out1_scalarexpand(56) <= Gain_out1_1;
  Gain_out1_scalarexpand(57) <= Gain_out1_1;
  Gain_out1_scalarexpand(58) <= Gain_out1_1;
  Gain_out1_scalarexpand(59) <= Gain_out1_1;

  outputgen1: FOR k IN 0 TO 59 GENERATE
    shift_unsigned_1(k) <= unsigned(shift(k));
  END GENERATE;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      shift_2 <= (OTHERS => to_unsigned(16#00#, 6));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        shift_2 <= shift_unsigned_1;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  
  Switch_out1 <= Gain_out1_scalarexpand WHEN switch_compare_1 = '0' ELSE
      shift_2;

  outputgen: FOR k IN 0 TO 59 GENERATE
    Switch_out1_1(k) <= std_logic_vector(Switch_out1(k));
  END GENERATE;

  AND1_out1 <= edge_rsvd AND s_axis_tvalid;

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      mode_2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        mode_2 <= mode_1;
      END IF;
    END IF;
  END PROCESS reduced_1_process;


  Accumulator_with_Switches_out1_unsigned <= unsigned(Accumulator_with_Switches_out1);

  Constant_out1 <= to_unsigned(16#000#, 11);

  
  Multiport_Switch2_out1 <= Accumulator_with_Switches_out1_unsigned WHEN mode_2 = '0' ELSE
      Constant_out1;

  m_axis_tdata <= std_logic_vector(Multiport_Switch2_out1);

  
  Compare_To_Constant4_out1 <= '1' WHEN Gain_out1_1 = to_unsigned(16#00#, 6) ELSE
      '0';

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_out1 <= Compare_To_Constant4_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  index_unsigned <= unsigned(index);

  
  Compare_To_Constant1_out1 <= '1' WHEN index_unsigned = to_unsigned(16#0000#, 16) ELSE
      '0';

  delayMatch3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch3_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch3_reg(0) <= Compare_To_Constant1_out1;
        delayMatch3_reg(1 TO 2) <= delayMatch3_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch3_process;

  Delay_out1 <= delayMatch3_reg(2);

  read_unsigned <= unsigned(read_rsvd);

  
  Compare_To_Constant_out1 <= '1' WHEN read_unsigned = to_unsigned(16#0000#, 16) ELSE
      '0';

  delayMatch4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch4_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch4_reg(0) <= Compare_To_Constant_out1;
        delayMatch4_reg(1 TO 2) <= delayMatch4_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch4_process;

  Delay1_out1 <= delayMatch4_reg(2);

  AND_out1 <= Delay1_out1 AND (Delay5_out1 AND Delay_out1);

  
  Compare_To_Constant2_out1 <= '1' WHEN read_unsigned = to_unsigned(16#04FF#, 16) ELSE
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

