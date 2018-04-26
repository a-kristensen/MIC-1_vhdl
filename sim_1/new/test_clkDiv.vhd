library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

ENTITY test_clkDiv IS 
END test_clkDiv;

ARCHITECTURE behavior OF test_clkDiv IS

    COMPONENT clkDiv
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        clk1 : out std_logic;
        clk2 : out std_logic;
        clk3 : out std_logic;
        clk4 : out std_logic
    );     
    END COMPONENT;

    signal test_rst : std_logic := '1';
    
    signal test_clk1 : std_logic := '0';
    signal test_clk2 : std_logic := '0';
    signal test_clk3 : std_logic := '0';
    signal test_clk4 : std_logic := '0';

    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

BEGIN

uut: clkDiv PORT MAP (
    clk => test_clk,
    rst => test_rst,
    clk1 => test_clk1,
    clk2 => test_clk2,
    clk3 => test_clk3,
    clk4 => test_clk4
);


--clock generation process
clk_process: process
begin
    test_clk <= not test_clk;
    wait for test_clk_period/2;
end process;


stim_proc: process
begin

    wait for 136 ns;
    test_rst <= '0';

    --wait forever
    wait;
    
end process;

END;