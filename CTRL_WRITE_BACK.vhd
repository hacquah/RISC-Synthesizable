----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:28 04/08/2016 
-- Design Name: 
-- Module Name:    CTRL_WRITE_BACK - Behavioral 
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

entity CTRL_WRITE_BACK is
    Port ( CLK : in  STD_LOGIC;
			  OPCODE : in STD_LOGIC_VECTOR(3 downto 0);
           RESET : in  STD_LOGIC;
           DM_MUX_SEL : out  STD_LOGIC;
           DM_EN : out  STD_LOGIC;
           DM_WR : out  STD_LOGIC;
           DM_RE : out  STD_LOGIC);
end CTRL_WRITE_BACK;

architecture Behavioral of CTRL_WRITE_BACK is
signal connector: std_logic_vector(5 downto 0):=(others=>'0');
signal output:std_logic_vector(2 downto 0):=(others=>'0');
begin
	connector <= RESET &CLK & OPCODE;
	process(CLK,RESET,OPCODE)
	begin 
		case connector is
			when "011001" => output <= "110";	---read on rising
			when "001010" => output <= "101";	---write on fallling
			when others => output <="000";		---reset opcode not immediate
		end case;
--		elsif(CLK'event and CLK='1')then -- only read on rising
--			if(OPCODE > "1001")then   --load
--				DM_EN <='1';
--				if(OPCODE ="1001")
--				DM_RE <='1';
--				DM_WR <='0';
--			end if;
--			if(OPCODE = "1010")then		---store
--				DM_RE <='0';
--				DM_WR <='0';
--		end if;
		if(OPCODE > "1000")then
			DM_MUX_SEL <= '1';
		else
			DM_MUX_SEL <='0';
		end if;
	end process;
		DM_EN <= output(2);
		DM_RE <= output(1);
		DM_WR <= output(0);
end Behavioral;

