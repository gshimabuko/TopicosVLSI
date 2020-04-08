----------------------------------------------------------------------------------
--! 
--! @file       adder_tb_pkg.vhd
--!
--! @brief      Testbench package for a simple 1-bit adder \ref FullAdd
--! @details    Implements FSM type for testbench. 
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
--!     1.0         2020-03-19      GSHIMABUKO          Block Created
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

-- Libraries --------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;

package adder_tb_pkg is
    -- Types ------------------------------------------------------------------
    
    --! States of adder_tb FSM
    subtype TEST_FSM_ST is std_logic_vector(1 downto 0);
        constant S0_START:      TEST_FSM_ST := "00";
        constant S1_STIM:       TEST_FSM_ST := "01";
        constant S2_COMP:       TEST_FSM_ST := "11";
        constant S3_DONE:       TEST_FSM_ST := "10";
end package adder_tb_pkg;    
