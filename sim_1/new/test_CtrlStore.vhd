library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

ENTITY test_CtrlStore IS 
END test_CtrlStore;

ARCHITECTURE behavior OF test_CtrlStore IS

    COMPONENT CtrlStore
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        Addr : in std_logic_vector (8 downto 0);
        MIRreg : out t_MicroInstr
    );
    END COMPONENT;

    signal tst_Addr : std_logic_vector(8 downto 0) := (others => '0');
    signal tst_rst : std_logic := '1';
    signal tst_MIRreg : t_MicroInstr;   

    signal tst_clk : std_logic := '0';
    constant tst_clk_period : time := 100 ns;

BEGIN

   uut: CtrlStore PORT MAP (
        clk => tst_clk,
        rst => tst_rst,
        Addr => tst_Addr,
        MIRreg => tst_MIRreg
   );

tst_MIRreg.NextAddr <= tst_Addr(7 downto 0);

--clock generation process
clk_process :process
begin
    tst_clk <= not tst_clk;
    wait for tst_clk_period/2;
end process;


stim_proc :process
begin

    wait for 225 ns;
    tst_rst <= '0';

    --wait forever
    wait;
    
end process;

END;