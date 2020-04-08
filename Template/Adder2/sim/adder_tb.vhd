----------------------------------------------------------------------------------
--! 
--! @file       adder_tb_pkg.vhd
--!
--! @brief      Testbench for a simple 1-bit adder \ref FullAdd
--! @details    Uses a RAM for Input and another RAM for expected output.
--!             Implements Adder and compares output with Expected Output Ram.
--!             Since this design takes one full clock cycle to output the correct
--!             answer, an FSM was built to ensure stimulus signal would be stable
--!             long enough.
--!
--! @author     Guilherme Shimabuko 
--! 
--!
--! @version 1.0
--!
--! @date 2020-04-07
--!
--!     Version History
--!
--!     Version     Date            Author              Changes
--!
--!     1.1         2020-03-19      GSHIMABUKO          Block finished and tested
--!
--!     1.0         2020-03-18      GSHIMABUKO          Block Created
--! 
--! @pre        FullAdd Input_ROM Output_ROM adder_pkg       
--!
--! @copyright  Copyright (c) 2020 Shima's Digital Hardware
--!
--!     Redistribution and use in source and binary forms, with or without
--!     modification, are permitted provided that the following conditions
--!     are met:
--!     
--!     * Redistributions of source code must retain the above copyright
--!       notice, this list of conditions and the following disclaimer.
--!
--!     * Redistributions in binary form must reproduce the above copyright
--!       notice, this list of conditions and the following disclaimer in the
--!       documentation and/or other materials provided with the distribution.
--!
--!     * Neither the name of Shima's DIgital Hardware  nor the names of its
--!       contributors may be used to endorse or promote products
--!       derived from this software without specific prior written permission.
--!
--!     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
--!     IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
--!     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTI-
--!     CULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SHIMA'S DIGITAL HARDWARE
--!     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
--!     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
--!     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
--!     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
--!     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
--!     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
--!     THE POSSIBILITY OF SUCH DAMAGE.
--!
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use work.adder_tb_pkg.ALL;

-- Entity ------------------------------------------------------------------------
--! @brief      Testbench for a simple 1-bit adder \ref FullAdd
--! @details    Uses a RAM for Input and another RAM for expected output.
--!             Implements Adder and compares output with Expected Output Ram.
----------------------------------------------------------------------------------
entity adder_tb is
end entity adder_tb;

-- Architecture ------------------------------------------------------------------
--! @brief  Implements testbench for the 1-bit full adder from \ref FullAdd
--!
--! @details 
--!
--!         Instantiates \ref Input_ROM to stimulate inputs from \ref FullAdd.
--!
--!         Instantiates \ref Output_ROM to provide expected outputs
--!
--!         Instantates \ref FullAdd, stimulates inputs with \ref Input_ROM and compare
--!         outputs with \ref Output_ROM
--!         
--!         S0_START just resets test signals to proper positions
--!
--!         S1_STIM stimulates the adder
--!
--!         S2_COMP always happens one clock cycle after S1_STIM, giving adder
--!         time to stabilize outputs before comparison
--!
--!         S3_DONE once all data from output ROM is compared, finish sim and
--!         shows wheter or not design has been approved.
----------------------------------------------------------------------------------

architecture Behavioral of adder_tb is
    component FullAdd is
        port(
            -- Inputs ------------------------------------------------------------
            Clk:    in std_logic;
            A:      in std_logic;
            B:      in std_logic;
            Cin:    in std_logic;
            -- Outputs -----------------------------------------------------------
            Sum:    out std_logic;
            Cout:   out std_logic
        );
    end component FullAdd;

    component Input_Rom is
        port(
                -- Inputs --------------------------------------------------------
                address_in: in integer range 7 downto 0;
                -- Outputs -------------------------------------------------------
                A_out:      out std_logic;
                B_out:      out std_logic;
                C_out:      out std_logic
        );
    end component Input_Rom;
    component Output_Rom is
        port(
                -- Inputs --------------------------------------------------------
                address_in: in integer range 7 downto 0;
                -- Outputs -------------------------------------------------------
                Sum_out:    out std_logic;
                C_out:      out std_logic
        );
    end component Output_ROM;

    signal s_clk:               std_logic := '0';
    signal s_A:                 std_logic := '0';
    signal s_B:                 std_logic := '0';
    signal s_Cin:               std_logic := '0';
    signal s_Sum:               std_logic := '0';
    signal s_Cout:              std_logic := '0';
    signal s_Exp_Sum:           std_logic := '0';
    signal s_Exp_Cout:          std_logic := '0';
    signal s_flag:              std_logic := '0';
    signal s_err_count:         integer range 8 downto 0 := 0;
    signal s_address_in:        integer range 7 downto 0 := 7;
    constant CLK_HALF_PERIOD:   time := 0.05 ns;
    signal s_nstate:            TEST_FSM_ST;
    signal s_cstate:            TEST_FSM_ST;
    
