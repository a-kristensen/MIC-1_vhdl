library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.MicroArchitecture.all;

entity Alu_VHDL is
port (
    AluCtrl : in t_AluCtrl;
    ShftCtrl : in t_Shift;
    BusA : in t_BusWidth;
    BusB : in t_BusWidth;
    BusC : out t_BusWidth;
    Neg : out std_logic;
    Zero : out std_logic
);
end Alu_VHDL;

architecture Behavioral of Alu_VHDL is
    signal AluOut : t_BusWidth;
begin


process (AluCtrl, BusA, BusB, AluOut)
begin
case AluCtrl is
    when ALU_A =>               AluOut <= BusA;
    when ALU_B =>               AluOut <= BusB;
    when ALU_invA =>            AluOut <= not BusA;
    when ALU_invB =>            AluOut <= not BusB;
    when ALU_AplusB =>          AluOut <= BusA + BusB;
    when ALU_AplusBplusOne =>   AluOut <= BusA + BusB + 1;
    when ALU_AplusOne =>        AluOut <= BusA + 1;
    when ALU_BplusOne =>        AluOut <= BusB + 1;
    when ALU_BminusA =>         AluOut <= BusB - BusA;
    when ALU_BminusOne =>       AluOut <= BusB - 1 ;
    when ALU_minusA =>          AluOut <= ( not BusA) + 1;
    when ALU_AandB =>           AluOut <= BusA and BusB;
    when ALU_AorB =>            AluOut <= BusA or BusB;
    when ALU_Zero =>            AluOut <= (others => '0');
    when ALU_One =>             AluOut <= (0 => '1', others => '0');
    when ALU_minusOne =>        AluOut <= (others => '1');
    when others =>              AluOut <= (others => 'Z');
end case;

if (AluOut = X"00000000") then
    Zero <= '1';
else
    Zero <= '0';
end if;

if (AluOut(AluOut'high) = '1') then
    Neg <= '1';
else
    Neg <= '0';
end if;

end process;


with ShftCtrl select BusC <=
    (AluOut(23 downto 0) & b"00000000") when SHIFT_SLL8,
    (b"0" & AluOut(31 downto 1)) when SHIFT_SRA1,
    AluOut when others;



end Behavioral;