-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_480p\hdlsrc\hybrid_lht\Hybrid_LHT.vhd
-- Created: 2020-03-05 10:42:46
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 8.33333e-09
-- Target subsystem base rate: 8.33333e-09
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        8.33333e-09
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- m_axis_tvalid                 ce_out        8.33333e-09
-- m_axis_tdata                  ce_out        8.33333e-09
-- m_axis_tuser                  ce_out        8.33333e-09
-- m_axis_tlast                  ce_out        8.33333e-09
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Hybrid_LHT
-- Source Path: hybrid_lht/Hybrid LHT
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Hybrid_LHT IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_tdata                      :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        s_axis_tuser                      :   IN    std_logic;
        s_axis_tlast                      :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        m_axis_tvalid                     :   OUT   std_logic;
        m_axis_tdata                      :   OUT   std_logic_vector(9 DOWNTO 0);  -- ufix10
        m_axis_tuser                      :   OUT   std_logic;
        m_axis_tlast                      :   OUT   std_logic
        );
END Hybrid_LHT;


ARCHITECTURE rtl OF Hybrid_LHT IS

  -- Component Declarations
  COMPONENT Hybrid_LHT_Kernel
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          s_axis_tvalid                   :   IN    std_logic;
          s_axis_tdata                    :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          s_axis_tuser                    :   IN    std_logic;
          s_axis_tlast                    :   IN    std_logic;
          m_axis_tvalid                   :   OUT   std_logic;
          m_axis_tuser                    :   OUT   std_logic;
          m_axis_tlast                    :   OUT   std_logic;
          hough_param                     :   OUT   vector_of_std_logic_vector10(0 TO 59);  -- ufix10 [60]
          edge_rsvd                       :   OUT   std_logic;  -- ufix1
          shift                           :   OUT   vector_of_std_logic_vector6(0 TO 59)  -- ufix6 [60]
          );
  END COMPONENT;

  COMPONENT Hybrid_LHT_Accumulator
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          s_axis_tvalid                   :   IN    std_logic;
          s_axis_tuser                    :   IN    std_logic;
          s_axis_tlast                    :   IN    std_logic;
          hough_param                     :   IN    vector_of_std_logic_vector10(0 TO 59);  -- ufix10 [60]
          edge_rsvd                       :   IN    std_logic;  -- ufix1
          shift                           :   IN    vector_of_std_logic_vector6(0 TO 59);  -- ufix6 [60]
          m_axis_tvalid                   :   OUT   std_logic;
          m_axis_tdata                    :   OUT   std_logic_vector(9 DOWNTO 0);  -- ufix10
          m_axis_tuser                    :   OUT   std_logic;
          m_axis_tlast                    :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Hybrid_LHT_Kernel
    USE ENTITY work.Hybrid_LHT_Kernel(rtl);

  FOR ALL : Hybrid_LHT_Accumulator
    USE ENTITY work.Hybrid_LHT_Accumulator(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Hybrid_LHT_Kernel_out1           : std_logic;
  SIGNAL Hybrid_LHT_Kernel_out2           : std_logic;
  SIGNAL Hybrid_LHT_Kernel_out3           : std_logic;
  SIGNAL Hybrid_LHT_Kernel_out4           : vector_of_std_logic_vector10(0 TO 59);  -- ufix10 [60]
  SIGNAL y                                : std_logic;  -- ufix1
  SIGNAL Hybrid_LHT_Kernel_out6           : vector_of_std_logic_vector6(0 TO 59);  -- ufix6 [60]
  SIGNAL Hybrid_LHT_Accumulator_out1      : std_logic;
  SIGNAL Hybrid_LHT_Accumulator_out2      : std_logic_vector(9 DOWNTO 0);  -- ufix10
  SIGNAL Hybrid_LHT_Accumulator_out3      : std_logic;
  SIGNAL Hybrid_LHT_Accumulator_out4      : std_logic;
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Hybrid_LHT_Accumulator_out1_1    : std_logic;
  SIGNAL delayMatch1_reg                  : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Hybrid_LHT_Accumulator_out4_1    : std_logic;

BEGIN
  u_Hybrid_LHT_Kernel : Hybrid_LHT_Kernel
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              s_axis_tvalid => s_axis_tvalid,
              s_axis_tdata => s_axis_tdata,  -- ufix9
              s_axis_tuser => s_axis_tuser,
              s_axis_tlast => s_axis_tlast,
              m_axis_tvalid => Hybrid_LHT_Kernel_out1,
              m_axis_tuser => Hybrid_LHT_Kernel_out2,
              m_axis_tlast => Hybrid_LHT_Kernel_out3,
              hough_param => Hybrid_LHT_Kernel_out4,  -- ufix10 [60]
              edge_rsvd => y,  -- ufix1
              shift => Hybrid_LHT_Kernel_out6  -- ufix6 [60]
              );

  u_Hybrid_LHT_Accumulator : Hybrid_LHT_Accumulator
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              s_axis_tvalid => Hybrid_LHT_Kernel_out1,
              s_axis_tuser => Hybrid_LHT_Kernel_out2,
              s_axis_tlast => Hybrid_LHT_Kernel_out3,
              hough_param => Hybrid_LHT_Kernel_out4,  -- ufix10 [60]
              edge_rsvd => y,  -- ufix1
              shift => Hybrid_LHT_Kernel_out6,  -- ufix6 [60]
              m_axis_tvalid => Hybrid_LHT_Accumulator_out1,
              m_axis_tdata => Hybrid_LHT_Accumulator_out2,  -- ufix10
              m_axis_tuser => Hybrid_LHT_Accumulator_out3,
              m_axis_tlast => Hybrid_LHT_Accumulator_out4
              );

  enb <= clk_enable;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= Hybrid_LHT_Accumulator_out1;
        delayMatch_reg(1) <= delayMatch_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Hybrid_LHT_Accumulator_out1_1 <= delayMatch_reg(1);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= Hybrid_LHT_Accumulator_out4;
        delayMatch1_reg(1) <= delayMatch1_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  Hybrid_LHT_Accumulator_out4_1 <= delayMatch1_reg(1);

  ce_out <= clk_enable;

  m_axis_tvalid <= Hybrid_LHT_Accumulator_out1_1;

  m_axis_tdata <= Hybrid_LHT_Accumulator_out2;

  m_axis_tuser <= Hybrid_LHT_Accumulator_out3;

  m_axis_tlast <= Hybrid_LHT_Accumulator_out4_1;

END rtl;

