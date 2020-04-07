library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity AAC2M1H1_tb is
end entity AAC2M1H1_tb;

architecture Behavioral of AAC2M1H1_tb is
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
            Cout:      out std_logic

        );
    end component FullAdd;
    
    file data_in:        text open read_mode is "/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Colorado/AAC2M1H1/data_in.out";
    file data_out:       text open write_mode is "/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Colorado/AAC2M1H1/data_out.out";
    
    signal s_clk:       std_logic := '0';
    signal s_A:         std_logic := '0';
    signal s_B:         std_logic := '0';
    signal s_Cin:       std_logic := '0';
    signal s_Sum:       std_logic := '0';
    signal s_Cout:      std_logic := '0';
    signal s_Out:       std_logic_vector(1 downto 0) := (others =>'0');

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
    
    enable_proc: process(s_clk)
    variable data_in_line: line;
    variable data_out_line: line;
    variable data_input: std_logic_vector (2 downto 0);
    begin
        if (not endfile(data_in)) then
            if (rising_edge(s_clk)) then
                readline(data_in, data_in_line);
                read(data_in_line, data_input);
                s_A <= std_logic(data_input(2));
                s_B <= std_logic(data_input(1));
                s_Cin <= std_logic(data_input(0));
                s_Out(0)<=s_Sum;
                s_Out(1)<=s_Cout;
                write(data_out_line, s_out, right, 2);
                writeline(data_out, data_out_line);
            end if;
        else
            file_close(data_in);
            file_close(data_out);
            assert false report
            LF & "###########################################" &
            LF & "########## END OF SIMULATION ##############" &
            LF & "###########################################"
            severity failure;           
        end if;
    end process enable_proc;
    
end architecture Behavioral;

