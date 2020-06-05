-------------------------------------------------------------------------------
--! 
--! @file      slope_detector.vhd
--!
--! @brief     subblock of the oximeter Slope detector
--! @details   Detects rising and falling edges in oximeter signal
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   2.0
--! @date      2016-08-18
--! @date      2016-10-14
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
-- 2.0      2016-10-14 GSHIMABUKO    State transitions fixed


--------------------------------------------------------------------------------
-- Libraries -------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use work.slope_detector_pkg.all;
    use work.global_constants_pkg.all;
    
    
-- Entity ---------------------------------------------------------------------

--! @brief Oximeter: Slope Detector
--!
--! @image html spec_block_ms.png

entity slope_detector is

    port (
        -- Inputs ---------------------------------------------------

        clk         :   in std_logic;
        rst_n       :   in std_logic;
        start       :   in std_logic;
        data_in     :   in std_logic_vector(DATA_WIDTH - 1 downto 0);

        -- Outputs --------------------------------------------------

        slope   :   out std_logic;
        counter_start    :   out std_logic
    );

end slope_detector;
architecture slope_detector_op of slope_detector is
    signal s_cstate:    ST_FSM_SLOPE;
    signal s_nstate:    ST_FSM_SLOPE;
    signal s_change:    std_logic;
    signal s_data_0:    std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal s_data_1:    std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal s_diff:      std_logic_vector(DATA_WIDTH - 1 downto 0);

    begin

    FSM_CS_PROC: process(clk, rst_n)
    begin
        if rst_n ='0' then
            s_cstate <= S0_INIT;
        elsif (rising_edge(clk)) then
            s_cstate <= s_nstate;
        end if;
    end process FSM_CS_PROC;
    
    FSM_NS_PROC: process(s_cstate, s_change)
    begin
        case s_cstate is
        when S0_INIT    =>
            s_nstate <= S1_SAMP;
        when S1_SAMP    =>
            if (s_change = '1') then
                s_nstate <= S2_RIS;
            else
                s_nstate <= S1_SAMP;
            end if;
        when S2_RIS     =>
            if (s_change = '1') then
                s_nstate <= S3_FAL;
            else
                s_nstate <= S2_RIS;
            end if;
        when S3_FAL     =>
            if (s_change = '1') then
                s_nstate <= S2_RIS;
            else
                s_nstate <= S3_FAL;
            end if;
        end case;            
    end process FSM_NS_PROC;

    FSM_OUT_PROC: process(clk, rst_n)
    begin
        if rst_n = '0' then
            s_change        <= '0';
            s_data_0        <= (others => '0');
            s_data_1        <= (others => '1');
            s_diff          <= (others => '0');
            slope       <= (others => '0');
        elsif rising_edge(clk) then
            case s_cstate is
            when S0_INIT    =>
                s_data_0    <= data_in;
                s_data_1    <= s_data_1;
                s_diff      <= s_diff;
                s_change    <= s_change;
                slope       <= (others => '0');
            when S1_SAMP    =>
                s_data_0    <= data_in;
                s_data_1    <= s_data_0;
                s_diff      <= (signed(s_data_1) - signed(s_data_0));
                s_change    <= (s_diff(DATA_WIDTH-1));
                slope       <= (others => '0');
            when S2_RIS     =>
                s_data_0    <= data_in;
                s_data_1    <= s_data_0;
                s_diff      <= (signed(s_data_0) - signed(s_data_1));
                s_change    <= (s_diff(DATA_WIDTH-1));
                slope       <= s_change;
            when S3_FAL     =>
                s_data_0    <= data_in;
                s_data_1    <= s_data_0;
                s_diff      <= (signed(s_data_1) - signed(s_data_0));
                s_change    <= (s_diff(DATA_WIDTH-1));
                slope       <= (others => '0');
            when others     =>
                s_change    <= '0';
                s_data_0    <= (others => '0');
                s_data_1    <= (others => '1');
                s_diff      <= (others => '0'); 
                slope       <= (others => '0'); 
            end case;
        else
            s_change        <= '0';
            s_data_0        <= (others => '0');
            s_data_1        <= (others => '1');
            s_diff          <= (others => '0'); 
        end if;
    end process FSM_OUT_PROC;
   
end slope_detector_op;
