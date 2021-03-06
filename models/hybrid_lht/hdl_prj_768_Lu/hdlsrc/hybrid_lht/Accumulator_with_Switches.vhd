-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_768_Lu\hdlsrc\hybrid_lht\Accumulator_with_Switches.vhd
-- Created: 2020-03-05 10:20:19
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Accumulator_with_Switches
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Accumulator_with_Switches IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        shift                             :   IN    vector_of_std_logic_vector6(0 TO 33);  -- ufix6 [34]
        hough_address                     :   IN    vector_of_std_logic_vector11(0 TO 33);  -- ufix11 [34]
        edge_rsvd                         :   IN    std_logic;
        mode                              :   IN    std_logic;
        read_address                      :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        clear                             :   IN    std_logic;
        theta_index                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        hps                               :   OUT   std_logic_vector(10 DOWNTO 0)  -- ufix11
        );
END Accumulator_with_Switches;


ARCHITECTURE rtl OF Accumulator_with_Switches IS

  -- Component Declarations
  COMPONENT Accumulator
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          shift                           :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          mode                            :   IN    std_logic;
          address                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          edge_rsvd                       :   IN    std_logic;
          hps                             :   OUT   std_logic_vector(10 DOWNTO 0)  -- ufix11
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Accumulator
    USE ENTITY work.Accumulator(rtl);

  -- Signals
  SIGNAL theta_index_unsigned             : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Delay_out1                       : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL reduced_reg                      : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL mode_1                           : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL read_address_unsigned            : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Data_Type_Conversion_out1        : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL delayMatch1_reg                  : vector_of_unsigned11(0 TO 1);  -- ufix11 [2]
  SIGNAL Data_Type_Conversion_out1_1      : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Data_Type_Conversion_out1_scalarexpand : vector_of_unsigned11(0 TO 33);  -- ufix11 [34]
  SIGNAL hough_address_unsigned           : vector_of_unsigned11(0 TO 33);  -- ufix11 [34]
  SIGNAL Switch_out1                      : vector_of_unsigned11(0 TO 33);  -- ufix11 [34]
  SIGNAL Switch_out1_1                    : vector_of_std_logic_vector11(0 TO 33);  -- ufix11 [34]
  SIGNAL Multiport_Switch1_out1           : std_logic;
  SIGNAL reduced_reg_1                    : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Multiport_Switch1_out1_1         : std_logic;
  SIGNAL delayMatch70_reg                 : vector_of_unsigned16(0 TO 1);  -- ufix16 [2]
  SIGNAL Delay_out1_1                     : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Accumulator_out1                 : vector_of_std_logic_vector11(0 TO 33);  -- ufix11 [34]
  SIGNAL Accumulator_out1_unsigned        : vector_of_unsigned11(0 TO 33);  -- ufix11 [34]
  SIGNAL Selector_out1                    : unsigned(10 DOWNTO 0);  -- ufix11

