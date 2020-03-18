library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity AAC2M1H1_tb2 is
end entity AAC2M1H1_tb2;

architecture Behavioral of AAC2M1H1_tb2 is
    component FullAdd is
        port(
            -- Inputs ---------------------------------------------------

            --! Input A
            A:      in std_logic;
        
            --! Input B
            B:      in std_logic;

            --! Input Cin
            Cin:    in std_logic;

            -- Outputs --------------------------------------------------

            --! Sum result
            Sum:    out std_logic;

            --! Carry result
            Cout:   out std_logic

        );
    end component FullAdd;

    component Input_Rom is
        port(
                -- Inputs ----------------------------------------------
                address_in: in integer range 7 downto 0;
                -- Outputs ---------------------------------------------
                A_out:      out std_logic;
                B_out:      out std_logic;
                C_out:      out std_logic
        );
    end component Input_Rom;
    component Output_Rom is
        port(
                -- Inputs ----------------------------------------------
                address_in: in integer range 7 downto 0;
                -- Outputs ---------------------------------------------
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

