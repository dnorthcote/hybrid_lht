-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_720p\hdlsrc\hybrid_lht\Hybrid_LHT_pkg.vhd
-- Created: 2020-03-05 09:20:25
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE Hybrid_LHT_pkg IS
  TYPE vector_of_std_logic_vector6 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(5 DOWNTO 0);
  TYPE vector_of_std_logic_vector11 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(10 DOWNTO 0);
  TYPE vector_of_unsigned11 IS ARRAY (NATURAL RANGE <>) OF unsigned(10 DOWNTO 0);
  TYPE vector_of_unsigned16 IS ARRAY (NATURAL RANGE <>) OF unsigned(15 DOWNTO 0);
  TYPE vector_of_unsigned6 IS ARRAY (NATURAL RANGE <>) OF unsigned(5 DOWNTO 0);
  TYPE vector_of_unsigned8 IS ARRAY (NATURAL RANGE <>) OF unsigned(7 DOWNTO 0);
  TYPE vector_of_std_logic_vector8 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(7 DOWNTO 0);
  TYPE vector_of_signed6 IS ARRAY (NATURAL RANGE <>) OF signed(5 DOWNTO 0);
  TYPE vector_of_signed10 IS ARRAY (NATURAL RANGE <>) OF signed(9 DOWNTO 0);
  TYPE vector_of_signed11 IS ARRAY (NATURAL RANGE <>) OF signed(10 DOWNTO 0);
  TYPE vector_of_signed12 IS ARRAY (NATURAL RANGE <>) OF signed(11 DOWNTO 0);
  TYPE vector_of_std_logic_vector2 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(1 DOWNTO 0);
  TYPE vector_of_unsigned2 IS ARRAY (NATURAL RANGE <>) OF unsigned(1 DOWNTO 0);
  TYPE vector_of_std_logic_vector10 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(9 DOWNTO 0);
  TYPE vector_of_signed16 IS ARRAY (NATURAL RANGE <>) OF signed(15 DOWNTO 0);
  TYPE vector_of_signed27 IS ARRAY (NATURAL RANGE <>) OF signed(26 DOWNTO 0);
END Hybrid_LHT_pkg;

