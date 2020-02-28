-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_333_Zhou\hdlsrc\parallel_lht\Parallel_LHT_Kernel.vhd
-- Created: 2020-02-27 22:35:22
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Parallel_LHT_Kernel
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Kernel
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Parallel_LHT_pkg.ALL;

ENTITY Parallel_LHT_Kernel IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_tdata                      :   IN    std_logic;  -- ufix1
        s_axis_tuser                      :   IN    std_logic;
        s_axis_tlast                      :   IN    std_logic;
        m_axis_tvalid                     :   OUT   std_logic;
        m_axis_tdata                      :   OUT   std_logic;  -- ufix1
        m_axis_tuser                      :   OUT   std_logic;
        m_axis_tlast                      :   OUT   std_logic;
        hough_param                       :   OUT   vector_of_std_logic_vector9(0 TO 179)  -- ufix9 [180]
        );
END Parallel_LHT_Kernel;


ARCHITECTURE rtl OF Parallel_LHT_Kernel IS

  -- Component Declarations
  COMPONENT Hough_Kernel
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          X                               :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          Y                               :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          Rho                             :   OUT   vector_of_std_logic_vector9(0 TO 179)  -- sfix9 [180]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Hough_Kernel
    USE ENTITY work.Hough_Kernel(rtl);

  -- Signals
  SIGNAL AND_out1                         : std_logic;
  SIGNAL X_Counter_out1                   : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Y_Counter_out1                   : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Constant1_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Hough_Kernel_out1                : vector_of_std_logic_vector9(0 TO 179);  -- ufix9 [180]
  SIGNAL Hough_Kernel_out1_signed         : vector_of_signed9(0 TO 179);  -- sfix9 [180]
  SIGNAL Add1_u                           : signed(9 DOWNTO 0);  -- sfix10
  SIGNAL Add1_add_temp                    : vector_of_signed10(0 TO 179);  -- sfix10 [180]
  SIGNAL Add1_out1                        : vector_of_unsigned9(0 TO 179);  -- ufix9 [180]

BEGIN
  u_Hough_Kernel : Hough_Kernel
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              X => std_logic_vector(X_Counter_out1),  -- sfix9
              Y => std_logic_vector(Y_Counter_out1),  -- sfix9
              Rho => Hough_Kernel_out1  -- sfix9 [180]
              );

  AND_out1 <= s_axis_tvalid AND s_axis_tlast;

  -- Count limited, Signed Counter
  --  initial value   = -167
  --  step value      = 1
  --  count to value  = 166
  X_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      X_Counter_out1 <= to_signed(-16#0A7#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF s_axis_tvalid = '1' THEN 
          IF X_Counter_out1 >= to_signed(16#0A6#, 9) THEN 
            X_Counter_out1 <= to_signed(-16#0A7#, 9);
          ELSE 
            X_Counter_out1 <= X_Counter_out1 + to_signed(16#001#, 9);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS X_Counter_process;


  -- Count limited, Signed Counter
  --  initial value   = -167
  --  step value      = 1
  --  count to value  = 166
  Y_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Y_Counter_out1 <= to_signed(-16#0A7#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF AND_out1 = '1' THEN 
          IF Y_Counter_out1 >= to_signed(16#0A6#, 9) THEN 
            Y_Counter_out1 <= to_signed(-16#0A7#, 9);
          ELSE 
            Y_Counter_out1 <= Y_Counter_out1 + to_signed(16#001#, 9);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS Y_Counter_process;


  Constant1_out1 <= to_unsigned(16#ED#, 8);

  outputgen1: FOR k IN 0 TO 179 GENERATE
    Hough_Kernel_out1_signed(k) <= signed(Hough_Kernel_out1(k));
  END GENERATE;

  Add1_u <= signed(resize(Constant1_out1, 10));

  Add1_out1_gen: FOR t_0 IN 0 TO 179 GENERATE
    Add1_add_temp(t_0) <= Add1_u + resize(Hough_Kernel_out1_signed(t_0), 10);
    Add1_out1(t_0) <= unsigned(Add1_add_temp(t_0)(8 DOWNTO 0));
  END GENERATE Add1_out1_gen;


  outputgen: FOR k IN 0 TO 179 GENERATE
    hough_param(k) <= std_logic_vector(Add1_out1(k));
  END GENERATE;

  m_axis_tvalid <= s_axis_tvalid;

  m_axis_tdata <= s_axis_tdata;

  m_axis_tuser <= s_axis_tuser;

  m_axis_tlast <= s_axis_tlast;

END rtl;

