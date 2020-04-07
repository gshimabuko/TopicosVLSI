library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Output_ROM is
    Port ( address_in : in integer range 7 downto 0;
           Sum_out :  out std_logic;
           C_out :  out std_logic
    );
end Output_ROM;

architecture Behavioral of Output_ROM is
type rom_array is array (7 downto 0) of std_logic_vector (1 downto 0);
constant rom: rom_array := ("00",
                            "10",
                            "10",
                            "01",
                            "10",
                            "01",
                            "01",
                            "11");
begin

	Sum_out <= rom(address_in)(1);
    C_out <= rom(address_in)(0);

end Behavioral;
