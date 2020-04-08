----------------------------------------------------------------------------------
--! 
--! @file      adder.vhd
--!
--! @brief     Implementation of simple 1-bit adder
--! @details   Implements adder using library ports
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


-- Entity ------------------------------------------------------------------------
--! @brief Full Adder Entity Declaration
--!
--! @details Full Adder for 1-bit addition
----------------------------------------------------------------------------------
entity FullAdd is 
    port( 
            -- Inputs -----------------------------------------------------------
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
--!         This 1-bit Full Adder uses library ports to present the output.
--!
--!         Although simple and relatively efficient, this approach has different
--!         delays for Sum and Cout ports. At first, this may not appear in simu-
--!         lations, as the delay is very small, but it tends to worsen in bigger
--!         designs.
--!
----------------------------------------------------------------------------------
architecture behavioural of FullAdd is

begin

    --! This process activates everytime there's a change in A, B or Cin and gives
    --! the addition result. Overflow result is given by Cout
    Output: process (A, B, Cin)
    begin
       sum  <= A XOR B XOR Cin;
       Cout <=  (A AND B) OR (A AND Cin) OR (Cin AND B);
    end process;
end behavioural;
