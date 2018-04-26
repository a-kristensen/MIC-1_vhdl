library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.MicroArchitecture.all;

entity test_ROM is 
end test_ROM;

architecture behavior of test_ROM is

    component ROM port
    (
        clk : in std_logic;
        fetch : in std_logic;
        Addr : in std_logic_vector(31 downto 0);
        Dout : out std_logic_vector(7 downto 0)
    );
    end component;
    
    signal test_fetch : std_logic := '0';
    signal test_addr : std_logic_vector(31 downto 0) := (others => '0');
    signal test_data : std_logic_vector(7 downto 0) := (others => '0');

    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

begin

uut: ROM port map (
    clk => test_clk,
    fetch => test_fetch,
    Addr => test_addr,
    DOut => test_data
);



--clock generation process
clk_process: process
begin
    test_clk <= not test_clk;
    wait for test_clk_period/2;
end process;


stim_proc: process
begin

    wait for 75 ns;
    
    test_addr <= X"00000000";
    test_fetch <= '1';
    
    for i in 0 to 10 loop
        test_addr <= std_logic_vector(to_unsigned(i, test_addr'length));
        wait for 100 ns;
    end loop;

    test_fetch <= '0';

    for i in 0 to 10 loop
        test_addr <= std_logic_vector(to_unsigned(i, test_addr'length));
        wait for 100 ns;
    end loop;

    --wait forever
    wait;
    
end process;

END;