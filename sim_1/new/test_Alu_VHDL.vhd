library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.MicroArchitecture.all;

entity test_Alu_VHDL is 
end test_Alu_VHDL;

architecture behavior of test_Alu_VHDL is

component Alu_VHDL port
(
    AluCtrl : std_logic_vector(5 downto 0);
    ShftCtrl : in std_logic_vector(1 downto 0);
    BusA : in t_BusWidth;
    BusB : in t_BusWidth;
    BusC : out t_BusWidth;
    Neg : out std_logic;
    Zero : out std_logic
);
end component;

    
    signal test_AluCtrl : STD_LOGIC_VECTOR ( 5 downto 0 ) := (others => '0');
    signal test_BusA : t_BusWidth := (others => '0');
    signal test_BusB : t_BusWidth := (others => '0');
    signal test_BusC : t_BusWidth := (others => '0');
    signal test_Neg : std_logic := '0';
    signal test_Zero : std_logic := '0';   
    signal test_ShftCtrl : STD_LOGIC_VECTOR ( 1 downto 0 ) := (others => '0');
    
begin


uut: Alu_VHDL port map (
    AluCtrl => test_AluCtrl,
    ShftCtrl => test_ShftCtrl,
    BusA => test_BusA,
    BusB => test_BusB,
    BusC => test_BusC,
    Neg => test_Neg,
    Zero => test_Zero
);


stim_proc: process
begin

    wait for 50 ns;
    
    test_BusA <= X"00000078";
    test_BusB <= X"00000212";
    
    for i in 0 to 16 loop
        test_AluCtrl <= std_logic_vector(to_unsigned(i, test_AluCtrl'length));        
        wait for 100 ns;
    end loop;

    test_AluCtrl <= "000000";
    test_BusA <= X"00008000";

    test_ShftCtrl <= "01";
    wait for 100 ns;
    
    test_ShftCtrl <= "10";

    --wait forever
    wait;
    
end process;

END;
