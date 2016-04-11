----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:06 04/08/2016 
-- Design Name: 
-- Module Name:    CTRL_FPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CTRL_FPU is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  OPCODE : in STD_LOGIC_VECTOR(3 downto 0);
			  IMM_MUX_SEL : out STD_LOGIC
			 );
end CTRL_FPU;

architecture Behavioral of CTRL_FPU is
begin
	process(CLK)
	begin
		if(CLK'event and CLK='1')then
			if( unsigned(OPCODE) > "0100")then
				IMM_MUX_SEL <= '1';
			end if;
		end if;
	end process;
end Behavioral;

