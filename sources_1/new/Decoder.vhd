library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

entity Decoder is
    Port ( DecIn : in std_logic_vector(3 downto 0);
           DecoderOut : out t_DecoderOut
         );
end Decoder;

architecture Behavioral of Decoder is
begin

    with DecIn select DecoderOut <=
        ('1', '0', ('0', '0'), '0', '0', '0', '0', '0') when Bld_MDR,
        ('0', '1', ('0', '0'), '0', '0', '0', '0', '0') when Bld_PC,
        ('0', '0', ('1', '0'), '0', '0', '0', '0', '0') when Bld_MBRu,
        ('0', '0', ('0', '1'), '0', '0', '0', '0', '0') when Bld_MBRs,
        ('0', '0', ('0', '0'), '1', '0', '0', '0', '0') when Bld_SP,
        ('0', '0', ('0', '0'), '0', '1', '0', '0', '0') when Bld_LV,
        ('0', '0', ('0', '0'), '0', '0', '1', '0', '0') when Bld_CPP,
        ('0', '0', ('0', '0'), '0', '0', '0', '1', '0') when Bld_TOS,
        ('0', '0', ('0', '0'), '0', '0', '0', '0', '1') when Bld_OPC,
        ('0', '0', ('0', '0'), '0', '0', '0', '0', '0') when others;

end Behavioral;