library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity regMAR is
Port
(
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    DIn : in t_BusWidth;
    MemOut : out t_BusWidth
);
end regMAR;

architecture Behavioral of regMAR is
    signal regMAR : t_BusWidth;
begin

--show contents always
MemOut <= regMAR;

process (clk, rst)
begin
    if rising_edge(clk) then
        if (rst = '1') then
            regMAR <= (others => '0');
        elsif (LoadReg = '1') then
            regMAR <= Din;
        end if;
    end if;
    
end process;

end Behavioral;