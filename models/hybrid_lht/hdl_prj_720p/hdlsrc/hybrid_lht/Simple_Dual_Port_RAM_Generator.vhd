-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_720p\hdlsrc\hybrid_lht\Simple_Dual_Port_RAM_Generator.vhd
-- Created: 2020-03-05 09:20:24
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Simple_Dual_Port_RAM_Generator
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple 
-- Dual Port RAM Generato
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Simple_Dual_Port_RAM_Generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        wr_data                           :   IN    std_logic_vector(35 DOWNTO 0);  -- ufix36
        wr_addr                           :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
        wr_en                             :   IN    std_logic;
        rd_addr                           :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
        rd_data                           :   OUT   std_logic_vector(35 DOWNTO 0)  -- ufix36
        );
END Simple_Dual_Port_RAM_Generator;


ARCHITECTURE rtl OF Simple_Dual_Port_RAM_Generator IS

  -- Component Declarations
  COMPONENT SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SimpleDualPortRAM_generic
    USE ENTITY work.SimpleDualPortRAM_generic(rtl);

  -- Signals
  SIGNAL rd_addr_unsigned                 : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL rd_bitslice_out1                 : std_logic;  -- ufix1
  SIGNAL rd_cmp2const_0_out1              : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL zero_out1                        : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL constant_0_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL switch_0_out1                    : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL rd_cmp2const_1_out1              : std_logic;
  SIGNAL switch_compare_1_1               : std_logic;
  SIGNAL constant_1_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL switch_1_out1                    : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL bitwise_or_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL wr_addr_unsigned                 : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL wr_address_out1                  : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL wr_bitslice_out1                 : std_logic;  -- ufix1
  SIGNAL wr_cmp2const_0_out1              : std_logic;
  SIGNAL and_0_out1                       : std_logic;
  SIGNAL rd_address_out1                  : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL wr_address_hr_out1               : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL wr_cmp2const_1_out1              : std_logic;
  SIGNAL and_1_out1                       : std_logic;
  SIGNAL rd_address_hr_out1               : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL delay_out1                       : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL simple_ram_0_out1                : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL simple_ram_0_out1_unsigned       : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL simple_ram_1_out1                : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL simple_ram_1_out1_unsigned       : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL multiport_switch_out1            : unsigned(35 DOWNTO 0);  -- ufix36

BEGIN
  u_simple_ram_0 : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 10,
                 DataWidth => 36
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => wr_data,
              wr_addr => std_logic_vector(wr_address_out1),
              wr_en => and_0_out1,
              rd_addr => std_logic_vector(rd_address_out1),
              rd_dout => simple_ram_0_out1
              );

  u_simple_ram_1 : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 9,
                 DataWidth => 36
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => wr_data,
              wr_addr => std_logic_vector(wr_address_hr_out1),
              wr_en => and_1_out1,
              rd_addr => std_logic_vector(rd_address_hr_out1),
              rd_dout => simple_ram_1_out1
              );

  rd_addr_unsigned <= unsigned(rd_addr);

  rd_bitslice_out1 <= rd_addr_unsigned(10);

  
  rd_cmp2const_0_out1 <= '1' WHEN rd_bitslice_out1 = '0' ELSE
      '0';

  
  switch_compare_1 <= '1' WHEN rd_cmp2const_0_out1 = '1' ELSE
      '0';

  zero_out1 <= to_unsigned(16#0#, 2);

  constant_0_out1 <= to_unsigned(16#0#, 2);

  
  switch_0_out1 <= zero_out1 WHEN switch_compare_1 = '0' ELSE
      constant_0_out1;

  
  rd_cmp2const_1_out1 <= '1' WHEN rd_bitslice_out1 = '1' ELSE
      '0';

  
  switch_compare_1_1 <= '1' WHEN rd_cmp2const_1_out1 = '1' ELSE
      '0';

  constant_1_out1 <= to_unsigned(16#1#, 2);

  
  switch_1_out1 <= zero_out1 WHEN switch_compare_1_1 = '0' ELSE
      constant_1_out1;

  bitwise_or_out1 <= switch_0_out1 OR switch_1_out1;

  wr_addr_unsigned <= unsigned(wr_addr);

  wr_address_out1 <= wr_addr_unsigned(9 DOWNTO 0);

  wr_bitslice_out1 <= wr_addr_unsigned(10);

  
  wr_cmp2const_0_out1 <= '1' WHEN wr_bitslice_out1 = '0' ELSE
      '0';

  and_0_out1 <= wr_cmp2const_0_out1 AND wr_en;

  rd_address_out1 <= rd_addr_unsigned(9 DOWNTO 0);

  wr_address_hr_out1 <= wr_addr_unsigned(8 DOWNTO 0);

  
  wr_cmp2const_1_out1 <= '1' WHEN wr_bitslice_out1 = '1' ELSE
      '0';

  and_1_out1 <= wr_cmp2const_1_out1 AND wr_en;

  rd_address_hr_out1 <= rd_addr_unsigned(8 DOWNTO 0);

  delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_out1 <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delay_out1 <= bitwise_or_out1;
      END IF;
    END IF;
  END PROCESS delay_process;


  simple_ram_0_out1_unsigned <= unsigned(simple_ram_0_out1);

  simple_ram_1_out1_unsigned <= unsigned(simple_ram_1_out1);

  
  multiport_switch_out1 <= simple_ram_0_out1_unsigned WHEN delay_out1 = to_unsigned(16#0#, 2) ELSE
      simple_ram_1_out1_unsigned;

  rd_data <= std_logic_vector(multiport_switch_out1);

END rtl;

