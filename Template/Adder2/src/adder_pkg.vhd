----------------------------------------------------------------------------------
--! 
--! @file      adder_pkg.vhd
--!
--! @brief     Package containing LUT for adder (\ref FullAdd)
--! @details   Package defines LUT in form of array for 1 bit Adder implementation
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

-- Package -----------------------------------------------------------------------
--! @brief     Package containing LUT for adder (\ref FullAdd)
--! @details   Package defines LUT in form of array for 1 bit Adder implementation
----------------------------------------------------------------------------------
package adder_pkg is
    -- Types ---------------------------------------------------------------------
    --! Defines type "memory" as an array.
    type memory is array ( 7 downto 0 ) of std_logic_vector ( 1 downto 0);

    -- Constants -----------------------------------------------------------------
    --! Constant where LUT will be kept
    constant ADDER_RES :  memory;

end adder_pkg;

-- Package body ------------------------------------------------------------------
--! @brief Package body
--! @details Initializes LUT with desired Output
----------------------------------------------------------------------------------
package body adder_pkg is
    --! Initizalizes ADDER_RES as the LUT with desired outputs
    constant ADDER_RES : memory :=      ("11",
                                         "01",
                                         "01",
                                         "10",
                                         "01",
                                         "10",
                                         "10",
                                         "00");
end package body;
