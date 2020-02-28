-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_720p\hdlsrc\parallel_lht\Hough_Kernel_Symmetric_Look_Ahead.vhd
-- Created: 2020-02-27 21:50:44
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Hough_Kernel_Symmetric_Look_Ahead
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Kernel/Hough Kernel/Hough Kernel Symmetric Look Ahead
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Parallel_LHT_pkg.ALL;

ENTITY Hough_Kernel_Symmetric_Look_Ahead IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        X                                 :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
        Y                                 :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
        Rho                               :   OUT   vector_of_std_logic_vector11(0 TO 179)  -- sfix11 [180]
        );
END Hough_Kernel_Symmetric_Look_Ahead;


ARCHITECTURE rtl OF Hough_Kernel_Symmetric_Look_Ahead IS

  -- Component Declarations
  COMPONENT Look_Ahead_Hough
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Y                               :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
          eol                             :   IN    std_logic;
          ysin                            :   OUT   vector_of_std_logic_vector10(0 TO 90)  -- sfix10 [91]
          );
  END COMPONENT;

  COMPONENT Hough_Kernel_Symmetric
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          X                               :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
          ysin                            :   IN    vector_of_std_logic_vector10(0 TO 90);  -- sfix10 [91]
          Rho                             :   OUT   vector_of_std_logic_vector11(0 TO 179)  -- sfix11 [180]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Look_Ahead_Hough
    USE ENTITY work.Look_Ahead_Hough(rtl);

  FOR ALL : Hough_Kernel_Symmetric
    USE ENTITY work.Hough_Kernel_Symmetric(rtl);

  -- Signals
  SIGNAL X_signed                         : signed(10 DOWNTO 0);  -- sfix11
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Look_Ahead_Hough_out1            : vector_of_std_logic_vector10(0 TO 90);  -- ufix10 [91]
  SIGNAL Hough_Kernel_Symmetric_out1      : vector_of_std_logic_vector11(0 TO 179);  -- ufix11 [180]

BEGIN
  u_Look_Ahead_Hough : Look_Ahead_Hough
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Y => Y,  -- sfix10
              eol => Compare_To_Constant1_out1,
              ysin => Look_Ahead_Hough_out1  -- sfix10 [91]
              );

  u_Hough_Kernel_Symmetric : Hough_Kernel_Symmetric
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              X => X,  -- sfix11
              ysin => Look_Ahead_Hough_out1,  -- sfix10 [91]
              Rho => Hough_Kernel_Symmetric_out1  -- sfix11 [180]
              );

  X_signed <= signed(X);

  
  Compare_To_Constant1_out1 <= '1' WHEN X_signed = to_signed(16#27F#, 11) ELSE
      '0';

  Rho <= Hough_Kernel_Symmetric_out1;

END rtl;

