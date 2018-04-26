library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.MicroArchitecture.all;


entity RAM is
port(
    clk : in std_logic;
    wr : in std_logic;
    rd : in std_logic;
    address : in t_BusWidth;
    DIn : in t_BusWidth;
    DOut : out t_BusWidth
    
);
end entity RAM;



architecture Behavioral of RAM is
    type t_RamArray is array (0 to 254) of t_BusWidth;
    signal ram1 : t_RamArray := ( others => (others=>'0') );
begin


DOut <= ram1(conv_integer(address));

-- Memory Write Block
-- Write Operation : When wr = 1
MEM_WRITE: process (clk)
begin
    if (rising_edge(clk)) then
        if (wr = '1' and rd = '0') then
            ram1(conv_integer(address)) <= DIn;
        end if;
    end if;
end process;


-- Memory Read Block
-- Read Operation : When rd = 1
--MEM_READ:
--process (clk)
--begin
--    if (rising_edge(clk)) then
--        if (rd = '1' and wr = '0') then
--            DOut <= ram1(conv_integer(address));
--        else
--            DOut <= (others => 'Z');
--        end if;
--    end if;
--end process;

end Behavioral;