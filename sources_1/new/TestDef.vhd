library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MicroArchitecture.all;

package TestDef is

    type t_MIC1_Test is
    record
        --debugging output signals
        busB : t_BusWidth;
        busC : t_BusWidth;
        --MIRreg : t_MicroInstr;
        
        CtrlStoreAddrIn : std_logic_vector(8 downto 0);
        
        --memory test signals
--        MAR_to_RAM : t_BusWidth;
--        MDR_to_RAM : t_BusWidth;
--        RAM_to_MDR : t_BusWidth;
        PC_to_ROM : t_BusWidth;
        ROM_to_MBR : t_Byte;
--        MBR_to_MPC : t_Byte;
        
        DecOut : t_DecoderOut;
        
    end record;
    

    
end TestDef;


package body TestDef is
end TestDef;