BEGIN
  theta_index_unsigned <= unsigned(theta_index);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= theta_index_unsigned;
      END IF;
    END IF;
  END PROCESS Delay_process;


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

  read_address_unsigned <= unsigned(read_address);

  Data_Type_Conversion_out1 <= read_address_unsigned(10 DOWNTO 0);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => to_unsigned(16#000#, 11));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= Data_Type_Conversion_out1;
        delayMatch1_reg(1) <= delayMatch1_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  Data_Type_Conversion_out1_1 <= delayMatch1_reg(1);

  Data_Type_Conversion_out1_scalarexpand(0) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(1) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(2) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(3) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(4) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(5) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(6) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(7) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(8) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(9) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(10) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(11) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(12) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(13) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(14) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(15) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(16) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(17) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(18) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(19) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(20) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(21) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(22) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(23) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(24) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(25) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(26) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(27) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(28) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(29) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(30) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(31) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(32) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(33) <= Data_Type_Conversion_out1_1;

  outputgen2: FOR k1 IN 0 TO 33 GENERATE
    hough_address_unsigned(k1) <= unsigned(hough_address(k1));
  END GENERATE;

  
  Switch_out1 <= Data_Type_Conversion_out1_scalarexpand WHEN switch_compare_1 = '0' ELSE
      hough_address_unsigned;

  outputgen1: FOR k1 IN 0 TO 33 GENERATE
    Switch_out1_1(k1) <= std_logic_vector(Switch_out1(k1));
  END GENERATE;

  
  Multiport_Switch1_out1 <= clear WHEN mode = '0' ELSE
      edge_rsvd;

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg_1 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        reduced_reg_1(0) <= Multiport_Switch1_out1;
        reduced_reg_1(1) <= reduced_reg_1(0);
      END IF;
    END IF;
  END PROCESS reduced_1_process;

  Multiport_Switch1_out1_1 <= reduced_reg_1(1);

  delayMatch70_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch70_reg <= (OTHERS => to_unsigned(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch70_reg(0) <= Delay_out1;
        delayMatch70_reg(1) <= delayMatch70_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch70_process;

  Delay_out1_1 <= delayMatch70_reg(1);

  GEN_LABEL: FOR k IN 0 TO 33 GENERATE
    u_Accumulator : Accumulator
      PORT MAP( clk => clk,
                reset => reset,
                enb => enb,
                shift => shift(k),  -- ufix6
                mode => mode_1,
                address => Switch_out1_1(k),  -- ufix11
                edge_rsvd => Multiport_Switch1_out1_1,
                hps => Accumulator_out1(k)  -- ufix11
                );
  END GENERATE;

  outputgen: FOR k IN 0 TO 33 GENERATE
    Accumulator_out1_unsigned(k) <= unsigned(Accumulator_out1(k));
  END GENERATE;

  
  Selector_out1 <= Accumulator_out1_unsigned(0) WHEN Delay_out1_1 = to_unsigned(16#0000#, 16) ELSE
      Accumulator_out1_unsigned(1) WHEN Delay_out1_1 = to_unsigned(16#0001#, 16) ELSE
      Accumulator_out1_unsigned(2) WHEN Delay_out1_1 = to_unsigned(16#0002#, 16) ELSE
      Accumulator_out1_unsigned(3) WHEN Delay_out1_1 = to_unsigned(16#0003#, 16) ELSE
      Accumulator_out1_unsigned(4) WHEN Delay_out1_1 = to_unsigned(16#0004#, 16) ELSE
      Accumulator_out1_unsigned(5) WHEN Delay_out1_1 = to_unsigned(16#0005#, 16) ELSE
      Accumulator_out1_unsigned(6) WHEN Delay_out1_1 = to_unsigned(16#0006#, 16) ELSE
      Accumulator_out1_unsigned(7) WHEN Delay_out1_1 = to_unsigned(16#0007#, 16) ELSE
      Accumulator_out1_unsigned(8) WHEN Delay_out1_1 = to_unsigned(16#0008#, 16) ELSE
      Accumulator_out1_unsigned(9) WHEN Delay_out1_1 = to_unsigned(16#0009#, 16) ELSE
      Accumulator_out1_unsigned(10) WHEN Delay_out1_1 = to_unsigned(16#000A#, 16) ELSE
      Accumulator_out1_unsigned(11) WHEN Delay_out1_1 = to_unsigned(16#000B#, 16) ELSE
      Accumulator_out1_unsigned(12) WHEN Delay_out1_1 = to_unsigned(16#000C#, 16) ELSE
      Accumulator_out1_unsigned(13) WHEN Delay_out1_1 = to_unsigned(16#000D#, 16) ELSE
      Accumulator_out1_unsigned(14) WHEN Delay_out1_1 = to_unsigned(16#000E#, 16) ELSE
      Accumulator_out1_unsigned(15) WHEN Delay_out1_1 = to_unsigned(16#000F#, 16) ELSE
      Accumulator_out1_unsigned(16) WHEN Delay_out1_1 = to_unsigned(16#0010#, 16) ELSE
      Accumulator_out1_unsigned(17) WHEN Delay_out1_1 = to_unsigned(16#0011#, 16) ELSE
      Accumulator_out1_unsigned(18) WHEN Delay_out1_1 = to_unsigned(16#0012#, 16) ELSE
      Accumulator_out1_unsigned(19) WHEN Delay_out1_1 = to_unsigned(16#0013#, 16) ELSE
      Accumulator_out1_unsigned(20) WHEN Delay_out1_1 = to_unsigned(16#0014#, 16) ELSE
      Accumulator_out1_unsigned(21) WHEN Delay_out1_1 = to_unsigned(16#0015#, 16) ELSE
      Accumulator_out1_unsigned(22) WHEN Delay_out1_1 = to_unsigned(16#0016#, 16) ELSE
      Accumulator_out1_unsigned(23) WHEN Delay_out1_1 = to_unsigned(16#0017#, 16) ELSE
      Accumulator_out1_unsigned(24) WHEN Delay_out1_1 = to_unsigned(16#0018#, 16) ELSE
      Accumulator_out1_unsigned(25) WHEN Delay_out1_1 = to_unsigned(16#0019#, 16) ELSE
      Accumulator_out1_unsigned(26) WHEN Delay_out1_1 = to_unsigned(16#001A#, 16) ELSE
      Accumulator_out1_unsigned(27) WHEN Delay_out1_1 = to_unsigned(16#001B#, 16) ELSE
      Accumulator_out1_unsigned(28) WHEN Delay_out1_1 = to_unsigned(16#001C#, 16) ELSE
      Accumulator_out1_unsigned(29) WHEN Delay_out1_1 = to_unsigned(16#001D#, 16) ELSE
      Accumulator_out1_unsigned(30) WHEN Delay_out1_1 = to_unsigned(16#001E#, 16) ELSE
      Accumulator_out1_unsigned(31) WHEN Delay_out1_1 = to_unsigned(16#001F#, 16) ELSE
      Accumulator_out1_unsigned(32) WHEN Delay_out1_1 = to_unsigned(16#0020#, 16) ELSE
      Accumulator_out1_unsigned(33);

  hps <= std_logic_vector(Selector_out1);

END rtl;

