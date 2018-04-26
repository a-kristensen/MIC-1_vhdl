library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity regMDR is
    port ( clk : in std_logic;
           rst : in std_logic;
           LoadReg : in std_logic;
           BusOut : in std_logic;
           wr : in std_logic;
           rd : in std_logic;
           DIn : in t_BusWidth;
           MemOut : out t_BusWidth;
           MemIn : in t_BusWidth;
           DOut : out t_BusWidth
           );
end regMDR;

architecture Behavioral of regMDR is
    signal regMDR : t_BusWidth;
begin

MemOut <= regMDR;

--load from either C-bus, from RAM or to RAM
process (clk, rst)
begin


    if rising_edge(clk) then
        if rst = '1' then
            regMDR <= (others => '0');
        elsif (LoadReg = '1') then
            regMDR <= DIn;
        elsif (rd = '1') then
            regMDR <= MemIn;
        end if;
    end if;

end process;


--take care of loading to B-bus
process (clk)
begin

    if falling_edge(clk) then
        if(BusOut = '1') then
            DOut <= regMDR;
        else
            DOut <= (others => 'Z');
        end if;
    end if;

end process;

end Behavioral;