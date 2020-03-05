-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_600_Elhossini\hdlsrc\hybrid_lht\Extract_Active_Votes_block.vhd
-- Created: 2020-03-05 10:35:23
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Extract_Active_Votes_block
-- Source Path: hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Get Index and Fix Limits/Extract Active 
-- Vote
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Hybrid_LHT_pkg.ALL;

ENTITY Extract_Active_Votes_block IS
  PORT( Theta                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Index                             :   OUT   vector_of_std_logic_vector5(0 TO 5)  -- ufix5 [6]
        );
END Extract_Active_Votes_block;


ARCHITECTURE rtl OF Extract_Active_Votes_block IS

  -- Signals
  SIGNAL Theta_unsigned                   : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL Constant_out1                    : vector_of_signed3(0 TO 5);  -- sfix3 [6]
  SIGNAL Add_u                            : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Add_out1                         : vector_of_signed7(0 TO 5);  -- sfix7 [6]
  SIGNAL Add_out1_0                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Low_out1                         : std_logic;  -- ufix1
  SIGNAL Relational_1_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop1                : std_logic;
  SIGNAL Add_out1_1                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_2_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop2                : std_logic;
  SIGNAL Add_out1_2                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_3_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop3                : std_logic;
  SIGNAL Add_out1_3                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_4_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop4                : std_logic;
  SIGNAL Add_out1_4                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_5_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop5                : std_logic;
  SIGNAL Add_out1_5                       : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_6_cast                : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Relational_relop6                : std_logic;
  SIGNAL Relational_out1                  : std_logic_vector(0 TO 5);  -- boolean [6]
  SIGNAL Relational_out1_0                : std_logic;
  SIGNAL Add_out1_dtc                     : vector_of_signed8(0 TO 5);  -- int8 [6]
  SIGNAL Add_out1_dtc_0                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL nTheta_out1                      : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL Add3_v                           : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Add3_out1                        : vector_of_signed8(0 TO 5);  -- int8 [6]
  SIGNAL Add3_out1_0                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_0         : signed(7 DOWNTO 0);  -- int8
  SIGNAL High_out1                        : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL Relational1_1_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop1               : std_logic;
  SIGNAL Relational_out1_1                : std_logic;
  SIGNAL Add_out1_dtc_1                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL Add3_out1_1                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_1         : signed(7 DOWNTO 0);  -- int8
  SIGNAL Relational1_2_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop2               : std_logic;
  SIGNAL Relational_out1_2                : std_logic;
  SIGNAL Add_out1_dtc_2                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL Add3_out1_2                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_2         : signed(7 DOWNTO 0);  -- int8
  SIGNAL Relational1_3_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop3               : std_logic;
  SIGNAL Relational_out1_3                : std_logic;
  SIGNAL Add_out1_dtc_3                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL Add3_out1_3                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_3         : signed(7 DOWNTO 0);  -- int8
  SIGNAL Relational1_4_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop4               : std_logic;
  SIGNAL Relational_out1_4                : std_logic;
  SIGNAL Add_out1_dtc_4                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL Add3_out1_4                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_4         : signed(7 DOWNTO 0);  -- int8
  SIGNAL Relational1_5_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop5               : std_logic;
  SIGNAL Relational_out1_5                : std_logic;
  SIGNAL Add_out1_dtc_5                   : signed(7 DOWNTO 0);  -- int8
  SIGNAL Add3_out1_5                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL Multiport_Switch2_out1_5         : signed(7 DOWNTO 0);  -- int8
  SIGNAL Relational1_6_cast               : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL Relational1_relop6               : std_logic;
  SIGNAL Relational1_out1                 : std_logic_vector(0 TO 5);  -- boolean [6]
  SIGNAL Relational1_out1_0               : std_logic;
  SIGNAL Multiport_Switch2_out1           : vector_of_signed8(0 TO 5);  -- int8 [6]
  SIGNAL Multiport_Switch2_out1_dtc       : vector_of_signed9(0 TO 5);  -- sfix9 [6]
  SIGNAL Multiport_Switch2_out1_dtc_0     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_v                           : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1                        : vector_of_signed9(0 TO 5);  -- sfix9 [6]
  SIGNAL Relational1_out1_1               : std_logic;
  SIGNAL Multiport_Switch2_out1_dtc_1     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Relational1_out1_2               : std_logic;
  SIGNAL Multiport_Switch2_out1_dtc_2     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Relational1_out1_3               : std_logic;
  SIGNAL Multiport_Switch2_out1_dtc_3     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Relational1_out1_4               : std_logic;
  SIGNAL Multiport_Switch2_out1_dtc_4     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Relational1_out1_5               : std_logic;
  SIGNAL Multiport_Switch2_out1_dtc_5     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_0                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_0         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_1                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_1         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_2                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_2         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_3                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_3         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_4                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_4         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add1_out1_5                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1_5         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Multiport_Switch3_out1           : vector_of_signed9(0 TO 5);  -- sfix9 [6]
  SIGNAL Data_Type_Conversion_out1        : vector_of_unsigned5(0 TO 5);  -- ufix5 [6]

