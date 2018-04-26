library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

package MicroArchitecture is

    subtype t_BusWidth is std_logic_vector(31 downto 0);
    subtype t_Byte is std_logic_vector(7 downto 0);

    subtype t_Addr is std_logic_vector(7 downto 0);
    --subtype t_Jump is std_logic_vector(2 downto 0);
    subtype t_AluCtrl is std_logic_vector(5 downto 0);
    subtype t_Shift is std_logic_vector(1 downto 0);
    --subtype t_Cbus is std_logic_vector(8 downto 0);
    --subtype t_Mem is std_logic_vector(2 downto 0);
    subtype t_Bbus is std_logic_vector(3 downto 0);

    type t_NextAddr is
    record
        Jmp : std_logic;
        Addr : t_Addr;
    end record;


--type t_Addr is (
--    START_UP,
--    MAIN1,
--    NOP1,
--    IADD1, IADD2, IADD3,
--    IAND1, IAND2, IAND3,
--    IOR1, IOR2, IOR3,
--    DUP1, DUP2,
--    POP1, POP2, POP3,
--    SWAP1, SWAP2, SWAP3, SWAP4, SWAP5, SWAP6,
--    BIPUSH1, BIPUSH2, BIPUSH3,
--    ILOAD1, ILOAD2, ILOAD3, ILOAD4, ILOAD5,
--    ISTORE1, ISTORE2, ISTORE3, ISTORE4, ISTORE5, ISTORE6,
--    IFLT1, IFLT2, IFLT3, IFLT4,
--    IFEQ1, IFEQ2, IFEQ3, IFEQ4,
--    ISUB1, ISUB2, ISUB3,
--    TEST1, TEST2
--);

