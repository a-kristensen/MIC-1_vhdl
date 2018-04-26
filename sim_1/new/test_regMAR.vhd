library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY test_regMAR IS 
END test_regMAR;

ARCHITECTURE behavior OF test_regMAR IS

    COMPONENT regMAR
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        LoadReg : in std_logic;
        Din : in std_logic_vector(31 downto 0);
        Dout : out std_logic_vector(31 downto 0)
    );     
    END COMPONENT;

    signal test_rst : std_logic := '1';
    signal test_LoadReg : std_logic := '0';
    signal test_Din : std_logic_vector(31 downto 0) := (others => '0');
    signal test_Dout : std_logic_vector(31 downto 0) := (others => '0');

    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

BEGIN

   uut: regMAR PORT MAP (
        clk => test_clk,
        rst => test_rst,
        LoadReg => test_LoadReg,
        Din => test_Din,
        Dout => test_Dout
   );


--clock generation process
clk_process :process
begin
    test_clk <= not test_clk;
    wait for test_clk_period/2;
end process;


stim_proc :process
begin

    wait for 15 ns;
    test_rst <= '0';
    wait for 142 ns;

    test_LoadReg <= '1';
    wait for 14 ns;
    test_Din <= "00011010000110100001101000011010";

    

    wait for 10 ns;

    --wait forever
    wait;
    
end process;

END;