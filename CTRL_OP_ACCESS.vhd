----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:51 04/08/2016 
-- Design Name: 
-- Module Name:    CTRL_OP_ACCESS - Behavioral 
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

entity CTRL_OP_ACCESS is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  OPCODE : in STD_LOGIC_VECTOR(3 downto 0);
           REG_BANK_EN : out  STD_LOGIC;
           REG_BANK_WR : out  STD_LOGIC;
           REG_BANK_RE : out  STD_LOGIC
			  --WB_ADDR : out STD_LOGIC;
			  --WB_VALUE: out STD_LOGIC;
			  );
end CTRL_OP_ACCESS;

architecture Combinational of CTRL_OP_ACCESS is
--signal connecotr : std_logic_vector(4 downto 0):=(others=>'0');
--signal output : std_logic_vector(2 dowto 0):=(others=>'0');
begin
	process(CLK,OPCODE,RESET)
	variable reg_en: std_logic:='0';
	variable reg_wr: std_logic:='0';
	variable reg_re: std_logic:='0';
	begin 
			if(RESET='1' or OPCODE > "0100")then
				reg_en :='0';
			elsif rising_edge(CLK)then
				reg_en :='1';
				reg_re :='1';
				reg_wr :='0';
			else
				reg_en :='1';
				reg_re :='0';
				reg_wr :='1';
			end if;
	REG_BANK_EN <= reg_en;
	REG_BANK_RE <= reg_re;
	REG_BANK_WR <= reg_wr;
	end process;
end Combinational;

