library ieee;
use ieee.std_logic_1164.all;
use work.MicroArchitecture.all;

entity test_RAM is 
end test_RAM;

architecture behavior of test_RAM is

    component RAM port
    (
        clk : in std_logic;
        wr : in std_logic;
        rd : in std_logic;
        address : in t_BusWidth;
        DIn : in t_BusWidth;
        DOut : out t_BusWidth
    );
    end component;
    
    signal test_wr : std_logic := '0';
    signal test_rd : std_logic := '0';
    signal test_address : t_BusWidth := (others => '0');
    
    signal test_TXdata : t_BusWidth := (others => '0');
    signal test_RXdata : t_BusWidth := (others => '0');

    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

begin

uut: RAM port map (
    clk => test_clk,
    wr => test_wr,
    rd => test_rd,
    address => test_address,
    DIn => test_TXdata,
    DOut => test_RXdata
);



--clock generation process
clk_process: process
begin
    test_clk <= not test_clk;
    wait for test_clk_period/2;
end process;


stim_proc: process
begin

    wait for 25 ns;
    
    test_address <= X"00000000";
    test_TXdata <= X"F0F0F0F0";
    test_wr <= '1';
    wait for 100 ns;
    
    test_address <= X"00000001";
    test_TXdata <= X"0E0E0E0E";
    wait for 100 ns;
    
    test_address <= X"00000002";
    test_TXdata <= X"12340987";
    wait for 135 ns;
    
    test_wr <= '0';
    wait for 50 ns;

    
    test_address <= X"00000000";    
    test_rd <= '1';
    wait for 100 ns;

    test_address <= X"00000001";
    wait for 100 ns;

    test_address <= X"00000002";
    wait for 100 ns;

    --wait forever
    wait;
    
end process;

END;