-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_768p\hdlsrc\hybrid_lht\Accumulator.vhd
-- Created: 2020-03-05 09:47:46
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Accumulator
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator
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
        shift                             :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        mode                              :   IN    std_logic;
        address                           :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
        edge_rsvd                         :   IN    std_logic;
        hps                               :   OUT   std_logic_vector(10 DOWNTO 0)  -- ufix11
        );
END Accumulator;


ARCHITECTURE rtl OF Accumulator IS

  -- Component Declarations
  COMPONENT Block_RAM
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_data                         :   IN    std_logic_vector(35 DOWNTO 0);  -- ufix36
          wr_addr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          rd_data                         :   OUT   std_logic_vector(35 DOWNTO 0)  -- ufix36
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Block_RAM
    USE ENTITY work.Block_RAM(rtl);

  -- Signals
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL address_unsigned                 : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Delay_out1                       : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Constant1_out1                   : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL shift_unsigned                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Delay4_out1                      : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Shift_Arithmetic1_out1           : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Bitwise_NOT_out1                 : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Constant_out1                    : unsigned(24 DOWNTO 0);  -- ufix25
  SIGNAL Zero_out1                        : std_logic;  -- ufix1
  SIGNAL Zero_out1_dtc                    : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Vote_out1                        : std_logic;  -- ufix1
  SIGNAL Bitwise_OR_out1                  : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Delay5_out1                      : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Bit_Slice_out1                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Add_add_cast                     : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Add_out1                         : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Multiport_Switch_out1            : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Bit_Concat_out1                  : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Shift_Arithmetic_out1            : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Multiport_Switch1_out1           : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Bitwise_AND_out1                 : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Block_RAM_out1                   : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL Block_RAM_out1_unsigned          : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL Shift_Arithmetic2_out1           : unsigned(35 DOWNTO 0);  -- ufix36

BEGIN
  u_Block_RAM : Block_RAM
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              wr_data => std_logic_vector(Bitwise_OR_out1),  -- ufix36
              wr_addr => std_logic_vector(Delay_out1),  -- ufix11
              wr_en => Delay1_out1,
              rd_addr => address,  -- ufix11
              rd_data => Block_RAM_out1  -- ufix36
              );

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
      Delay_out1 <= to_unsigned(16#000#, 11);
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


  Constant1_out1 <= to_unsigned(2047, 36);

  shift_unsigned <= unsigned(shift);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= shift_unsigned;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Shift_Arithmetic1_out1 <= Constant1_out1 sll to_integer(Delay4_out1);

  Bitwise_NOT_out1 <=  NOT Shift_Arithmetic1_out1;

  Constant_out1 <= to_unsigned(16#0000000#, 25);

  Zero_out1 <= '0';

  Zero_out1_dtc <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Zero_out1;

  Vote_out1 <= '1';

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_out1 <= to_unsigned(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_out1 <= Bitwise_OR_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  Add_add_cast <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Vote_out1;
  Add_out1 <= Add_add_cast + Bit_Slice_out1;

  
  Multiport_Switch_out1 <= Zero_out1_dtc WHEN mode = '0' ELSE
      Add_out1;

  Bit_Concat_out1 <= Constant_out1 & Multiport_Switch_out1;

  Shift_Arithmetic_out1 <= Bit_Concat_out1 sll to_integer(Delay4_out1);

  Bitwise_AND_out1 <= Bitwise_NOT_out1 AND Multiport_Switch1_out1;

  Bitwise_OR_out1 <= Bitwise_AND_out1 OR Shift_Arithmetic_out1;

  Block_RAM_out1_unsigned <= unsigned(Block_RAM_out1);

  
  Multiport_Switch1_out1 <= Block_RAM_out1_unsigned WHEN Delay2_out1 = '0' ELSE
      Delay5_out1;

  Shift_Arithmetic2_out1 <= SHIFT_RIGHT(Multiport_Switch1_out1, to_integer(Delay4_out1));

  Bit_Slice_out1 <= Shift_Arithmetic2_out1(10 DOWNTO 0);

  hps <= std_logic_vector(Bit_Slice_out1);

END rtl;