begin
    s_clk <= not s_clk after CLK_HALF_PERIOD;
    DUT: FullAdd
        port map(
            clk     => s_clk,
            A       => s_A,
            B       => s_B,
            Cin     => s_Cin,
            Sum     => s_Sum,
            Cout    => s_Cout
        );
    STIM: Input_ROM
        port map(
            address_in  => s_address_in,
            A_out       => s_A,
            B_out       => s_B,
            C_out       => s_Cin
        );
    EXPEC: Output_ROM
        port map(
            address_in  => s_address_in,
            Sum_out       => s_Exp_Sum,
            C_out       => s_Exp_Cout
        );
       
    TEST_FSM_CS: process (s_clk)
    begin
        if (rising_edge(s_clk)) then
            s_cstate <= s_nstate;
        else
            s_cstate <= s_cstate;
        end if;
    end process TEST_FSM_CS;

    TEST_NS_PROC: process(s_cstate, s_flag)
    begin
        case s_cstate is
        when S0_START   =>
            s_nstate <= S1_STIM;
        when S1_STIM    =>
            s_nstate <= S2_COMP;
        when S2_COMP    =>
            if (s_flag = '0') then
                s_nstate <= S1_STIM;
            else
                s_nstate <= S3_DONE;
            end if;
        when S3_DONE    =>
        when others =>
            s_nstate <= S0_START;
        end case;
    end process TEST_NS_PROC;

    TEST_OUT_PROC: process(s_clk)
    begin
        if (rising_edge(s_clk)) then
            case s_cstate is
            when S0_START =>
                s_address_in <= 7;
                s_flag <= '0';
                s_err_count <= 0;
            when S1_STIM =>
                s_address_in <= s_address_in;
                s_flag <= s_flag;
            when S2_COMP =>
                if(s_address_in > 0) then
                    s_address_in    <= s_address_in - 1;
                    s_flag          <= '0';
                    if (not (s_Sum = s_Exp_Sum) or (not (s_Cout) = s_Exp_Cout)) then
                        s_err_count <= s_err_count + 1;
                    else
                        s_err_count <= s_err_count;
                    end if;
                elsif (s_flag = '0') then
                    s_flag <= '1';
                    s_address_in <= s_address_in;
                    if (not (s_Sum = s_Exp_Sum) or (not (s_cout = s_Exp_Cout))) then
                        s_err_count <= s_err_count + 1;
                    else
                        s_err_count <= s_err_count;
                    end if;
                else
                    s_flag <= '1';
                    s_address_in <= 7;
                    s_err_count <= 0;
                    end if;
            when S3_DONE =>
                assert false report
                LF & "###########################################" &
                LF & "########## END OF SIMULATION ##############" &
                LF & "###########################################"
                severity note;
                if (s_err_count = 0) then
                    assert false report
                    LF & "###########################################" &
                    LF & "########## DESIGN APPROVED ################" &
                    LF & "###########################################"
                    severity failure;
                else
                    assert false report
                    LF & "###########################################" &
                    LF & "######## DESIGN NOT APPROVED ##############" &
                    LF & "###########################################"
                    severity failure;
                end if;
            when others =>
                s_flag <= '0';
                s_address_in <= 7;
                s_err_count <= 0;
            end case;
        else
        end if;
    end process TEST_OUT_PROC; 
end architecture Behavioral;