--attribute enum_encoding : string;
--attribute enum_encoding of t_Addr : type is
--    "00000001" &                    --startup
--    "00000010" &                    --main1
--    "00000011" &                    --nop1
--    "00000100 00000101 00000110" &  --iadd
--    "00000111 00001000 00001001" &  --iand
--    "00001010 00001011 00001100" &  --ior
--    "00001101 00001110" &           --dup
--    "00001111 00010000 00010001" &  --pop
--    "00010010 00010011 00010100 00010101 00010110 00010111" &
--    "00011000 00011001 00011010" &
--    "00011011 00011100 00011101 00011110 00011111" &
--    "00100000 00100001 00100010 00100011 00100100 00100101" &
--    "00100110 00100111 00101000 00101001" &
--    "00101010 00101011 00101100 00101101" &
--    "00101110 00101111 00110000" &
--    "00110001 00110010" ;


    type t_Jump is
    record
        JMPC : std_logic;
        JAMN : std_logic;
        JAMZ : std_logic;
    end record;
    
    type t_Cbus is
    record
        reg_MAR : std_logic;
        reg_MDR : std_logic;
        reg_PC : std_logic;
        reg_SP : std_logic;
        reg_LV : std_logic;
        reg_CPP : std_logic;
        reg_TOS : std_logic;
        reg_OPC : std_logic;
        reg_H : std_logic;
    end record;
    
    type t_Mem is
    record
        Write : std_logic;
        Read : std_logic;
        Fetch : std_logic;
    end record;
    

    type t_MicroInstr is
    record
        NextAddr : t_Addr;
        Jump : t_Jump;
        AluCtrl : t_AluCtrl;
        Shift : t_Shift;
        Cbus : t_Cbus;
        Mem : t_Mem;
        Bbus : t_Bbus;
    end record;

    type t_MBRBusOut is
    record
        bit_MBRu : std_logic;
        bit_MBRs : std_logic;
    end record;

    type t_DecoderOut is
    record
        bit_MDR : std_logic;
        bit_PC : std_logic;
        bits_MBR : t_MBRBusOut;
        bit_SP : std_logic;
        bit_LV : std_logic;
        bit_CPP : std_logic;
        bit_TOS : std_logic;
        bit_OPC : std_logic; 
    end record;

                                --  MAR  MDR  PC   SP   LV   CPP  TOS  OPC   H
    constant Cld_NONE : t_Cbus  := ('0', '0', '0', '0', '0', '0', '0', '0', '0');
    constant Cld_MAR : t_Cbus   := ('1', '0', '0', '0', '0', '0', '0', '0', '0');
    constant Cld_MDR : t_Cbus   := ('0', '1', '0', '0', '0', '0', '0', '0', '0');
    constant Cld_PC : t_Cbus    := ('0', '0', '1', '0', '0', '0', '0', '0', '0');
    constant Cld_SP : t_Cbus    := ('0', '0', '0', '1', '0', '0', '0', '0', '0');
    constant Cld_LV : t_Cbus    := ('0', '0', '0', '0', '1', '0', '0', '0', '0');
    constant Cld_CPP : t_Cbus   := ('0', '0', '0', '0', '0', '1', '0', '0', '0');
    constant Cld_TOS : t_Cbus   := ('0', '0', '0', '0', '0', '0', '1', '0', '0');
    constant Cld_OPC : t_Cbus   := ('0', '0', '0', '0', '0', '0', '0', '1', '0');
    constant Cld_H : t_Cbus     := ('0', '0', '0', '0', '0', '0', '0', '0', '1');







    constant START_UP   : t_Addr := "00000011";

    constant MAIN1      : t_Addr := X"00";
    constant NOP1       : t_Addr := X"01";
    
    constant IADD1      : t_Addr := X"0A";
    constant IADD2      : t_Addr := X"0B";
    constant IADD3      : t_Addr := X"0C";
    
    constant IAND1      : t_Addr := X"0D";
    constant IAND2      : t_Addr := X"0E";
    constant IAND3      : t_Addr := X"0F";
    
    constant IOR1       : t_Addr := X"20";
    constant IOR2       : t_Addr := X"21";
    constant IOR3       : t_Addr := X"22";
    
    constant DUP1       : t_Addr := X"23";
    constant DUP2       : t_Addr := X"24";
    
    constant POP1       : t_Addr := X"25";
    constant POP2       : t_Addr := X"26";
    constant POP3       : t_Addr := X"27";
    
    constant SWAP1      : t_Addr := X"28";
    constant SWAP2      : t_Addr := X"29";
    constant SWAP3      : t_Addr := X"2A";
    constant SWAP4      : t_Addr := X"2B";
    constant SWAP5      : t_Addr := X"2C";
    constant SWAP6      : t_Addr := X"2D";
    
    constant BIPUSH1    : t_Addr := X"2E";
    constant BIPUSH2    : t_Addr := X"2F";
    constant BIPUSH3    : t_Addr := X"30";
    
    constant ILOAD1     : t_Addr := X"31";
    constant ILOAD2     : t_Addr := X"32";
    constant ILOAD3     : t_Addr := X"33";
    constant ILOAD4     : t_Addr := X"34";
    constant ILOAD5     : t_Addr := X"35";
    
    constant ISTORE1    : t_Addr := X"36";
    constant ISTORE2    : t_Addr := X"37";
    constant ISTORE3    : t_Addr := X"38";
    constant ISTORE4    : t_Addr := X"39";
    constant ISTORE5    : t_Addr := X"3A";
    constant ISTORE6    : t_Addr := X"3B";
    
    constant IFLT1      : t_Addr := X"3C";
    constant IFLT2      : t_Addr := X"3D";
    constant IFLT3      : t_Addr := X"3E";
    constant IFLT4      : t_Addr := X"3F";

    constant IFEQ1      : t_Addr := X"40";
    constant IFEQ2      : t_Addr := X"41";
    constant IFEQ3      : t_Addr := X"42";
    constant IFEQ4      : t_Addr := X"43";
    
    constant ISUB1      : t_Addr := X"44";
    constant ISUB2      : t_Addr := X"45";
    constant ISUB3      : t_Addr := X"46";
    
    constant TEST1      : t_Addr := X"AA";
    constant TEST2      : t_Addr := X"AB";



    constant NO_JMP     : t_Jump := ('0','0','0');
    constant JMP_PC     : t_Jump := ('1','0','0');
    constant JMP_NEG    : t_Jump := ('0','1','0');
    constant JMP_ZERO   : t_Jump := ('0','0','1');

    constant ALU_A 			   : t_AluCtrl := "000000";
    constant ALU_B			   : t_AluCtrl := "000001";
    constant ALU_invA		   : t_AluCtrl := "000010";
    constant ALU_invB		   : t_AluCtrl := "000011";
    constant ALU_AplusB		   : t_AluCtrl := "000100";
    constant ALU_AplusBplusOne : t_AluCtrl := "000101";
    constant ALU_AplusOne	   : t_AluCtrl := "000110";
    constant ALU_BplusOne	   : t_AluCtrl := "000111";
    constant ALU_BminusA	   : t_AluCtrl := "001000";
    constant ALU_BminusOne	   : t_AluCtrl := "001001";
    constant ALU_minusA		   : t_AluCtrl := "001010";
    constant ALU_AandB		   : t_AluCtrl := "001011";
    constant ALU_AorB		   : t_AluCtrl := "001100";
    constant ALU_Zero		   : t_AluCtrl := "001101";  
    constant ALU_One		   : t_AluCtrl := "001110";  
    constant ALU_minusOne	   : t_AluCtrl := "001111";
    constant ALU_NO_OP         : t_AluCtrl := "111111";

    constant NO_SHIFT	   : t_Shift := "00";
    constant SHIFT_SLL8	   : t_Shift := "01";
    constant SHIFT_SRA1	   : t_Shift := "10";

