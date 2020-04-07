library ieee;
use ieee.std_logic_1164.all;

package adder_pkg is
    type memory is array ( 7 downto 0 ) of std_logic_vector ( 1 downto 0);

    constant ADDER_RES :  memory :=     ("11",
                                         "01",
                                         "01",
                                         "10",
                                         "01",
                                         "10",
                                         "10",
                                         "00");
end adder_pkg;
