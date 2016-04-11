----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:53 04/07/2016 
-- Design Name: 
-- Module Name:    WRITE_BACK - Behavioral 
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

entity WRITE_BACK is
	 generic( addr_bits: integer:=16;
				 addr_size: integer:=4);
    Port ( CLK : in STD_LOGIC;
			  RESET : in STD_LOGIC;
			  ALU_RESULT : in  STD_LOGIC_VECTOR(addr_bits-1 downto 0);
           LDST_RESULT : in  STD_LOGIC_VECTOR(addr_bits-1 downto 0);
           --OPCODE_WB : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
			  
			  --WB_ADDR : out  STD_LOGIC_VECTOR (addr_size-1 downto 0);
           WB_VALUE : out  STD_LOGIC_VECTOR (addr_bits-1  downto 0)
			  );
end WRITE_BACK;

architecture Structural of WRITE_BACK is

------Data Memory ------
--signal en: std_logic:='1';
signal wr : std_logic:='0';
signal re : std_logic:='1';
-----DM Mux------
--signal sel: std_logic:='1';

signal alu_cpy : std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
signal data_out : std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
signal wb_data: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');

begin
	alu_cpy <= ALU_RESULT;
	
	DATA_MEMORY: entity work.Data_Memory
	generic map(width =>16,
					depth =>4096,--65536,
					addr =>16)
	port map(	Clock => CLK,
		Enable => '1',--en,
		Read	=> re,
		Write  => wr,
		Address => LDST_RESULT,
		Data_in  => ALU_RESULT,
		Data_out  => data_out
	);
	
	DM_MUX: entity work.dm_mux2to1 
   port map( SEL => '1',--sel,
           ALU_IN => alu_cpy,
           DM_IN => data_out,
           WB_DATA => wb_data
			  );
			  
	Reg_DM : entity work.GenReg
	generic map( num_bits=>16)
	port map( CLK => CLK,
				 RST => RESET,
				 D_IN => wb_data,
				 Q_OUT => WB_VALUE
				 );
end Structural;

