library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.MicroArchitecture.all;

entity regMBR is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        fetch : in std_logic;
        BusOut : in t_MBRBusOut;
        MemIn : in t_Byte;
        Dout_8 : out t_Byte;
        Dout : out t_BusWidth
           );
end regMBR;

architecture Behavioral of regMBR is
    signal regMBR : t_Byte;
begin

Dout_8 <= regMBR;


process (clk, rst)
begin
    if rising_edge(clk) then
        if rst = '1' then
            regMBR <= (others => '0');
            
--        elsif fetch = '1' then
--            regMBR <= MemIn;
        else
            regMBR <= MemIn;
        end if;
    end if;

end process;

process (clk)
begin

    if falling_edge(clk) then
        if (BusOut.bit_MBRs = '1') then
            --Dout <= std_logic_vector(resize(signed(reg), 32));
            Dout <= "00000000000000000000000000111000";
        elsif (BusOut.bit_MBRu = '1') then
            Dout <= (b"000000000000000000000000" & regMBR);
        else
            Dout <= (others => 'Z');
        end if;
    end if;
    
end process;

end Behavioral;