--    constant MEM_NO_OP	   : t_Mem := "000";
--    constant MEM_WRITE	   : t_Mem := "100";
--    constant MEM_READ	       : t_Mem := "010";
--    constant MEM_FETCH       : t_Mem := "001";

    constant MEM_NO_OP	   : t_Mem := ('0','0','0');
    constant MEM_WRITE	   : t_Mem := ('1','0','0');
    constant MEM_READ	   : t_Mem := ('0','1','0');
    constant MEM_FETCH     : t_Mem := ('0','0','1');

    constant Bld_NONE    : t_Bbus := "1111";
    constant Bld_MDR     : t_Bbus := "0000";
    constant Bld_PC      : t_Bbus := "0001";
    constant Bld_MBRu    : t_Bbus := "0010";
    constant Bld_MBRs    : t_Bbus := "0011";
    constant Bld_SP      : t_Bbus := "0100";
    constant Bld_LV      : t_Bbus := "0101";
    constant Bld_CPP     : t_Bbus := "0110";
    constant Bld_TOS     : t_Bbus := "0111";
    constant Bld_OPC     : t_Bbus := "1000";

    --the prototype that is seen by other entities
    function "OR" (a, b : t_Cbus) return t_Cbus;

--    function "OR" (a, b : t_Addr) return t_Addr;

end MicroArchitecture;
package body MicroArchitecture is

    --this is a "or" operator overload function for the type: t_Cbus
    function "OR" (a, b : t_Cbus) return t_Cbus is
    begin
    return (
        a.reg_MAR or b.reg_MAR,
        a.reg_MDR or b.reg_MDR,
        a.reg_PC or b.reg_PC,
        a.reg_SP or b.reg_SP,
        a.reg_LV or b.reg_LV,
        a.reg_CPP or b.reg_CPP,
        a.reg_TOS or b.reg_TOS,
        a.reg_OPC or b.reg_OPC,
        a.reg_H or b.reg_H );
    end "OR";



--    function "OR" (a, b : t_Addr) return t_Addr is
--    begin
--    return  t_Addr'val(to_integer(unsigned(
--        std_logic_vector(to_unsigned(t_Addr'pos(a), 8)) or 
--        std_logic_vector(to_unsigned(t_Addr'pos(b), 8))
--         )))
--        ;
--    end "OR";




end MicroArchitecture;