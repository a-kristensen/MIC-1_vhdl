library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity regPC is
    Port ( clk : in std_logic;
           rst : in std_logic;
           LoadReg : in std_logic;
           BusOut : in std_logic;
           DIn : in t_BusWidth;
           DOut : out t_BusWidth;
           MemOut : out t_BusWidth
           );
end regPC;

architecture Behavioral of regPC is
    signal regPC : t_BusWidth;
begin

MemOut <= regPC;

process (clk, rst)
begin

    if rising_edge(clk) then
        if rst = '1' then
            regPC <= (others => '0');
        elsif LoadReg = '1' then
            regPC <= DIn;
        end if;
    end if;

end process;

process (clk)
begin
    if falling_edge(clk) then
        if (BusOut = '1') then
            DOut <= regPC;
        else
            DOut <= (others => 'Z');
        end if;
    end if;

end process;

end Behavioral;