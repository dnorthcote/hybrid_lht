-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_240p\hdlsrc\parallel_lht\Accumulator.vhd
-- Created: 2020-02-27 22:45:54
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Accumulator
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Accumulator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        mode                              :   IN    std_logic;
        address                           :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        edge_rsvd                         :   IN    std_logic;
        hps                               :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
        );
END Accumulator;


ARCHITECTURE rtl OF Accumulator IS

  -- Component Declarations
  COMPONENT Block_RAM
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_data                         :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          wr_addr                         :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          rd_data                         :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Block_RAM
    USE ENTITY work.Block_RAM(rtl);

  -- Signals
  SIGNAL Zero_out1                        : std_logic;  -- ufix1
  SIGNAL Zero_out1_dtc                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Vote_out1                        : std_logic;  -- ufix1
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL address_unsigned                 : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Delay_out1                       : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Add_out1                         : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Delay3_out1                      : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Block_RAM_out1                   : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL Block_RAM_out1_unsigned          : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Multiport_Switch1_out1           : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Add_add_cast                     : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Multiport_Switch_out1            : unsigned(8 DOWNTO 0);  -- ufix9

BEGIN
  u_Block_RAM : Block_RAM
    PORT MAP( clk => clk,
              enb => enb,
              wr_data => std_logic_vector(Multiport_Switch_out1),  -- ufix9
              wr_addr => std_logic_vector(Delay_out1),  -- ufix9
              wr_en => Delay1_out1,
              rd_addr => address,  -- ufix9
              rd_data => Block_RAM_out1  -- ufix9
              );

  Zero_out1 <= '1';

  Zero_out1_dtc <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Zero_out1;

  Vote_out1 <= '1';

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= edge_rsvd;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  address_unsigned <= unsigned(address);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_unsigned(16#000#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= address_unsigned;
      END IF;
    END IF;
  END PROCESS Delay_process;


  
  Relational_Operator_relop1 <= '1' WHEN Delay_out1 = address_unsigned ELSE
      '0';

  AND_out1 <= Delay1_out1 AND Relational_Operator_relop1;

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= AND_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_unsigned(16#000#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Add_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Block_RAM_out1_unsigned <= unsigned(Block_RAM_out1);

  
  Multiport_Switch1_out1 <= Block_RAM_out1_unsigned WHEN Delay2_out1 = '0' ELSE
      Delay3_out1;

  Add_add_cast <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Vote_out1;
  Add_out1 <= Add_add_cast + Multiport_Switch1_out1;

  
  Multiport_Switch_out1 <= Zero_out1_dtc WHEN mode = '0' ELSE
      Add_out1;

  hps <= Block_RAM_out1;

END rtl;

