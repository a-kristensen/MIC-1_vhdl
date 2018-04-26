library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.MicroArchitecture.all;

entity MPC is
    Port ( JMPC : in std_logic;
           HighBit : in std_logic;
           MBRIn : in t_Byte;
           AddrIn : in t_Addr;
           MPCOut : out t_NextAddr
         );
end MPC;

architecture Behavioral of MPC is
begin

MPCOut.Jmp <= HighBit;


with JMPC select MPCOut.Addr <=
    MBRIn OR AddrIn when '1',
    AddrIn when others;

end Behavioral;