-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_768p\hdlsrc\hybrid_lht\GetShift1.vhd
-- Created: 2020-03-05 09:47:46
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: GetShift1
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Get Index and Fix Limits/GetShift1
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY GetShift1 IS
  PORT( Theta                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        Shift                             :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
        );
END GetShift1;


ARCHITECTURE rtl OF GetShift1 IS

  -- Signals
  SIGNAL Theta_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Constant_out1                    : vector_of_unsigned8(0 TO 2);  -- uint8 [3]
  SIGNAL Constant_out1_0                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL Constant_out1_1                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Relational_Operator_relop2       : std_logic;
  SIGNAL Constant_out1_2                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Relational_Operator_relop3       : std_logic;
  SIGNAL Relational_Operator_out1         : std_logic_vector(0 TO 2);  -- boolean [3]
  SIGNAL Add_add_cast                     : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Add_add_cast_1                   : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Add_add_temp                     : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Add_add_cast_2                   : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Add_out1                         : unsigned(1 DOWNTO 0);  -- ufix2

BEGIN
  Theta_unsigned <= unsigned(Theta);

  Constant_out1(0) <= to_unsigned(16#3C#, 8);
  Constant_out1(1) <= to_unsigned(16#78#, 8);
  Constant_out1(2) <= to_unsigned(16#B4#, 8);

  Constant_out1_0 <= Constant_out1(0);

  
  Relational_Operator_relop1 <= '1' WHEN Theta_unsigned >= Constant_out1_0 ELSE
      '0';

  Constant_out1_1 <= Constant_out1(1);

  
  Relational_Operator_relop2 <= '1' WHEN Theta_unsigned >= Constant_out1_1 ELSE
      '0';

  Constant_out1_2 <= Constant_out1(2);

  
  Relational_Operator_relop3 <= '1' WHEN Theta_unsigned >= Constant_out1_2 ELSE
      '0';

  Relational_Operator_out1(0) <= Relational_Operator_relop1;
  Relational_Operator_out1(1) <= Relational_Operator_relop2;
  Relational_Operator_out1(2) <= Relational_Operator_relop3;

  Add_add_cast <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Relational_Operator_out1(0);
  Add_add_cast_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Relational_Operator_out1(1);
  Add_add_temp <= Add_add_cast + Add_add_cast_1;
  Add_add_cast_2 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & Relational_Operator_out1(2);
  Add_out1 <= resize(Add_add_temp + Add_add_cast_2, 2);

  Shift <= std_logic_vector(Add_out1);

END rtl;

