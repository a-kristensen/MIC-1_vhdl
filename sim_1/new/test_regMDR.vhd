library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MicroArchitecture.all;

ENTITY test_regMDR IS 
END test_regMDR;

ARCHITECTURE behavior OF test_regMDR IS

    component regMDR port(
        clk : in std_logic;
        rst : in std_logic;
        LoadReg : in std_logic;
        BusOut : in std_logic;
        wr : in std_logic;
        rd : in std_logic;
        DIn : in t_BusWidth;
        MemOut : out t_BusWidth;
        MemIn : in t_BusWidth;
        DOut : out t_BusWidth
        );
    end component;

    signal test_rst : std_logic := '1';
    signal test_LoadReg : std_logic := '0';
    signal test_BusOut : std_logic := '0';
    signal test_wr : std_logic := '0';
    signal test_rd : std_logic := '0';
    signal test_DIn : t_BusWidth := (others => '0');
    signal test_MemOut : t_BusWidth := (others => '0');
    signal test_MemIn : t_BusWidth := (others => '0');
    signal test_DOut : t_BusWidth := (others => '0');
    
    signal test_clk : std_logic := '0';
    constant test_clk_period : time := 100 ns;

    signal tmp : std_logic_vector(3 downto 0) := (others => '0');

BEGIN

uut: regMDR PORT MAP (
    clk => test_clk,
    rst => test_rst,
    LoadReg => test_LoadReg,
    BusOut => test_BusOut,
    wr => test_wr,
    rd => test_rd,
    DIn => test_DIn,
    MemOut => test_MemOut,
    MemIn => test_MemIn,
    DOut => test_DOut
);
   
   


--clock generation process
clk_process: process
begin
    test_clk <= not test_clk;
    wait for test_clk_period/2;
end process;


stim_proc: process
begin

    wait for 15 ns;
    test_rst <= '0';
    
    wait for 100 ns;

    test_DIn <= X"F0F0F0F0";
    test_MemIn <= X"15151515";

    for i in 0 to 16 loop
        tmp <= std_logic_vector(to_unsigned(i, 4));
        
        test_LoadReg <= tmp(0);
        test_BusOut <= tmp(1);
        test_wr <= tmp(2);
        test_rd <= tmp(3);
 
        wait for 215 ns;
    end loop;




    





    


    --wait forever
    wait;
    
end process;

END;