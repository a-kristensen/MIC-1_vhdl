library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HighBit is
    Port ( clk : in std_logic;
           rst : in std_logic;
           AluNegIn : in std_logic;
           AluZeroIn : in std_logic;
           JAMN : in std_logic;
           JAMZ : in std_logic;
           HBOut : out std_logic
         );
end HighBit;

architecture Behavioral of HighBit is

    signal regN : std_logic;
    signal regZ : std_logic;

begin

process (clk, rst)
begin

    if rising_edge(clk) then
        if rst = '1' then
            regN <= '0';
            regZ <= '0';
        else
            regN <= AluNegIn;
            regZ <= AluZeroIn;
        end if;
    end if;
end process;

HBOut <= (JAMZ AND regZ) OR (JAMN AND regN);


end Behavioral;