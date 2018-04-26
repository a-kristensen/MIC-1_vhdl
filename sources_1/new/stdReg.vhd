library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity stdReg is
    Port ( clk : in std_logic;
           rst : in std_logic;
           LoadReg : in std_logic;
           BusOut : in std_logic;
           Din : in t_BusWidth;
           Dout : out t_BusWidth
           );
end stdReg;

architecture Behavioral of stdReg is
    signal reg : t_BusWidth;
begin


process (clk, rst)
begin
    if rising_edge(clk) then
        if rst = '1' then
            reg <= (others => '0');
            --reg <= (0 => '1', 1 => '1', 2 => '1', others => '0');
        elsif LoadReg = '1' then
            reg <= Din;
        end if;
    end if;

end process;

process (clk)
begin

    if falling_edge(clk) then
        if(BusOut = '1') then
            Dout <= reg;
        else
            Dout <= (others => 'Z');
        end if;
    end if;

end process;

end Behavioral;