----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:54:33 04/07/2016 
-- Design Name: 
-- Module Name:    DECODER - Behavioral 
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

entity DECODER is
	 generic( addr_size: integer:=4;
				 addr_bits: integer:=16);
    Port ( CLK : in STD_LOGIC;
			  RESET : in STD_LOGIC;
			  INSTRUCT_IN : in  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
			  OPCODE : out STD_LOGIC_VECTOR(addr_size-1 downto 0);
			  RA : out STD_LOGIC_VECTOR(addr_size-1 downto 0);
			  RB : out STD_LOGIC_VECTOR(addr_size-1 downto 0);
			  IMM : out STD_LOGIC_VECTOR(addr_size-1 downto 0)
			  );
end DECODER;

architecture Structural of DECODER is

begin
	
	INSTRUCTION: entity work.GenReg
	generic map( num_bits =>16)
	port map(	CLK => CLK,
					RST => RESET,
					D_IN => INSTRUCT_IN,
					Q_OUT(15 downto 12) => OPCODE,
					Q_OUT(11 downto 8) => RA,
					Q_OUT(7 downto 4) => RB,
					Q_OUT(3 downto 0) => IMM
				);

end Structural;

