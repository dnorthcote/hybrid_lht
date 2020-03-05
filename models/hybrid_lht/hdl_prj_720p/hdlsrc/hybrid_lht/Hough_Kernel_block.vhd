-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_720p\hdlsrc\hybrid_lht\Hough_Kernel_block.vhd
-- Created: 2020-03-05 09:20:25
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Hough_Kernel_block
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Hough Kernel
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Hough_Kernel_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Edge_rsvd                         :   IN    std_logic;  -- ufix1
        X                                 :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
        Y                                 :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
        Index                             :   IN    vector_of_std_logic_vector8(0 TO 59);  -- uint8 [60]
        vEdge                             :   OUT   std_logic;  -- ufix1
        Rho                               :   OUT   vector_of_std_logic_vector11(0 TO 59)  -- ufix11 [60]
        );
END Hough_Kernel_block;


ARCHITECTURE rtl OF Hough_Kernel_block IS

  -- Component Declarations
  COMPONENT Look_Ahead_Hough
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Y                               :   IN    std_logic_vector(9 DOWNTO 0);  -- sfix10
          eol                             :   IN    std_logic;
          ysin                            :   OUT   vector_of_std_logic_vector10(0 TO 179)  -- sfix10 [180]
          );
  END COMPONENT;

  COMPONENT Hough_Kernel
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          X                               :   IN    std_logic_vector(10 DOWNTO 0);  -- sfix11
          Y                               :   IN    vector_of_std_logic_vector10(0 TO 179);  -- sfix10 [180]
          Index                           :   IN    vector_of_std_logic_vector8(0 TO 59);  -- uint8 [60]
          Rho                             :   OUT   vector_of_std_logic_vector11(0 TO 59)  -- sfix11 [60]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Look_Ahead_Hough
    USE ENTITY work.Look_Ahead_Hough(rtl);

  FOR ALL : Hough_Kernel
    USE ENTITY work.Hough_Kernel(rtl);

  -- Signals
  SIGNAL X_signed                         : signed(10 DOWNTO 0);  -- sfix11
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Look_Ahead_Hough_out1            : vector_of_std_logic_vector10(0 TO 179);  -- ufix10 [180]
  SIGNAL Hough_Kernel_out1                : vector_of_std_logic_vector11(0 TO 59);  -- ufix11 [60]
  SIGNAL Hough_Kernel_out1_signed         : vector_of_signed11(0 TO 59);  -- sfix11 [60]
  SIGNAL Constant_out1                    : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Add1_v                           : signed(11 DOWNTO 0);  -- sfix12
  SIGNAL Add1_add_temp                    : vector_of_signed12(0 TO 59);  -- sfix12 [60]
  SIGNAL Add1_out1                        : vector_of_unsigned11(0 TO 59);  -- ufix11 [60]

BEGIN
  u_Look_Ahead_Hough : Look_Ahead_Hough
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Y => Y,  -- sfix10
              eol => Compare_To_Constant1_out1,
              ysin => Look_Ahead_Hough_out1  -- sfix10 [180]
              );

  u_Hough_Kernel : Hough_Kernel
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              X => X,  -- sfix11
              Y => Look_Ahead_Hough_out1,  -- sfix10 [180]
              Index => Index,  -- uint8 [60]
              Rho => Hough_Kernel_out1  -- sfix11 [60]
              );

  X_signed <= signed(X);

  
  Compare_To_Constant1_out1 <= '1' WHEN X_signed = to_signed(16#27F#, 11) ELSE
      '0';

  outputgen1: FOR k IN 0 TO 59 GENERATE
    Hough_Kernel_out1_signed(k) <= signed(Hough_Kernel_out1(k));
  END GENERATE;

  Constant_out1 <= to_unsigned(16#2DF#, 10);

  Add1_v <= signed(resize(Constant_out1, 12));

  Add1_out1_gen: FOR t_0 IN 0 TO 59 GENERATE
    Add1_add_temp(t_0) <= resize(Hough_Kernel_out1_signed(t_0), 12) + Add1_v;
    Add1_out1(t_0) <= unsigned(Add1_add_temp(t_0)(10 DOWNTO 0));
  END GENERATE Add1_out1_gen;


  outputgen: FOR k IN 0 TO 59 GENERATE
    Rho(k) <= std_logic_vector(Add1_out1(k));
  END GENERATE;

  vEdge <= Edge_rsvd;

END rtl;

