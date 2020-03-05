-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_600_Elhossini\hdlsrc\hybrid_lht\Get_Index_and_Fix_Limits.vhd
-- Created: 2020-03-05 10:35:23
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Get_Index_and_Fix_Limits
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Get Index and Fix Limits
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Get_Index_and_Fix_Limits IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Theta                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Index                             :   OUT   vector_of_std_logic_vector8(0 TO 5);  -- uint8 [6]
        Shift                             :   OUT   vector_of_std_logic_vector6(0 TO 5)  -- ufix6 [6]
        );
END Get_Index_and_Fix_Limits;


ARCHITECTURE rtl OF Get_Index_and_Fix_Limits IS

  -- Component Declarations
  COMPONENT Extract_Active_Votes_block
    PORT( Theta                           :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          Index                           :   OUT   vector_of_std_logic_vector5(0 TO 5)  -- ufix5 [6]
          );
  END COMPONENT;

  COMPONENT GetShift1
    PORT( Theta                           :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          Shift                           :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Extract_Active_Votes_block
    USE ENTITY work.Extract_Active_Votes_block(rtl);

  FOR ALL : GetShift1
    USE ENTITY work.GetShift1(rtl);

  -- Signals
  SIGNAL Extract_Active_Votes_out1        : vector_of_std_logic_vector5(0 TO 5);  -- ufix5 [6]
  SIGNAL Extract_Active_Votes_out1_unsigned : vector_of_unsigned5(0 TO 5);  -- ufix5 [6]
  SIGNAL Data_Type_Conversion_out1        : vector_of_unsigned8(0 TO 5);  -- uint8 [6]
  SIGNAL GetShift1_out1                   : vector_of_std_logic_vector2(0 TO 5);  -- ufix2 [6]
  SIGNAL GetShift1_out1_unsigned          : vector_of_unsigned2(0 TO 5);  -- ufix2 [6]
  SIGNAL kconst                           : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Gain_out1                        : vector_of_unsigned6(0 TO 5);  -- ufix6 [6]
  SIGNAL Gain_out1_1                      : vector_of_unsigned6(0 TO 5);  -- ufix6 [6]

BEGIN
  u_Extract_Active_Votes : Extract_Active_Votes_block
    PORT MAP( Theta => Theta,  -- ufix5
              Index => Extract_Active_Votes_out1  -- ufix5 [6]
              );

  outputgen3: FOR k1 IN 0 TO 5 GENERATE
    Extract_Active_Votes_out1_unsigned(k1) <= unsigned(Extract_Active_Votes_out1(k1));
  END GENERATE;


  Data_Type_Conversion_out1_gen: FOR ii IN 0 TO 5 GENERATE
    Data_Type_Conversion_out1(ii) <= resize(Extract_Active_Votes_out1_unsigned(ii), 8);
  END GENERATE Data_Type_Conversion_out1_gen;


  outputgen2: FOR k1 IN 0 TO 5 GENERATE
    Index(k1) <= std_logic_vector(Data_Type_Conversion_out1(k1));
  END GENERATE;

  GEN_LABEL: FOR k IN 0 TO 5 GENERATE
    u_GetShift1 : GetShift1
      PORT MAP( Theta => Extract_Active_Votes_out1(k),  -- ufix5
                Shift => GetShift1_out1(k)  -- ufix2
                );
  END GENERATE;

  outputgen1: FOR k IN 0 TO 5 GENERATE
    GetShift1_out1_unsigned(k) <= unsigned(GetShift1_out1(k));
  END GENERATE;

  kconst <= to_unsigned(16#0A#, 6);


  Gain_out1_gen: FOR t_0 IN 0 TO 5 GENERATE
    Gain_out1(t_0) <= resize(GetShift1_out1_unsigned(t_0) * kconst, 6);
  END GENERATE Gain_out1_gen;


  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Gain_out1_1 <= (OTHERS => to_unsigned(16#00#, 6));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Gain_out1_1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  outputgen: FOR k IN 0 TO 5 GENERATE
    Shift(k) <= std_logic_vector(Gain_out1_1(k));
  END GENERATE;

END rtl;

