library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
use work.MicroArchitecture.all;

entity clkDiv is
    Port ( clk : in std_logic;
           rst : in std_logic;
           clk1 : out std_logic;
           clk2 : out std_logic;
           clk3 : out std_logic;
           clk4 : out std_logic
         );
end clkDiv;

architecture Behavioral of clkDiv is
    signal clk_1 : std_logic;
    signal clk_2 : std_logic;
    signal clk_3 : std_logic;
    signal clk_4 : std_logic;
    signal cnt : std_logic_vector(1 downto 0);
    signal pre_rst : std_logic := '0';
begin




freq_div: process (clk)
begin

    if rising_edge(clk) then
        if rst = '1' and pre_rst = '0' then
            pre_rst <= '1';
            cnt <= "00";
            clk_1 <= '0';
            clk_2 <= '0';
            clk_3 <= '0';
            clk_4 <= '0';
            
        elsif pre_rst = '1' then
        
            cnt <= cnt + 1; 
            
            case cnt is
                when "00" =>
                    clk_1 <= not clk_1;
                when "01" =>
                    clk_2 <= not clk_2;
                when "10" =>
                    clk_3 <= not clk_3;
                when others =>
                    clk_4 <= not clk_4;
            end case;
            
         else
            pre_rst <= '0';            
        end if;
    end if;

end process;



clk1 <= clk_1;
clk2 <= clk_2;
clk3 <= clk_3;
clk4 <= clk_4;

end Behavioral;