library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.MicroArchitecture.all;

entity test_MIC1 is 
end test_MIC1;

architecture behavior of test_MIC1 is

    component MIC1 port
    (
        up_Clock : in std_logic;
        up_Reset : in std_logic;
        up_clk1 : out std_logic;
        up_clk2 : out std_logic;
        up_clk3 : out std_logic;
        
        tst_busB : out t_BusWidth;
        tst_busC : out t_BusWidth;
        
        tst_CtrlStoreAddrIn : out t_NextAddr;
        
        tst_MBR_to_MPC : out t_Byte;
        tst_PC_to_ROM : out t_BusWidth;
        tst_ROM_to_MBR : out t_Byte;
        
        tst_MAR_to_RAM : out t_BusWidth;
        tst_MDR_to_RAM : out t_BusWidth;
        tst_RAM_to_MDR : out t_BusWidth;
        
        tst_MIRreg : out t_MicroInstr
    );
    end component;
    
    constant tst_clk_period : time := 100 ns;
    
    signal tst_clk : std_logic := '0';
    signal tst_rst : std_logic := '1';
    signal up_clk1 : std_logic;
    signal up_clk2 : std_logic;
    signal up_clk3 : std_logic;
    
    signal tst_busB : t_BusWidth;
    signal tst_busC : t_BusWidth;
    signal tst_CtrlStoreAddrIn : t_NextAddr;
    
    signal tst_MBR_to_MPC : t_Byte;
    signal tst_PC_to_ROM : t_BusWidth; 
    signal tst_ROM_to_MBR : t_Byte;

    signal tst_MAR_to_RAM : t_BusWidth;
    signal tst_MDR_to_RAM : t_BusWidth;
    signal tst_RAM_to_MDR : t_BusWidth;

    signal tst_MIRreg : t_MicroInstr;

begin

uut: MIC1 port map (
    up_Clock => tst_clk,
    up_Reset => tst_rst,
    up_clk1 => up_clk1,
    up_clk2=> up_clk2,
    up_clk3 => up_clk3,
    
    tst_busB => tst_busB,
    tst_busC => tst_busC,
    tst_CtrlStoreAddrIn => tst_CtrlStoreAddrIn,
    
    tst_MBR_to_MPC => tst_MBR_to_MPC,
    tst_PC_to_ROM => tst_PC_to_ROM,
    tst_ROM_to_MBR => tst_ROM_to_MBR,
    
    tst_MAR_to_RAM => tst_MAR_to_RAM,
    tst_MDR_to_RAM => tst_MDR_to_RAM,
    tst_RAM_to_MDR => tst_RAM_to_MDR,
    
    tst_MIRreg => tst_MIRreg
);



--clock generation process
clk_process: process
begin
    tst_clk <= not tst_clk;
    wait for tst_clk_period/2;
end process;



stim_proc: process
begin

    wait for 825 ns;
    tst_rst <= '0';
   


    --wait forever
    wait;
    
end process;

END;