library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

ENTITY test_regPC IS 
END test_regPC;

ARCHITECTURE behavior OF test_regPC IS

    COMPONENT regPC
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        LoadReg : in std_logic;
        BusOut : in std_logic;
        DIn : in t_BusWidth;
        DOut : out t_BusWidth;
        MemOut : out t_BusWidth
    );     
    END COMPONENT;

    signal test_rst : std_logic := '1';
    
    signal test_LoadReg : std_logic := '0';
    signal test_BusOut : std_logic := '0';
    signal test_Din : std_logic_vector(31 downto 0) := (others => '0');
    signal test_Dout : std_logic_vector(31 downto 0) := (others => '0');
    signal test_MemOut : std_logic_vector(31 downto 0) := (others => '0');

    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

BEGIN

uut: regPC PORT MAP (
    clk => test_clk,
    rst => test_rst,
    LoadReg => test_LoadReg,
    BusOut => test_BusOut,
    Din => test_Din,
    Dout => test_Dout,
    Memout => test_MemOut
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
    wait for 142 ns;

    test_LoadReg <= '1';
    wait for 14 ns;
    test_Din <= X"CCCCCCCC";

    wait for 50 ns;

    test_LoadReg <= '0';
    test_BusOut <= '1';

    wait for 220 ns;

    test_BusOut <= '0';
    test_Din <= X"f0f0f0f0";
    test_LoadReg <= '1';

    --wait forever
    wait;
    
end process;

END;