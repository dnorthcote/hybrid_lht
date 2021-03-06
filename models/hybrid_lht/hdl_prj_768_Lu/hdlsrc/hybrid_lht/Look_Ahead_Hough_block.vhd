-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_768_Lu\hdlsrc\hybrid_lht\Look_Ahead_Hough_block.vhd
-- Created: 2020-03-05 10:20:19
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Look_Ahead_Hough_block
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Hough Kernel/Look Ahead Hough
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Look_Ahead_Hough_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Y                                 :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
        eol                               :   IN    std_logic;
        ysin                              :   OUT   vector_of_std_logic_vector10(0 TO 101)  -- sfix10 [102]
        );
END Look_Ahead_Hough_block;


ARCHITECTURE rtl OF Look_Ahead_Hough_block IS

  -- Component Declarations
  COMPONENT Look_Ahead_Hough
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Y                               :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
          eol                             :   IN    std_logic;
          ysin                            :   OUT   vector_of_std_logic_vector10(0 TO 101)  -- sfix10 [102]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Look_Ahead_Hough
    USE ENTITY work.Look_Ahead_Hough(rtl);

  -- Signals
  SIGNAL Look_Ahead_Hough_out1            : vector_of_std_logic_vector10(0 TO 101);  -- ufix10 [102]

BEGIN
  u_Look_Ahead_Hough : Look_Ahead_Hough
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Y => Y,  -- sfix10
              eol => eol,
              ysin => Look_Ahead_Hough_out1  -- sfix10 [102]
              );

  ysin <= Look_Ahead_Hough_out1;

END rtl;

