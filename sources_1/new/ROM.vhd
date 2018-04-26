library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
use work.MicroArchitecture.all;


entity ROM is
    Port ( clk : in std_logic;
           rst : in std_logic;
           fetch : in std_logic;
           Addr : in t_BusWidth;
           Dout : out t_Byte
          );
end ROM;

architecture Behavioral of ROM is
    --signal reg : std_logic_vector(31 downto 0) := (others => '0');
    
    type t_RomArray is array (0 to 255) of t_Byte;
    signal rom_array : t_RomArray := (
        --TEST1, TEST1, TEST1, TEST1,
        BIPUSH1, X"11", BIPUSH1, X"12", IADD1,
        BIPUSH1, X"21", BIPUSH1, X"22", IADD1,
        BIPUSH1, X"31", BIPUSH1, X"32", IADD1,
        BIPUSH1, X"41", BIPUSH1, X"42", IADD1,
        IADD1, IADD1,
        IADD1,
        
        others => (others=>'0')
);


begin




process(clk)
begin

    if rising_edge (clk) then
        if(rst = '1') then
            Dout <= (others => '0');
        elsif(fetch = '1') then
            Dout <= rom_array(conv_integer(Addr));
        end if;
    end if;

end process;





--process(clk)
--begin

--    if rising_edge (clk) then
--        if(rst = '1') then
--            reg <= (others => '0');
--        else
--            reg <= Addr;
--        end if;
--    end if;

--end process;

--process(clk, fetch)
--begin

--    if (fetch = '1') then
--        if rising_edge (clk) then
--            Dout <= rom_array(conv_integer(reg));
--            --reg <= Addr;
--        end if;
--    end if;

--end process;

end Behavioral;