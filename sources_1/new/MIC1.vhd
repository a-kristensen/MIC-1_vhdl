library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use work.MicroArchitecture.all;

entity MIC1 is
    Port (
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
end MIC1;

architecture Structural of MIC1 is

component clkDiv port (
    clk : in std_logic;
    rst : in std_logic;
    clk1 : out std_logic;
    clk2 : out std_logic;
    clk3 : out std_logic;
    clk4: out std_logic );     
end component;


component ROM port (
    clk : in std_logic;
    rst : in std_logic;
    fetch : in std_logic;
    Addr : in t_BusWidth;
    Dout : out t_Byte );
end component;

component RAM port (
    clk : in std_logic;
    wr : in std_logic;
    rd : in std_logic;
    address : in t_BusWidth;
    DIn : in t_BusWidth;
    DOut : out t_BusWidth );
end component;

component CtrlStore port (
    clk : in std_logic;
    rst : in std_logic;
    Addr : in t_NextAddr;
    MIRreg : out t_MicroInstr );
end component;


component Alu_VHDL port (
    AluCtrl : in t_AluCtrl;
    ShftCtrl : in t_Shift;
    BusA : in t_BusWidth;
    BusB : in t_BusWidth;
    BusC : out t_BusWidth;
    Neg : out std_logic;
    Zero : out std_logic );
end component;

component Decoder port (
    DecIn : in std_logic_vector(3 downto 0);
    DecoderOut : out t_DecoderOut );
end component;

component HighBit port (
    clk : in std_logic;
    rst : in std_logic;
    AluNegIn : in std_logic;
    AluZeroIn : in std_logic;
    JAMN : in std_logic;
    JAMZ : in std_logic;
    HBOut : out std_logic );
end component;


component MPC port (
    JMPC : in std_logic;
    HighBit : in std_logic;
    MBRIn : in t_Byte;
    AddrIn : in t_Addr;
    MPCOut : out t_NextAddr );
end component;



component regMAR port (
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    DIn : in t_BusWidth;
    MemOut : out t_BusWidth );
end component;

component regMDR port (
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    BusOut : in std_logic;
    wr : in std_logic;
    rd : in std_logic;
    DIn : in t_BusWidth;
    MemOut : out t_BusWidth;
    MemIn : in t_BusWidth;
    DOut : out t_BusWidth );
end component;

component regPC port (
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    BusOut : in std_logic;
    DIn : in t_BusWidth;
    DOut : out t_BusWidth;
    MemOut : out t_BusWidth );
end component;

component regMBR port (
    clk : in std_logic;
    rst : in std_logic;
    fetch : in std_logic;
    BusOut : in t_MBRBusOut;
    MemIn : in t_Byte;
    Dout_8 : out t_Byte;
    Dout : out t_BusWidth
 );
end component;


component stdReg port (
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    BusOut : in std_logic;
    Din : in t_BusWidth;
    Dout : out t_BusWidth );
end component;

component regH port (
    clk : in std_logic;
    rst : in std_logic;
    LoadReg : in std_logic;
    Din : in t_BusWidth;
    Dout : out t_BusWidth );
end component;
	
attribute DONT_TOUCH : string;

			

signal bus_A : t_BusWidth;
signal bus_B : t_BusWidth;
signal bus_C : t_BusWidth;
signal MAR_to_RAM : t_BusWidth;
signal MDR_to_RAM : t_BusWidth;
signal RAM_to_MDR : t_BusWidth;
signal PC_to_ROM : t_BusWidth;
signal ROM_to_MBR : t_Byte;
signal CtrlStoreAddrIn : t_NextAddr;
signal MIRregister : t_MicroInstr;
signal HighBitOut : std_logic;
signal neg_ALU_to_HighBit : std_logic;
signal zero_ALU_to_HighBit : std_logic;
signal MBR_to_MPC : t_Byte;
signal DecOut : t_DecoderOut;


attribute DONT_TOUCH of bus_A : signal is "TRUE";
attribute DONT_TOUCH of bus_B : signal is "TRUE";
attribute DONT_TOUCH of MAR_to_RAM : signal is "TRUE";
attribute DONT_TOUCH of MDR_to_RAM : signal is "TRUE";
attribute DONT_TOUCH of RAM_to_MDR : signal is "TRUE";
attribute DONT_TOUCH of PC_to_ROM : signal is "TRUE";
attribute DONT_TOUCH of ROM_to_MBR : signal is "TRUE";
attribute DONT_TOUCH of CtrlStoreAddrIn : signal is "TRUE";
attribute DONT_TOUCH of MIRregister : signal is "TRUE";
attribute DONT_TOUCH of HighBitOut : signal is "TRUE";
attribute DONT_TOUCH of neg_ALU_to_HighBit : signal is "TRUE";
attribute DONT_TOUCH of zero_ALU_to_HighBit : signal is "TRUE";
attribute DONT_TOUCH of MBR_to_MPC : signal is "TRUE";
attribute DONT_TOUCH of DecOut : signal is "TRUE";


signal clk_1 : std_logic; -- falling: Control Store
signal clk_2 : std_logic; -- falling: Drive B-bus  -- rising: load from C-bus
signal clk_3 : std_logic; -- rising: highBit + ROM + RAM
signal clk_4 : std_logic; -- NA

attribute DONT_TOUCH of clk_1 : signal is "TRUE";
attribute DONT_TOUCH of clk_2 : signal is "TRUE";
attribute DONT_TOUCH of clk_3 : signal is "TRUE";
attribute DONT_TOUCH of clk_4 : signal is "TRUE";



Begin



up_clk1 <= clk_1;
up_clk2 <= clk_2;
up_clk3 <= clk_3;

tst_busB <= bus_B;
tst_busC <= bus_C;
tst_MIRreg <= MIRregister;
tst_CtrlStoreAddrIn <= CtrlStoreAddrIn;



tst_MBR_to_MPC <= MBR_to_MPC;
tst_PC_to_ROM <= PC_to_ROM;
tst_ROM_to_MBR <= ROM_to_MBR;

tst_MAR_to_RAM <= MAR_to_RAM;
tst_MDR_to_RAM <= MDR_to_RAM;
tst_RAM_to_MDR <= RAM_to_MDR;


clkDivider: clkDiv port map
(
    clk => up_Clock,
    rst => up_Reset,
    clk1 => clk_1,
    clk2 => clk_2,
    clk3 => clk_3,
    clk4 => clk_4
);     




MPC_block: MPC port map
(
    JMPC => MIRregister.Jump.JMPC,
    HighBit => HighBitOut,
    MBRIn => MBR_to_MPC,
    AddrIn => MIRregister.NextAddr,
    MPCOut => CtrlStoreAddrIn
);

Decoder_block: Decoder port map
(
    DecIn => MIRregister.Bbus,
    DecoderOut => DecOut
);

ControlStore: CtrlStore port map
(
    clk => clk_1,
    rst => up_Reset,
    Addr => CtrlStoreAddrIn,
    MIRreg => MIRregister
);


Alu: Alu_VHDL port map
(
    AluCtrl => MIRregister.AluCtrl,
    ShftCtrl => MIRregister.Shift,
    BusA => bus_A,
    BusB => bus_B,
    BusC => Bus_C, 
    Neg => neg_ALU_to_HighBit,
    Zero  => zero_ALU_to_HighBit
);


HighBit_block: HighBit port map
(
    clk => clk_3,
    rst => up_Reset,
    AluNegIn => neg_ALU_to_HighBit,
    AluZeroIn => zero_ALU_to_HighBit,
    JAMN => MIRregister.Jump.JAMN,
    JAMZ => MIRregister.Jump.JAMZ,
    HBOut => HighBitOut
);


ROM_memory: ROM port map
(
    clk => clk_3,
    rst => up_Reset,
    fetch => MIRregister.Mem.Fetch,
    Addr => PC_to_ROM,
    Dout => ROM_to_MBR
);


RAM_memory: RAM port map
(
    clk => clk_3,
    wr => MIRregister.Mem.Write,
    rd => MIRregister.Mem.Read,
    address => MAR_to_RAM,
    DIn => MDR_to_RAM,
    DOut => RAM_to_MDR
);




register_MAR: regMAR port map
(
    clk => clk_1, --Kun is sure about this !!!!!
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_MAR,
    DIn => bus_C,
    MemOut => MAR_to_RAM
);

register_MDR: regMDR port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_MDR,
    BusOut => DecOut.bit_MDR,
    wr => MIRregister.Mem.Write,
    rd => MIRregister.Mem.Read,
    DIn => bus_C,
    MemOut => MDR_to_RAM,
    MemIn => RAM_to_MDR,
    DOut => Bus_B
);



