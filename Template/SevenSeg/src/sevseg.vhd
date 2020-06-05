----------------------------------------------------------------------------------
--! 
--! @file      sevseg.vhd
--!
--! @brief     Implementation of 7-segments display controller
--! @details   Uses LUT to implement controller for a 7-segments display.
--!
--! @author    Guilherme Shimabuko
--! 
--!
--! @version 1.0
--! @date 2020-05-07
--!
--!     Version History
--!
--!     Version     Date            Author              Changes
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
use work.sevseg_pkg.all;


-- Entity ------------------------------------------------------------------------
--! @brief 7-segments Controller Entity Declaration
--!
--! @details Controller used to display numeric data into 7 segments display
----------------------------------------------------------------------------------
entity sevseg is 
    port( 
            -- Inputs -----------------------------------------------------------
            --! Raw number to be displayed
            Input:      in std_logic_vector ( 3 downto 0 );

            -- Outputs ----------------------------------------------------------
            --! Control signal for the 7-segments display
            Output:    out std_logic_vector ( 7 downto 0 )
        ); 
end sevseg;

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
architecture behavioural of sevseg is

begin
    --! This process uses LUT to convert raw number into control signal
    OUT_PROC: process (Input)
    begin
        if (to_integer(unsigned(Input))) < 10 then
            Output  <= SEVSEG_CONTROL(to_integer(unsigned(Input)));
        else
            Output <= "11111111";
        end if;
    end process;
end behavioural;
