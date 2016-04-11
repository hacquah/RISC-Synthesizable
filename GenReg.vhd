----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:59:23 04/07/2016 
-- Design Name: 
-- Module Name:    GenReg - Behavioral 
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

entity GenReg is
	 generic(		num_bits : integer:=16);
    port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           D_IN : in  STD_LOGIC_VECTOR (num_bits-1 downto 0);
           Q_OUT : out  STD_LOGIC_VECTOR (num_bits-1 downto 0)
			  );
end GenReg;

architecture Behavioral of GenReg is
begin
	Process(CLK,RST)
	begin
		if(RST='1') then
			Q_OUT <= (others=>'0');
		elsif(CLK'event and CLK = '0') then
			Q_OUT <= D_IN;
		end if;
	end process;
end Behavioral;

