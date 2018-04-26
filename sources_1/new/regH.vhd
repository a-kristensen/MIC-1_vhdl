library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity regH is
    Port ( clk : in std_logic;
           rst : in std_logic;
           LoadReg : in std_logic;
           Din : in t_BusWidth;
           Dout : out t_BusWidth
           );
end regH;

architecture Behavioral of regH is
begin

-- reset are asyncronous to the clock (override the clock)
process (clk, rst)
begin

    if rising_edge(clk) then
        if rst = '1' then
            Dout <= (others => '0');
        elsif LoadReg = '1' then
            Dout <= Din;
        end if;
    end if;
end process;

end Behavioral;