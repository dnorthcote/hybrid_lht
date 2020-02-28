-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_720p\hdlsrc\parallel_lht\Accumulator_with_Switches.vhd
-- Created: 2020-02-27 21:50:44
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Accumulator_with_Switches
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Parallel_LHT_pkg.ALL;

ENTITY Accumulator_with_Switches IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        hough_address                     :   IN    vector_of_std_logic_vector11(0 TO 179);  -- ufix11 [180]
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
  SIGNAL Data_Type_Conversion_out1_scalarexpand : vector_of_unsigned11(0 TO 179);  -- ufix11 [180]
  SIGNAL hough_address_unsigned           : vector_of_unsigned11(0 TO 179);  -- ufix11 [180]
  SIGNAL Switch_out1                      : vector_of_unsigned11(0 TO 179);  -- ufix11 [180]
  SIGNAL Switch_out1_1                    : vector_of_std_logic_vector11(0 TO 179);  -- ufix11 [180]
  SIGNAL Multiport_Switch1_out1           : std_logic;
  SIGNAL reduced_reg_1                    : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Multiport_Switch1_out1_1         : std_logic;
  SIGNAL delayMatch362_reg                : vector_of_unsigned16(0 TO 1);  -- ufix16 [2]
  SIGNAL Delay_out1_1                     : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Accumulator_out1                 : vector_of_std_logic_vector11(0 TO 179);  -- ufix11 [180]
  SIGNAL Accumulator_out1_unsigned        : vector_of_unsigned11(0 TO 179);  -- ufix11 [180]
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
  Data_Type_Conversion_out1_scalarexpand(34) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(35) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(36) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(37) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(38) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(39) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(40) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(41) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(42) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(43) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(44) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(45) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(46) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(47) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(48) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(49) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(50) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(51) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(52) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(53) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(54) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(55) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(56) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(57) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(58) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(59) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(60) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(61) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(62) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(63) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(64) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(65) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(66) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(67) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(68) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(69) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(70) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(71) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(72) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(73) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(74) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(75) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(76) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(77) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(78) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(79) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(80) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(81) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(82) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(83) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(84) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(85) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(86) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(87) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(88) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(89) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(90) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(91) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(92) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(93) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(94) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(95) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(96) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(97) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(98) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(99) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(100) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(101) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(102) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(103) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(104) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(105) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(106) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(107) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(108) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(109) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(110) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(111) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(112) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(113) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(114) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(115) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(116) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(117) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(118) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(119) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(120) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(121) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(122) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(123) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(124) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(125) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(126) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(127) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(128) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(129) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(130) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(131) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(132) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(133) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(134) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(135) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(136) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(137) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(138) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(139) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(140) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(141) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(142) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(143) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(144) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(145) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(146) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(147) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(148) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(149) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(150) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(151) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(152) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(153) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(154) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(155) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(156) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(157) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(158) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(159) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(160) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(161) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(162) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(163) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(164) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(165) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(166) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(167) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(168) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(169) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(170) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(171) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(172) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(173) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(174) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(175) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(176) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(177) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(178) <= Data_Type_Conversion_out1_1;
  Data_Type_Conversion_out1_scalarexpand(179) <= Data_Type_Conversion_out1_1;

  outputgen2: FOR k1 IN 0 TO 179 GENERATE
    hough_address_unsigned(k1) <= unsigned(hough_address(k1));
  END GENERATE;

  
  Switch_out1 <= Data_Type_Conversion_out1_scalarexpand WHEN switch_compare_1 = '0' ELSE
      hough_address_unsigned;

  outputgen1: FOR k1 IN 0 TO 179 GENERATE
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

  delayMatch362_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch362_reg <= (OTHERS => to_unsigned(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch362_reg(0) <= Delay_out1;
        delayMatch362_reg(1) <= delayMatch362_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch362_process;

  Delay_out1_1 <= delayMatch362_reg(1);

  GEN_LABEL: FOR k IN 0 TO 179 GENERATE
    u_Accumulator : Accumulator
      PORT MAP( clk => clk,
                reset => reset,
                enb => enb,
                mode => mode_1,
                address => Switch_out1_1(k),  -- ufix11
                edge_rsvd => Multiport_Switch1_out1_1,
                hps => Accumulator_out1(k)  -- ufix11
                );
  END GENERATE;

  outputgen: FOR k IN 0 TO 179 GENERATE
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
      Accumulator_out1_unsigned(33) WHEN Delay_out1_1 = to_unsigned(16#0021#, 16) ELSE
      Accumulator_out1_unsigned(34) WHEN Delay_out1_1 = to_unsigned(16#0022#, 16) ELSE
      Accumulator_out1_unsigned(35) WHEN Delay_out1_1 = to_unsigned(16#0023#, 16) ELSE
      Accumulator_out1_unsigned(36) WHEN Delay_out1_1 = to_unsigned(16#0024#, 16) ELSE
      Accumulator_out1_unsigned(37) WHEN Delay_out1_1 = to_unsigned(16#0025#, 16) ELSE
      Accumulator_out1_unsigned(38) WHEN Delay_out1_1 = to_unsigned(16#0026#, 16) ELSE
      Accumulator_out1_unsigned(39) WHEN Delay_out1_1 = to_unsigned(16#0027#, 16) ELSE
      Accumulator_out1_unsigned(40) WHEN Delay_out1_1 = to_unsigned(16#0028#, 16) ELSE
      Accumulator_out1_unsigned(41) WHEN Delay_out1_1 = to_unsigned(16#0029#, 16) ELSE
      Accumulator_out1_unsigned(42) WHEN Delay_out1_1 = to_unsigned(16#002A#, 16) ELSE
      Accumulator_out1_unsigned(43) WHEN Delay_out1_1 = to_unsigned(16#002B#, 16) ELSE
      Accumulator_out1_unsigned(44) WHEN Delay_out1_1 = to_unsigned(16#002C#, 16) ELSE
      Accumulator_out1_unsigned(45) WHEN Delay_out1_1 = to_unsigned(16#002D#, 16) ELSE
      Accumulator_out1_unsigned(46) WHEN Delay_out1_1 = to_unsigned(16#002E#, 16) ELSE
      Accumulator_out1_unsigned(47) WHEN Delay_out1_1 = to_unsigned(16#002F#, 16) ELSE
      Accumulator_out1_unsigned(48) WHEN Delay_out1_1 = to_unsigned(16#0030#, 16) ELSE
      Accumulator_out1_unsigned(49) WHEN Delay_out1_1 = to_unsigned(16#0031#, 16) ELSE
      Accumulator_out1_unsigned(50) WHEN Delay_out1_1 = to_unsigned(16#0032#, 16) ELSE
      Accumulator_out1_unsigned(51) WHEN Delay_out1_1 = to_unsigned(16#0033#, 16) ELSE
      Accumulator_out1_unsigned(52) WHEN Delay_out1_1 = to_unsigned(16#0034#, 16) ELSE
      Accumulator_out1_unsigned(53) WHEN Delay_out1_1 = to_unsigned(16#0035#, 16) ELSE
      Accumulator_out1_unsigned(54) WHEN Delay_out1_1 = to_unsigned(16#0036#, 16) ELSE
      Accumulator_out1_unsigned(55) WHEN Delay_out1_1 = to_unsigned(16#0037#, 16) ELSE
      Accumulator_out1_unsigned(56) WHEN Delay_out1_1 = to_unsigned(16#0038#, 16) ELSE
      Accumulator_out1_unsigned(57) WHEN Delay_out1_1 = to_unsigned(16#0039#, 16) ELSE
      Accumulator_out1_unsigned(58) WHEN Delay_out1_1 = to_unsigned(16#003A#, 16) ELSE
      Accumulator_out1_unsigned(59) WHEN Delay_out1_1 = to_unsigned(16#003B#, 16) ELSE
      Accumulator_out1_unsigned(60) WHEN Delay_out1_1 = to_unsigned(16#003C#, 16) ELSE
      Accumulator_out1_unsigned(61) WHEN Delay_out1_1 = to_unsigned(16#003D#, 16) ELSE
      Accumulator_out1_unsigned(62) WHEN Delay_out1_1 = to_unsigned(16#003E#, 16) ELSE
      Accumulator_out1_unsigned(63) WHEN Delay_out1_1 = to_unsigned(16#003F#, 16) ELSE
      Accumulator_out1_unsigned(64) WHEN Delay_out1_1 = to_unsigned(16#0040#, 16) ELSE
      Accumulator_out1_unsigned(65) WHEN Delay_out1_1 = to_unsigned(16#0041#, 16) ELSE
      Accumulator_out1_unsigned(66) WHEN Delay_out1_1 = to_unsigned(16#0042#, 16) ELSE
      Accumulator_out1_unsigned(67) WHEN Delay_out1_1 = to_unsigned(16#0043#, 16) ELSE
      Accumulator_out1_unsigned(68) WHEN Delay_out1_1 = to_unsigned(16#0044#, 16) ELSE
      Accumulator_out1_unsigned(69) WHEN Delay_out1_1 = to_unsigned(16#0045#, 16) ELSE
      Accumulator_out1_unsigned(70) WHEN Delay_out1_1 = to_unsigned(16#0046#, 16) ELSE
      Accumulator_out1_unsigned(71) WHEN Delay_out1_1 = to_unsigned(16#0047#, 16) ELSE
      Accumulator_out1_unsigned(72) WHEN Delay_out1_1 = to_unsigned(16#0048#, 16) ELSE
      Accumulator_out1_unsigned(73) WHEN Delay_out1_1 = to_unsigned(16#0049#, 16) ELSE
      Accumulator_out1_unsigned(74) WHEN Delay_out1_1 = to_unsigned(16#004A#, 16) ELSE
      Accumulator_out1_unsigned(75) WHEN Delay_out1_1 = to_unsigned(16#004B#, 16) ELSE
      Accumulator_out1_unsigned(76) WHEN Delay_out1_1 = to_unsigned(16#004C#, 16) ELSE
      Accumulator_out1_unsigned(77) WHEN Delay_out1_1 = to_unsigned(16#004D#, 16) ELSE
      Accumulator_out1_unsigned(78) WHEN Delay_out1_1 = to_unsigned(16#004E#, 16) ELSE
      Accumulator_out1_unsigned(79) WHEN Delay_out1_1 = to_unsigned(16#004F#, 16) ELSE
      Accumulator_out1_unsigned(80) WHEN Delay_out1_1 = to_unsigned(16#0050#, 16) ELSE
      Accumulator_out1_unsigned(81) WHEN Delay_out1_1 = to_unsigned(16#0051#, 16) ELSE
      Accumulator_out1_unsigned(82) WHEN Delay_out1_1 = to_unsigned(16#0052#, 16) ELSE
      Accumulator_out1_unsigned(83) WHEN Delay_out1_1 = to_unsigned(16#0053#, 16) ELSE
      Accumulator_out1_unsigned(84) WHEN Delay_out1_1 = to_unsigned(16#0054#, 16) ELSE
      Accumulator_out1_unsigned(85) WHEN Delay_out1_1 = to_unsigned(16#0055#, 16) ELSE
      Accumulator_out1_unsigned(86) WHEN Delay_out1_1 = to_unsigned(16#0056#, 16) ELSE
      Accumulator_out1_unsigned(87) WHEN Delay_out1_1 = to_unsigned(16#0057#, 16) ELSE
      Accumulator_out1_unsigned(88) WHEN Delay_out1_1 = to_unsigned(16#0058#, 16) ELSE
      Accumulator_out1_unsigned(89) WHEN Delay_out1_1 = to_unsigned(16#0059#, 16) ELSE
      Accumulator_out1_unsigned(90) WHEN Delay_out1_1 = to_unsigned(16#005A#, 16) ELSE
      Accumulator_out1_unsigned(91) WHEN Delay_out1_1 = to_unsigned(16#005B#, 16) ELSE
      Accumulator_out1_unsigned(92) WHEN Delay_out1_1 = to_unsigned(16#005C#, 16) ELSE
      Accumulator_out1_unsigned(93) WHEN Delay_out1_1 = to_unsigned(16#005D#, 16) ELSE
      Accumulator_out1_unsigned(94) WHEN Delay_out1_1 = to_unsigned(16#005E#, 16) ELSE
      Accumulator_out1_unsigned(95) WHEN Delay_out1_1 = to_unsigned(16#005F#, 16) ELSE
      Accumulator_out1_unsigned(96) WHEN Delay_out1_1 = to_unsigned(16#0060#, 16) ELSE
      Accumulator_out1_unsigned(97) WHEN Delay_out1_1 = to_unsigned(16#0061#, 16) ELSE
      Accumulator_out1_unsigned(98) WHEN Delay_out1_1 = to_unsigned(16#0062#, 16) ELSE
      Accumulator_out1_unsigned(99) WHEN Delay_out1_1 = to_unsigned(16#0063#, 16) ELSE
      Accumulator_out1_unsigned(100) WHEN Delay_out1_1 = to_unsigned(16#0064#, 16) ELSE
      Accumulator_out1_unsigned(101) WHEN Delay_out1_1 = to_unsigned(16#0065#, 16) ELSE
      Accumulator_out1_unsigned(102) WHEN Delay_out1_1 = to_unsigned(16#0066#, 16) ELSE
      Accumulator_out1_unsigned(103) WHEN Delay_out1_1 = to_unsigned(16#0067#, 16) ELSE
      Accumulator_out1_unsigned(104) WHEN Delay_out1_1 = to_unsigned(16#0068#, 16) ELSE
      Accumulator_out1_unsigned(105) WHEN Delay_out1_1 = to_unsigned(16#0069#, 16) ELSE
      Accumulator_out1_unsigned(106) WHEN Delay_out1_1 = to_unsigned(16#006A#, 16) ELSE
      Accumulator_out1_unsigned(107) WHEN Delay_out1_1 = to_unsigned(16#006B#, 16) ELSE
      Accumulator_out1_unsigned(108) WHEN Delay_out1_1 = to_unsigned(16#006C#, 16) ELSE
      Accumulator_out1_unsigned(109) WHEN Delay_out1_1 = to_unsigned(16#006D#, 16) ELSE
      Accumulator_out1_unsigned(110) WHEN Delay_out1_1 = to_unsigned(16#006E#, 16) ELSE
      Accumulator_out1_unsigned(111) WHEN Delay_out1_1 = to_unsigned(16#006F#, 16) ELSE
      Accumulator_out1_unsigned(112) WHEN Delay_out1_1 = to_unsigned(16#0070#, 16) ELSE
      Accumulator_out1_unsigned(113) WHEN Delay_out1_1 = to_unsigned(16#0071#, 16) ELSE
      Accumulator_out1_unsigned(114) WHEN Delay_out1_1 = to_unsigned(16#0072#, 16) ELSE
      Accumulator_out1_unsigned(115) WHEN Delay_out1_1 = to_unsigned(16#0073#, 16) ELSE
      Accumulator_out1_unsigned(116) WHEN Delay_out1_1 = to_unsigned(16#0074#, 16) ELSE
      Accumulator_out1_unsigned(117) WHEN Delay_out1_1 = to_unsigned(16#0075#, 16) ELSE
      Accumulator_out1_unsigned(118) WHEN Delay_out1_1 = to_unsigned(16#0076#, 16) ELSE
      Accumulator_out1_unsigned(119) WHEN Delay_out1_1 = to_unsigned(16#0077#, 16) ELSE
      Accumulator_out1_unsigned(120) WHEN Delay_out1_1 = to_unsigned(16#0078#, 16) ELSE
      Accumulator_out1_unsigned(121) WHEN Delay_out1_1 = to_unsigned(16#0079#, 16) ELSE
      Accumulator_out1_unsigned(122) WHEN Delay_out1_1 = to_unsigned(16#007A#, 16) ELSE
      Accumulator_out1_unsigned(123) WHEN Delay_out1_1 = to_unsigned(16#007B#, 16) ELSE
      Accumulator_out1_unsigned(124) WHEN Delay_out1_1 = to_unsigned(16#007C#, 16) ELSE
      Accumulator_out1_unsigned(125) WHEN Delay_out1_1 = to_unsigned(16#007D#, 16) ELSE
      Accumulator_out1_unsigned(126) WHEN Delay_out1_1 = to_unsigned(16#007E#, 16) ELSE
      Accumulator_out1_unsigned(127) WHEN Delay_out1_1 = to_unsigned(16#007F#, 16) ELSE
      Accumulator_out1_unsigned(128) WHEN Delay_out1_1 = to_unsigned(16#0080#, 16) ELSE
      Accumulator_out1_unsigned(129) WHEN Delay_out1_1 = to_unsigned(16#0081#, 16) ELSE
      Accumulator_out1_unsigned(130) WHEN Delay_out1_1 = to_unsigned(16#0082#, 16) ELSE
      Accumulator_out1_unsigned(131) WHEN Delay_out1_1 = to_unsigned(16#0083#, 16) ELSE
      Accumulator_out1_unsigned(132) WHEN Delay_out1_1 = to_unsigned(16#0084#, 16) ELSE
      Accumulator_out1_unsigned(133) WHEN Delay_out1_1 = to_unsigned(16#0085#, 16) ELSE
      Accumulator_out1_unsigned(134) WHEN Delay_out1_1 = to_unsigned(16#0086#, 16) ELSE
      Accumulator_out1_unsigned(135) WHEN Delay_out1_1 = to_unsigned(16#0087#, 16) ELSE
      Accumulator_out1_unsigned(136) WHEN Delay_out1_1 = to_unsigned(16#0088#, 16) ELSE
      Accumulator_out1_unsigned(137) WHEN Delay_out1_1 = to_unsigned(16#0089#, 16) ELSE
      Accumulator_out1_unsigned(138) WHEN Delay_out1_1 = to_unsigned(16#008A#, 16) ELSE
      Accumulator_out1_unsigned(139) WHEN Delay_out1_1 = to_unsigned(16#008B#, 16) ELSE
      Accumulator_out1_unsigned(140) WHEN Delay_out1_1 = to_unsigned(16#008C#, 16) ELSE
      Accumulator_out1_unsigned(141) WHEN Delay_out1_1 = to_unsigned(16#008D#, 16) ELSE
      Accumulator_out1_unsigned(142) WHEN Delay_out1_1 = to_unsigned(16#008E#, 16) ELSE
      Accumulator_out1_unsigned(143) WHEN Delay_out1_1 = to_unsigned(16#008F#, 16) ELSE
      Accumulator_out1_unsigned(144) WHEN Delay_out1_1 = to_unsigned(16#0090#, 16) ELSE
      Accumulator_out1_unsigned(145) WHEN Delay_out1_1 = to_unsigned(16#0091#, 16) ELSE
      Accumulator_out1_unsigned(146) WHEN Delay_out1_1 = to_unsigned(16#0092#, 16) ELSE
      Accumulator_out1_unsigned(147) WHEN Delay_out1_1 = to_unsigned(16#0093#, 16) ELSE
      Accumulator_out1_unsigned(148) WHEN Delay_out1_1 = to_unsigned(16#0094#, 16) ELSE
      Accumulator_out1_unsigned(149) WHEN Delay_out1_1 = to_unsigned(16#0095#, 16) ELSE
      Accumulator_out1_unsigned(150) WHEN Delay_out1_1 = to_unsigned(16#0096#, 16) ELSE
      Accumulator_out1_unsigned(151) WHEN Delay_out1_1 = to_unsigned(16#0097#, 16) ELSE
      Accumulator_out1_unsigned(152) WHEN Delay_out1_1 = to_unsigned(16#0098#, 16) ELSE
      Accumulator_out1_unsigned(153) WHEN Delay_out1_1 = to_unsigned(16#0099#, 16) ELSE
      Accumulator_out1_unsigned(154) WHEN Delay_out1_1 = to_unsigned(16#009A#, 16) ELSE
      Accumulator_out1_unsigned(155) WHEN Delay_out1_1 = to_unsigned(16#009B#, 16) ELSE
      Accumulator_out1_unsigned(156) WHEN Delay_out1_1 = to_unsigned(16#009C#, 16) ELSE
      Accumulator_out1_unsigned(157) WHEN Delay_out1_1 = to_unsigned(16#009D#, 16) ELSE
      Accumulator_out1_unsigned(158) WHEN Delay_out1_1 = to_unsigned(16#009E#, 16) ELSE
      Accumulator_out1_unsigned(159) WHEN Delay_out1_1 = to_unsigned(16#009F#, 16) ELSE
      Accumulator_out1_unsigned(160) WHEN Delay_out1_1 = to_unsigned(16#00A0#, 16) ELSE
      Accumulator_out1_unsigned(161) WHEN Delay_out1_1 = to_unsigned(16#00A1#, 16) ELSE
      Accumulator_out1_unsigned(162) WHEN Delay_out1_1 = to_unsigned(16#00A2#, 16) ELSE
      Accumulator_out1_unsigned(163) WHEN Delay_out1_1 = to_unsigned(16#00A3#, 16) ELSE
      Accumulator_out1_unsigned(164) WHEN Delay_out1_1 = to_unsigned(16#00A4#, 16) ELSE
      Accumulator_out1_unsigned(165) WHEN Delay_out1_1 = to_unsigned(16#00A5#, 16) ELSE
      Accumulator_out1_unsigned(166) WHEN Delay_out1_1 = to_unsigned(16#00A6#, 16) ELSE
      Accumulator_out1_unsigned(167) WHEN Delay_out1_1 = to_unsigned(16#00A7#, 16) ELSE
      Accumulator_out1_unsigned(168) WHEN Delay_out1_1 = to_unsigned(16#00A8#, 16) ELSE
      Accumulator_out1_unsigned(169) WHEN Delay_out1_1 = to_unsigned(16#00A9#, 16) ELSE
      Accumulator_out1_unsigned(170) WHEN Delay_out1_1 = to_unsigned(16#00AA#, 16) ELSE
      Accumulator_out1_unsigned(171) WHEN Delay_out1_1 = to_unsigned(16#00AB#, 16) ELSE
      Accumulator_out1_unsigned(172) WHEN Delay_out1_1 = to_unsigned(16#00AC#, 16) ELSE
      Accumulator_out1_unsigned(173) WHEN Delay_out1_1 = to_unsigned(16#00AD#, 16) ELSE
      Accumulator_out1_unsigned(174) WHEN Delay_out1_1 = to_unsigned(16#00AE#, 16) ELSE
      Accumulator_out1_unsigned(175) WHEN Delay_out1_1 = to_unsigned(16#00AF#, 16) ELSE
      Accumulator_out1_unsigned(176) WHEN Delay_out1_1 = to_unsigned(16#00B0#, 16) ELSE
      Accumulator_out1_unsigned(177) WHEN Delay_out1_1 = to_unsigned(16#00B1#, 16) ELSE
      Accumulator_out1_unsigned(178) WHEN Delay_out1_1 = to_unsigned(16#00B2#, 16) ELSE
      Accumulator_out1_unsigned(179);

  hps <= std_logic_vector(Selector_out1);

END rtl;

