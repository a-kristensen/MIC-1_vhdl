library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

ENTITY test_regMBR IS 
END test_regMBR;

ARCHITECTURE behavior OF test_regMBR IS

    component regMBR port
    (
        clk : in std_logic;
        rst : in std_logic;
        fetch : in std_logic;
        BusOut : in t_MBRBusOut;
        MemIn : in std_logic_vector(7 downto 0);
        Dout_8 : out std_logic_vector(7 downto 0);
        Dout : out t_BusWidth
    );
    end component;


    signal test_rst : std_logic := '1';
    signal test_fetch : std_logic := '0';
    signal test_BusOut : t_MBRBusOut;
    signal test_MemIn : std_logic_vector(7 downto 0);
    signal test_Dout_8 : std_logic_vector(7 downto 0);
    signal test_Dout : t_BusWidth;
    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

BEGIN

   uut: regMBR PORT MAP (
        clk => test_clk,
        rst => test_rst,
        fetch => test_fetch,
        BusOut => test_BusOut,
        MemIn => test_MemIn,
        Dout_8 => test_Dout_8,
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


    wait for 14 ns;


    

    wait for 10 ns;

    --wait forever
    wait;
    
end process;

END;