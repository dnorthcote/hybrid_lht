-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_333_Zhou\hdlsrc\hybrid_lht\Register_Bank.vhd
-- Created: 2020-03-05 11:32:09
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Register_Bank
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Hough Kernel/Look Ahead Hough/Look 
-- Ahead Hough Symmetric/Register Ban
-- Hierarchy Level: 6
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Register_Bank IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Data_In                           :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
        Write_Enable                      :   IN    std_logic;
        Data_Out                          :   OUT   std_logic_vector(8 DOWNTO 0)  -- sfix9
        );
END Register_Bank;


ARCHITECTURE rtl OF Register_Bank IS

  -- Signals
  SIGNAL Data_In_signed                   : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Unit_Delay_Enabled_Synchronous_out1 : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Unit_Delay_Enabled_Synchronous_ectrl : signed(8 DOWNTO 0);  -- sfix9

BEGIN
  Data_In_signed <= signed(Data_In);

  
  Unit_Delay_Enabled_Synchronous_ectrl <= Unit_Delay_Enabled_Synchronous_out1 WHEN Write_Enable = '0' ELSE
      Data_In_signed;

  Unit_Delay_Enabled_Synchronous_lowered_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous_out1 <= to_signed(16#000#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay_Enabled_Synchronous_out1 <= Unit_Delay_Enabled_Synchronous_ectrl;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_Synchronous_lowered_process;


  Data_Out <= std_logic_vector(Unit_Delay_Enabled_Synchronous_out1);

END rtl;

