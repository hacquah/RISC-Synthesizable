----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:44:22 04/08/2016 
-- Design Name: 
-- Module Name:    CTRL_FETCH - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CTRL_FETCH is
    Port ( RESET : in STD_LOGIC;
			  PRGRM_ROM_EN : out STD_LOGIC
			 );
end CTRL_FETCH;

architecture Behavioral of CTRL_FETCH is

begin
	process(RESET)
	begin
		if(RESET='1')then
			PRGRM_ROM_EN <='0';
		else
			PRGRM_ROM_EN <='1';
		end if;
	end process;
end Behavioral;

