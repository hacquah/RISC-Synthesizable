----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:28 04/08/2016 
-- Design Name: 
-- Module Name:    MAIN_CONTROL - Behavioral 
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

entity MAIN_CONTROL is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  OPCODE : in STD_LOGIC_VECTOR( 3 downto 0);
			  
			  PRGRM_ROM_EN : out STD_LOGIC; --FETCH
			  
			  REG_BANK_EN : out  STD_LOGIC; --OP_ACCESS
           REG_BANK_WR : out  STD_LOGIC;
           REG_BANK_RE : out  STD_LOGIC;
			  
			  IMM_MUX_SEL : out STD_LOGIC; ---FPU
			  
			  DM_MUX_SEL : out  STD_LOGIC;   ---WRITEBACK
           DM_EN : out  STD_LOGIC;
           DM_WR : out  STD_LOGIC;
           DM_RE : out  STD_LOGIC
			  
			  );
end MAIN_CONTROL;

architecture Structural of MAIN_CONTROL is

begin
	CONTROL_FETCH: entity work.CTRL_FETCH
	port map(RESET => RESET,
				PRGRM_ROM_EN => PRGRM_ROM_EN
				);
	
	CONTROL_OP_ACCESS: entity work.CTRL_OP_ACCESS
	port map( CLK => CLK,
           RESET => RESET,
			  OPCODE => OPCODE, 
           REG_BANK_EN => REG_BANK_EN,
           REG_BANK_WR => REG_BANK_WR,
           REG_BANK_RE => REG_BANK_RE
			  );
			  
	CONTROL_FPU: entity work.CTRL_FPU
	port map(CLK => CLK,
				RESET => RESET,
				OPCODE => OPCODE,
				IMM_MUX_SEL => IMM_MUX_SEL 
				);
	
	CONTROL_WRITE_BACK: entity work.CTRL_WRITE_BACK
	port map(CLK => CLK,
			   OPCODE => OPCODE,
            RESET => RESET,
            DM_MUX_SEL => DM_MUX_SEL,
            DM_EN  => DM_EN,
            DM_WR => DM_WR,
            DM_RE => DM_RE
				);
	
end Structural;

