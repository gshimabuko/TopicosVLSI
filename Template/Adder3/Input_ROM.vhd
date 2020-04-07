library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Input_ROM is
    Port ( address_in : in integer range 7 downto 0;
           A_out :  out std_logic;
           B_out :  out std_logic;
           C_out :  out std_logic
    );
end Input_ROM;

architecture Behavioral of Input_ROM is
type rom_array is array (7 downto 0) of std_logic_vector (2 downto 0);
constant rom: rom_array := ("000",
                            "001",
                            "010",
                            "011",
                            "100",
                            "101",
                            "110",
                            "111");
begin

	A_out <= rom(address_in)(0);
    B_out <= rom(address_in)(1);
    C_out <= rom(address_in)(2);

end Behavioral;