BEGIN
  -- Check the indices to ensure they are in the correct limits

  Theta_unsigned <= unsigned(Theta);

  Constant_out1(0) <= to_signed(-16#3#, 3);
  Constant_out1(1) <= to_signed(-16#2#, 3);
  Constant_out1(2) <= to_signed(-16#1#, 3);
  Constant_out1(3) <= to_signed(16#0#, 3);
  Constant_out1(4) <= to_signed(16#1#, 3);
  Constant_out1(5) <= to_signed(16#2#, 3);

  Add_u <= signed(resize(Theta_unsigned, 7));

  Add_out1_gen: FOR t_0 IN 0 TO 5 GENERATE
    Add_out1(t_0) <= Add_u + resize(Constant_out1(t_0), 7);
  END GENERATE Add_out1_gen;


  Add_out1_0 <= Add_out1(0);

  Low_out1 <= '0';

  Relational_1_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop1 <= '1' WHEN Add_out1_0 < Relational_1_cast ELSE
      '0';

  Add_out1_1 <= Add_out1(1);

  Relational_2_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop2 <= '1' WHEN Add_out1_1 < Relational_2_cast ELSE
      '0';

  Add_out1_2 <= Add_out1(2);

  Relational_3_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop3 <= '1' WHEN Add_out1_2 < Relational_3_cast ELSE
      '0';

  Add_out1_3 <= Add_out1(3);

  Relational_4_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop4 <= '1' WHEN Add_out1_3 < Relational_4_cast ELSE
      '0';

  Add_out1_4 <= Add_out1(4);

  Relational_5_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop5 <= '1' WHEN Add_out1_4 < Relational_5_cast ELSE
      '0';

  Add_out1_5 <= Add_out1(5);

  Relational_6_cast <= '0' & '0' & '0' & '0' & '0' & '0' & Low_out1;
  
  Relational_relop6 <= '1' WHEN Add_out1_5 < Relational_6_cast ELSE
      '0';

  Relational_out1(0) <= Relational_relop1;
  Relational_out1(1) <= Relational_relop2;
  Relational_out1(2) <= Relational_relop3;
  Relational_out1(3) <= Relational_relop4;
  Relational_out1(4) <= Relational_relop5;
  Relational_out1(5) <= Relational_relop6;

  Relational_out1_0 <= Relational_out1(0);


  Add_out1_dtc_gen: FOR ii IN 0 TO 5 GENERATE
    Add_out1_dtc(ii) <= resize(Add_out1(ii), 8);
  END GENERATE Add_out1_dtc_gen;


  Add_out1_dtc_0 <= Add_out1_dtc(0);

  nTheta_out1 <= to_unsigned(16#12#, 5);

  Add3_v <= signed(resize(nTheta_out1, 8));

  Add3_out1_gen: FOR t_01 IN 0 TO 5 GENERATE
    Add3_out1(t_01) <= resize(Add_out1(t_01), 8) + Add3_v;
  END GENERATE Add3_out1_gen;


  Add3_out1_0 <= Add3_out1(0);

  
  Multiport_Switch2_out1_0 <= Add_out1_dtc_0 WHEN Relational_out1_0 = '0' ELSE
      Add3_out1_0;

  High_out1 <= to_unsigned(16#11#, 5);

  Relational1_1_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop1 <= '1' WHEN Multiport_Switch2_out1_0 > Relational1_1_cast ELSE
      '0';

  Relational_out1_1 <= Relational_out1(1);

  Add_out1_dtc_1 <= Add_out1_dtc(1);

  Add3_out1_1 <= Add3_out1(1);

  
  Multiport_Switch2_out1_1 <= Add_out1_dtc_1 WHEN Relational_out1_1 = '0' ELSE
      Add3_out1_1;

  Relational1_2_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop2 <= '1' WHEN Multiport_Switch2_out1_1 > Relational1_2_cast ELSE
      '0';

  Relational_out1_2 <= Relational_out1(2);

  Add_out1_dtc_2 <= Add_out1_dtc(2);

  Add3_out1_2 <= Add3_out1(2);

  
  Multiport_Switch2_out1_2 <= Add_out1_dtc_2 WHEN Relational_out1_2 = '0' ELSE
      Add3_out1_2;

  Relational1_3_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop3 <= '1' WHEN Multiport_Switch2_out1_2 > Relational1_3_cast ELSE
      '0';

  Relational_out1_3 <= Relational_out1(3);

  Add_out1_dtc_3 <= Add_out1_dtc(3);

  Add3_out1_3 <= Add3_out1(3);

  
  Multiport_Switch2_out1_3 <= Add_out1_dtc_3 WHEN Relational_out1_3 = '0' ELSE
      Add3_out1_3;

  Relational1_4_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop4 <= '1' WHEN Multiport_Switch2_out1_3 > Relational1_4_cast ELSE
      '0';

  Relational_out1_4 <= Relational_out1(4);

  Add_out1_dtc_4 <= Add_out1_dtc(4);

  Add3_out1_4 <= Add3_out1(4);

  
  Multiport_Switch2_out1_4 <= Add_out1_dtc_4 WHEN Relational_out1_4 = '0' ELSE
      Add3_out1_4;

  Relational1_5_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop5 <= '1' WHEN Multiport_Switch2_out1_4 > Relational1_5_cast ELSE
      '0';

  Relational_out1_5 <= Relational_out1(5);

  Add_out1_dtc_5 <= Add_out1_dtc(5);

  Add3_out1_5 <= Add3_out1(5);

  
  Multiport_Switch2_out1_5 <= Add_out1_dtc_5 WHEN Relational_out1_5 = '0' ELSE
      Add3_out1_5;

  Relational1_6_cast <= signed(resize(High_out1, 8));
  
  Relational1_relop6 <= '1' WHEN Multiport_Switch2_out1_5 > Relational1_6_cast ELSE
      '0';

  Relational1_out1(0) <= Relational1_relop1;
  Relational1_out1(1) <= Relational1_relop2;
  Relational1_out1(2) <= Relational1_relop3;
  Relational1_out1(3) <= Relational1_relop4;
  Relational1_out1(4) <= Relational1_relop5;
  Relational1_out1(5) <= Relational1_relop6;

  Relational1_out1_0 <= Relational1_out1(0);

  Multiport_Switch2_out1(0) <= Multiport_Switch2_out1_0;
  Multiport_Switch2_out1(1) <= Multiport_Switch2_out1_1;
  Multiport_Switch2_out1(2) <= Multiport_Switch2_out1_2;
  Multiport_Switch2_out1(3) <= Multiport_Switch2_out1_3;
  Multiport_Switch2_out1(4) <= Multiport_Switch2_out1_4;
  Multiport_Switch2_out1(5) <= Multiport_Switch2_out1_5;


  Multiport_Switch2_out1_dtc_gen: FOR ii1 IN 0 TO 5 GENERATE
    Multiport_Switch2_out1_dtc(ii1) <= resize(Multiport_Switch2_out1(ii1), 9);
  END GENERATE Multiport_Switch2_out1_dtc_gen;


  Multiport_Switch2_out1_dtc_0 <= Multiport_Switch2_out1_dtc(0);

  Add1_v <= signed(resize(nTheta_out1, 9));

  Add1_out1_gen: FOR t_02 IN 0 TO 5 GENERATE
    Add1_out1(t_02) <= resize(Multiport_Switch2_out1(t_02), 9) - Add1_v;
  END GENERATE Add1_out1_gen;


  Relational1_out1_1 <= Relational1_out1(1);

  Multiport_Switch2_out1_dtc_1 <= Multiport_Switch2_out1_dtc(1);

  Relational1_out1_2 <= Relational1_out1(2);

  Multiport_Switch2_out1_dtc_2 <= Multiport_Switch2_out1_dtc(2);

  Relational1_out1_3 <= Relational1_out1(3);

  Multiport_Switch2_out1_dtc_3 <= Multiport_Switch2_out1_dtc(3);

  Relational1_out1_4 <= Relational1_out1(4);

  Multiport_Switch2_out1_dtc_4 <= Multiport_Switch2_out1_dtc(4);

  Relational1_out1_5 <= Relational1_out1(5);

  Multiport_Switch2_out1_dtc_5 <= Multiport_Switch2_out1_dtc(5);

  Add1_out1_0 <= Add1_out1(0);

  
  Multiport_Switch3_out1_0 <= Multiport_Switch2_out1_dtc_0 WHEN Relational1_out1_0 = '0' ELSE
      Add1_out1_0;

  Add1_out1_1 <= Add1_out1(1);

  
  Multiport_Switch3_out1_1 <= Multiport_Switch2_out1_dtc_1 WHEN Relational1_out1_1 = '0' ELSE
      Add1_out1_1;

  Add1_out1_2 <= Add1_out1(2);

  
  Multiport_Switch3_out1_2 <= Multiport_Switch2_out1_dtc_2 WHEN Relational1_out1_2 = '0' ELSE
      Add1_out1_2;

  Add1_out1_3 <= Add1_out1(3);

  
  Multiport_Switch3_out1_3 <= Multiport_Switch2_out1_dtc_3 WHEN Relational1_out1_3 = '0' ELSE
      Add1_out1_3;

  Add1_out1_4 <= Add1_out1(4);

  
  Multiport_Switch3_out1_4 <= Multiport_Switch2_out1_dtc_4 WHEN Relational1_out1_4 = '0' ELSE
      Add1_out1_4;

  Add1_out1_5 <= Add1_out1(5);

  
  Multiport_Switch3_out1_5 <= Multiport_Switch2_out1_dtc_5 WHEN Relational1_out1_5 = '0' ELSE
      Add1_out1_5;

  Multiport_Switch3_out1(0) <= Multiport_Switch3_out1_0;
  Multiport_Switch3_out1(1) <= Multiport_Switch3_out1_1;
  Multiport_Switch3_out1(2) <= Multiport_Switch3_out1_2;
  Multiport_Switch3_out1(3) <= Multiport_Switch3_out1_3;
  Multiport_Switch3_out1(4) <= Multiport_Switch3_out1_4;
  Multiport_Switch3_out1(5) <= Multiport_Switch3_out1_5;


  Data_Type_Conversion_out1_gen: FOR ii2 IN 0 TO 5 GENERATE
    Data_Type_Conversion_out1(ii2) <= unsigned(Multiport_Switch3_out1(ii2)(4 DOWNTO 0));
  END GENERATE Data_Type_Conversion_out1_gen;


  outputgen: FOR k IN 0 TO 5 GENERATE
    Index(k) <= std_logic_vector(Data_Type_Conversion_out1(k));
  END GENERATE;

END rtl;

