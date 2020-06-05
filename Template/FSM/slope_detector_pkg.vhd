--! @file      slope_detector.vhd
--!
--! @brief     subblock of the oximeter Slope detector
--! @details   Detects rising and falling edges in oximeter signal
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   1.0
--! @date      2016-08-18
--! 
--! @pre       Started by slop_detector_start
--! @pre       
--! @copyright DFchip
--! 
-------------------------------------------------------------------------------
-- Version History
--
-- Version  Date        Author       Changes
-- 1.0      2016-08-18 GSHIMABUKO    Block Created


--------------------------------------------------------------------------------

-- Libraries ------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use work.global_constants_pkg.all;
-- Entity ---------------------------------------------------------------------

--! @brief Oximeter: Slope Detector
--!
--! @image html spec_block_ms.png

package slope_detector_pkg is

    -- Types ------------------------------------------------------------------
    
    --! States of FSM_SPEC_MS_DEC at \ref spec_ms_dec.behaviour
    subtype ST_FSM_SLOPE is std_logic_vector(1 downto 0);    
        constant S0_INIT:   ST_FSM_SLOPE    := "00";
        constant S1_SAMP:   ST_FSM_SLOPE    := "01";
        constant S2_RIS:    ST_FSM_SLOPE    := "11";
        constant S3_FAL:    ST_FSM_SLOPE    := "10";

    -- Constants --------------------------------------------------------------
    constant DATA_ZERO: std_logic_vector(L_DATA downto 0);
    constant DATA_WIDHT: integer;
    -- Components -------------------------------------------------------------
    component slope_detector is

    port (
        -- Inputs ---------------------------------------------------

        clk         :   in std_logic;
        rst_n       :   in std_logic;
        start       :   in std_logic;
        data_in     :   in std_logic_vector(DATA_WIDTH-1 downto 0);

        -- Outputs --------------------------------------------------

        slope   :   out std_logic;
        counter_start    :   out std_logic
    );

    end component slope_detector;
end package slope_detector_pkg;
package body slope_detector_pkg is
    constant DATA_ZERO: std_logic_vector(L_DATA downto 0) := (others => '0');
    constant DATA_WIDTH: integer := L_DATA;
end package body slope_detector_pkg;
