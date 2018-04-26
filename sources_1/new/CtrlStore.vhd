library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;


entity CtrlStore is
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        Addr : in t_NextAddr;
        MIRreg : out t_MicroInstr
    );
end CtrlStore;

architecture Behavioral of CtrlStore is
    --signal addrHld : std_logic_vector(8 downto 0);
    signal reg : t_NextAddr;
    
begin

process (clk, rst)
begin


    if falling_edge(clk) then
        if(rst = '1') then
            --addrHld <= b"0" & START_UP;
            reg.Addr <= START_UP;
            reg.Jmp <= '0';
        else
            reg <= Addr;
        end if;
    end if;
    
end process;


--with addrHld(7 downto 0) select MIRreg <=
with reg.Addr select MIRreg <=
--------------------------------------------------------
--   addr   | jmp |   alu    |    Cbus    | mem | Bbus |  
--------------------------------------------------------
--(0, 0, 0, 0, 0, 0, 0)                 when ,
(MAIN1, JMP_PC, ALU_BplusOne, NO_SHIFT, Cld_PC, MEM_FETCH, Bld_PC)                when MAIN1,
(MAIN1, NO_JMP, ALU_NO_OP, NO_SHIFT, Cld_NONE, MEM_NO_OP, "0000")                 when NOP1,


(IADD2, NO_JMP, ALU_BminusOne, NO_SHIFT, Cld_SP or Cld_MAR, MEM_READ, Bld_SP)     when IADD1,
(IADD3, NO_JMP, ALU_B, NO_SHIFT, Cld_H, MEM_NO_OP, Bld_TOS)                       when IADD2,
(MAIN1, NO_JMP, ALU_AplusB, NO_SHIFT, Cld_MDR or Cld_TOS, MEM_WRITE, Bld_MDR)     when IADD3,

(ISUB2, NO_JMP, ALU_BminusOne, NO_SHIFT, Cld_SP, MEM_READ, Bld_SP)                when ISUB1,
(ISUB3, NO_JMP, ALU_B, NO_SHIFT, Cld_H, MEM_NO_OP, Bld_TOS)                       when ISUB2,
(MAIN1, NO_JMP, ALU_BminusA, NO_SHIFT, Cld_MDR or Cld_TOS, MEM_WRITE, Bld_MDR)    when ISUB3,

(BIPUSH2, NO_JMP, ALU_BplusOne, NO_SHIFT, Cld_MAR or Cld_SP, MEM_NO_OP, Bld_SP)   when BIPUSH1,
(BIPUSH3, NO_JMP, ALU_BplusOne, NO_SHIFT, Cld_PC, MEM_FETCH, Bld_PC)              when BIPUSH2,
(MAIN1, NO_JMP, ALU_B, NO_SHIFT, Cld_MDR or Cld_TOS, MEM_WRITE, Bld_MBRu)         when BIPUSH3,

(ISTORE2, NO_JMP, ALU_B, NO_SHIFT, Cld_H, MEM_NO_OP, Bld_LV)                      when ISTORE1,
(ISTORE3, NO_JMP, ALU_AplusB, NO_SHIFT, Cld_MAR, MEM_NO_OP, Bld_MBRu)             when ISTORE2,
(ISTORE4, NO_JMP, ALU_B, NO_SHIFT, Cld_MDR, MEM_WRITE, Bld_TOS)                   when ISTORE3,
(ISTORE5, NO_JMP, ALU_BminusOne, NO_SHIFT, Cld_SP or Cld_MAR, MEM_READ, Bld_SP)   when ISTORE4,
(ISTORE6, NO_JMP, ALU_BplusOne, NO_SHIFT, Cld_PC, MEM_FETCH, Bld_PC)              when ISTORE5,
(MAIN1, NO_JMP, ALU_B, NO_SHIFT, Cld_TOS, MEM_NO_OP, Bld_MDR)                     when ISTORE6,

(IFLT2, NO_JMP, ALU_BminusOne, NO_SHIFT, Cld_MAR or Cld_SP, MEM_READ, Bld_SP)     when IFLT1,
(IFLT3, NO_JMP, ALU_B, NO_SHIFT, Cld_OPC, MEM_NO_OP, Bld_TOS)                     when IFLT2,
(IFLT4, NO_JMP, ALU_B, NO_SHIFT, Cld_TOS, MEM_NO_OP, Bld_MDR)                     when IFLT3,
(IFLT4, JMP_NEG, ALU_B, NO_SHIFT, Cld_NONE, MEM_NO_OP, Bld_OPC)                   when IFLT4,

(IFEQ2, NO_JMP, ALU_BminusOne, NO_SHIFT, Cld_MAR or Cld_SP, MEM_READ, Bld_SP)     when IFEQ1,
(IFEQ3, NO_JMP, ALU_B, NO_SHIFT, Cld_OPC, MEM_NO_OP, Bld_TOS)                     when IFEQ2,
(IFEQ4, NO_JMP, ALU_B, NO_SHIFT, Cld_TOS, MEM_NO_OP, Bld_MDR)                     when IFEQ3,
(MAIN1, JMP_ZERO, ALU_B, NO_SHIFT, Cld_NONE, MEM_NO_OP, Bld_OPC)                  when IFEQ4,

(TEST2, NO_JMP, ALU_BplusOne, NO_SHIFT, Cld_CPP, MEM_NO_OP, Bld_CPP)              when TEST1,   
(TEST1, NO_JMP, ALU_BplusOne, NO_SHIFT, Cld_CPP, MEM_NO_OP, Bld_CPP)              when TEST2,

(NOP1, NO_JMP, ALU_B, NO_SHIFT, Cld_NONE, MEM_FETCH, Bld_NONE)                    when START_UP,

--default
(MAIN1, NO_JMP, "000000", NO_SHIFT, Cld_NONE, MEM_NO_OP, "0000") when others;



end Behavioral;
