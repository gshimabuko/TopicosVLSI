----------------------------------------------------------------------------------
--! 
--! @file      adder.vhd
--!
--! @brief     Implementation of simple 1-bit adder
--! @details   
--!
--!         Implements adder unsing ROM. Should synthesize as a LUT. This design
--!         differs from the first because it has only one process. This will
--!         cause the signal to change one event later. Due to this, this design
--!         should not be assynchornous, otherwise, you'd never know when to read
--!         the signal. We included the clock to make it predictable.
--!             
--!
--! @author    Guilherme Shimabuko 
--! 
--!
--! @version 1.1
--! @date 2020-04-07
--!
--!     Version History
--!
--!     Version     Date            Author              Changes
--!         
--!     1.1         2020-04-07      GSHIMABUKO          Added Doxygen coding
--!                                                     Style.
--!
--!     1.0         2020-03-18      GSHIMABUKO          Block Created
--! 
--! @pre       
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

-- Libraries ---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder_pkg.all;


-- Entity ------------------------------------------------------------------------
--! @brief Full Adder Entity Declaration
--!
--! @details Full Adder for 1-bit addition
----------------------------------------------------------------------------------
entity FullAdd is 
    port( 
            -- Inputs -----------------------------------------------------------
            --! Input Clock Signal
            Clk:    in std_logic;

            --! Input with first operand
            A:      in std_logic;

            --! Input with second operand
            B:      in std_logic; 

            --! Input indicating carry from previous stage
            Cin:    in std_logic;            

            -- Outputs ----------------------------------------------------------
            --! Output of Sum Operation
            Sum:    out std_logic; 

            --! Output Carry indicating overflow
            Cout: out std_logic
        ); 
end FullAdd;

-- Architecture ------------------------------------------------------------------
--! @brief ROM Based 1-bit Full Adder
--!
--! @details 
--!
--!         This 1-bit Full Adder uses a ROM to implement a LUT to ensure 
--!         consistent delay between Sum Output and Carry Output.
--!
--!         This is considered a relatively fast architecture with consistent
--!         delay for all outputs, but it uses a lot of area.
----------------------------------------------------------------------------------
architecture behavioural of FullAdd is
signal addr : std_logic_vector (2 downto 0);
begin
    --! This process separates the result from the LUT into the proper outputs
    Output: process (Clk)
    begin
        if (rising_edge(Clk)) then
            addr <= (A & B & Cin);
            sum  <= ADDER_RES (to_integer(unsigned(addr)))(1);
            Cout <= ADDER_RES (to_integer(unsigned(addr)))(0);
        else
            addr <= addr;
        end if;
    end process;
end behavioural;
