-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_1080p\hdlsrc\parallel_lht\Hough_Kernel.vhd
-- Created: 2020-02-27 21:38:20
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Hough_Kernel
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Kernel/Hough Kernel
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Parallel_LHT_pkg.ALL;

ENTITY Hough_Kernel IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        X                                 :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
        Y                                 :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
        Rho                               :   OUT   vector_of_std_logic_vector12(0 TO 179)  -- sfix12 [180]
        );
END Hough_Kernel;


ARCHITECTURE rtl OF Hough_Kernel IS

  -- Component Declarations
  COMPONENT Hough_Kernel_Symmetric_Look_Ahead
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          X                               :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
          Y                               :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
          Rho                             :   OUT   vector_of_std_logic_vector12(0 TO 179)  -- sfix12 [180]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Hough_Kernel_Symmetric_Look_Ahead
    USE ENTITY work.Hough_Kernel_Symmetric_Look_Ahead(rtl);

  -- Signals
  SIGNAL Hough_Kernel_Symmetric_Look_Ahead_out1 : vector_of_std_logic_vector12(0 TO 179);  -- ufix12 [180]

BEGIN
  u_Hough_Kernel_Symmetric_Look_Ahead : Hough_Kernel_Symmetric_Look_Ahead
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              X => X,  -- sfix11
              Y => Y,  -- sfix11
              Rho => Hough_Kernel_Symmetric_Look_Ahead_out1  -- sfix12 [180]
              );

  Rho <= Hough_Kernel_Symmetric_Look_Ahead_out1;

END rtl;

