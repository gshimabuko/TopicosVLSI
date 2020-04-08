----------------------------------------------------------------------------------
--! 
--! @file       adder_tb_pkg.vhd
--!
--! @brief      Testbench for a simple 1-bit adder \ref FullAdd
--! @details    Uses a RAM for Input and another RAM for expected output.
--!             Implements Adder and compares output with Expected Output Ram.
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

    signal s_clk:           std_logic := '0';
    signal s_A:             std_logic := '0';
    signal s_B:             std_logic := '0';
    signal s_Cin:           std_logic := '0';
    signal s_Sum:           std_logic := '0';
    signal s_Cout:          std_logic := '0';
    signal s_Exp_Sum:       std_logic := '0';
    signal s_Exp_Cout:      std_logic := '0';
    signal s_flag:          std_logic := '0';
    signal s_err_count:     integer range 8 downto 0 := 0;
    signal s_address_in:    integer range 7 downto 0 := 7;
    constant CLK_HALF_PERIOD:  time := 0.05 ns;
    
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
    
    enable_proc: process(s_clk)
    begin
        if (s_address_in > 0) then
            if (rising_edge(s_clk)) then
                s_address_in    <= s_address_in - 1;
                s_flag          <= '0';
                if (not (s_Sum = s_Exp_Sum) or (not (s_Cout = s_Exp_Cout))) then
                    s_err_count <= s_err_count + 1;
                else
                    s_err_count <= s_err_count;
                end if;
            end if;
        elsif (s_flag = '0') then
            s_flag  <= '1';
            if (not (s_Sum = s_Exp_Sum) or (not (s_Cout = s_Exp_Cout))) then
                s_err_count <= s_err_count + 1;
            else
                s_err_count <= s_err_count;
            end if;
        else
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
        end if;
    end process enable_proc;
    
end architecture Behavioral;