register_PC: regPC port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_PC,
    BusOut => DecOut.bit_PC,
    DIn => bus_C,
    DOut => bus_B,
    MemOut => PC_to_ROM
);

register_MBR: regMBR port map
(
    clk => clk_2,
    rst => up_Reset,
    fetch => MIRregister.Mem.Fetch,
    BusOut => DecOut.bits_MBR,
    MemIn => ROM_to_MBR,
    Dout_8 => MBR_to_MPC,
    Dout => bus_B
 );


register_SP: stdReg port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_SP,
    BusOut => DecOut.bit_SP,
    Din => bus_C,
    Dout => bus_B
);

register_LV: stdReg port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_LV,
    BusOut => DecOut.bit_LV,
    Din => bus_C,
    Dout => bus_B
);

register_CPP: stdReg port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_CPP,
    BusOut => DecOut.bit_CPP,
    Din => bus_C,
    Dout => bus_B
);

register_TOS: stdReg port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_TOS,
    BusOut => DecOut.bit_TOS,
    Din => bus_C,
    Dout => bus_B
);

register_OPC: stdReg port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_OPC,
    BusOut => DecOut.bit_OPC,
    Din => bus_C,
    Dout => bus_B
);

register_H: regH port map
(
    clk => clk_2,
    rst => up_Reset,
    LoadReg => MIRregister.Cbus.reg_H,
    Din => bus_C,
    Dout => bus_A
);

end Structural;