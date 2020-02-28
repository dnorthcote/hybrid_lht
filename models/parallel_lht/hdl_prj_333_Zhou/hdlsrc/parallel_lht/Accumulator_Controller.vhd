-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_333_Zhou\hdlsrc\parallel_lht\Accumulator_Controller.vhd
-- Created: 2020-02-27 22:35:22
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Accumulator_Controller
-- Source Path: parallel_lht/Parallel LHT/Parallel LHT Accumulator/Accumulator Controller
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Accumulator_Controller IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        sof                               :   IN    std_logic;
        eof                               :   IN    std_logic;
        ntheta                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        nrho                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        mode                              :   OUT   std_logic;
        read_rsvd                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        clear                             :   OUT   std_logic;
        index                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        valid                             :   OUT   std_logic
        );
END Accumulator_Controller;


ARCHITECTURE rtl OF Accumulator_Controller IS

  -- Signals
  SIGNAL ntheta_unsigned                  : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL nrho_unsigned                    : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL read_tmp                         : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL index_tmp                        : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL current_state                    : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL rho_counter                      : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL theta_counter                    : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL current_state_next               : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL rho_counter_next                 : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL theta_counter_next               : unsigned(15 DOWNTO 0);  -- ufix16

BEGIN
  ntheta_unsigned <= unsigned(ntheta);

  nrho_unsigned <= unsigned(nrho);

  Accumulator_Controller_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= to_unsigned(16#0#, 2);
      rho_counter <= to_unsigned(16#0000#, 16);
      theta_counter <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        current_state <= current_state_next;
        rho_counter <= rho_counter_next;
        theta_counter <= theta_counter_next;
      END IF;
    END IF;
  END PROCESS Accumulator_Controller_1_process;

  Accumulator_Controller_1_output : PROCESS (current_state, eof, nrho_unsigned, ntheta_unsigned, rho_counter, sof,
       theta_counter)
    VARIABLE add_temp : unsigned(16 DOWNTO 0);
    VARIABLE add_temp_0 : unsigned(16 DOWNTO 0);
    VARIABLE add_temp_1 : unsigned(16 DOWNTO 0);
  BEGIN
    theta_counter_next <= theta_counter;
    current_state_next <= current_state;
    CASE current_state IS
      WHEN "00" =>
        rho_counter_next <= to_unsigned(16#0000#, 16);
        theta_counter_next <= to_unsigned(16#0000#, 16);
        clear <= '0';
        read_tmp <= to_unsigned(16#0000#, 16);
        index_tmp <= to_unsigned(16#0000#, 16);
        valid <= '0';
        IF sof = '1' THEN 
          mode <= '1';
          current_state_next <= to_unsigned(16#1#, 2);
        ELSE 
          mode <= '0';
          current_state_next <= to_unsigned(16#0#, 2);
        END IF;
      WHEN "01" =>
        rho_counter_next <= to_unsigned(16#0000#, 16);
        theta_counter_next <= to_unsigned(16#0000#, 16);
        mode <= '1';
        clear <= '0';
        valid <= '0';
        read_tmp <= to_unsigned(16#0000#, 16);
        index_tmp <= to_unsigned(16#0000#, 16);
        IF eof = '1' THEN 
          current_state_next <= to_unsigned(16#2#, 2);
        ELSE 
          current_state_next <= to_unsigned(16#1#, 2);
        END IF;
      WHEN "10" =>
        mode <= '0';
        clear <= '0';
        read_tmp <= rho_counter;
        index_tmp <= theta_counter;
        valid <= '1';
        IF (theta_counter >= nrho_unsigned) AND (rho_counter >= ntheta_unsigned) THEN 
          rho_counter_next <= to_unsigned(16#0000#, 16);
          theta_counter_next <= to_unsigned(16#0000#, 16);
          current_state_next <= to_unsigned(16#3#, 2);
        ELSIF rho_counter >= nrho_unsigned THEN 
          add_temp_1 := resize(theta_counter, 17) + to_unsigned(16#00001#, 17);
          IF add_temp_1(16) /= '0' THEN 
            theta_counter_next <= X"FFFF";
          ELSE 
            theta_counter_next <= add_temp_1(15 DOWNTO 0);
          END IF;
          rho_counter_next <= to_unsigned(16#0000#, 16);
          current_state_next <= to_unsigned(16#2#, 2);
        ELSE 
          add_temp_0 := resize(rho_counter, 17) + to_unsigned(16#00001#, 17);
          IF add_temp_0(16) /= '0' THEN 
            rho_counter_next <= X"FFFF";
          ELSE 
            rho_counter_next <= add_temp_0(15 DOWNTO 0);
          END IF;
          current_state_next <= to_unsigned(16#2#, 2);
        END IF;
      WHEN "11" =>
        mode <= '0';
        clear <= '1';
        valid <= '0';
        read_tmp <= rho_counter;
        index_tmp <= theta_counter;
        IF rho_counter >= nrho_unsigned THEN 
          rho_counter_next <= to_unsigned(16#0000#, 16);
          theta_counter_next <= to_unsigned(16#0000#, 16);
          current_state_next <= to_unsigned(16#0#, 2);
        ELSE 
          add_temp := resize(rho_counter, 17) + to_unsigned(16#00001#, 17);
          IF add_temp(16) /= '0' THEN 
            rho_counter_next <= X"FFFF";
          ELSE 
            rho_counter_next <= add_temp(15 DOWNTO 0);
          END IF;
          theta_counter_next <= to_unsigned(16#0000#, 16);
          current_state_next <= to_unsigned(16#3#, 2);
        END IF;
      WHEN OTHERS => 
        rho_counter_next <= to_unsigned(16#0000#, 16);
        theta_counter_next <= to_unsigned(16#0000#, 16);
        mode <= '0';
        clear <= '0';
        valid <= '0';
        read_tmp <= to_unsigned(16#0000#, 16);
        index_tmp <= to_unsigned(16#0000#, 16);
        current_state_next <= to_unsigned(16#0#, 2);
    END CASE;
  END PROCESS Accumulator_Controller_1_output;


  read_rsvd <= std_logic_vector(read_tmp);

  index <= std_logic_vector(index_tmp);

END rtl;

