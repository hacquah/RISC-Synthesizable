----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:38:24 04/07/2016 
-- Design Name: 
-- Module Name:    OP_ACCESS - Behavioral 
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

entity OP_ACCESS is
	 generic( addr_bits: integer:=16;
				 addr_size: integer:=4);
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           OPCODE_IN : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
           RA : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
           RB : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
           IMM_IN : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
           RA_VALUE : out  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           RB_VALUE : out  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           IMM_OUT : out  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           OPCODE_OUT : out  STD_LOGIC_VECTOR(addr_size-1 downto 0)
			  );
end OP_ACCESS;

architecture Structural of OP_ACCESS is
--signal reg_en,reg_re: std_logic:='1';
--signal reg_we: std_logic:='0';
signal reg_wr_addr: std_logic_vector(addr_size-1 downto 0):=(others=>'0');

--- Reg_A and Reg_B -----
signal ra_val: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
signal rb_val: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');

signal IMM_OP: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
signal info: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
--signal data_in: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
begin
	IMM_OP <= x"00" & OPCODE_IN & IMM_IN;
	
	REG_BANK: entity work.Reg_Bank
	generic map( width=>16,
					 depth=>16,
					 addr=>4)
	port map( Clock => CLK,
				 Enable => '1',--reg_en,
				 Read => '1',
				 Write => '0',--reg_we,
				 Read_AddrA => RA,
				 Read_AddrB => RB,
				 Write_AddrA => reg_wr_addr,
				 Data_inA => x"0000",--data_in,
				 Data_outA => ra_val,
				 Data_outB => rb_val
				 );
	Reg_A: entity work.GenReg
	generic map( num_bits=>16)
	port map( CLK => CLK,
				 RST => RESET,
				 D_IN => ra_val,
				 Q_OUT => RA_VALUE
				 );
				 
	Reg_B: entity work.GenReg
	generic map( num_bits=>16)
	port map( CLK => CLK,
				 RST => RESET,
				 D_IN => rb_val,
				 Q_OUT => RB_VALUE 
				 );

	Reg_OP_IMM: entity work.GenReg
	generic map( num_bits=>16)
	port map ( CLK => CLK,
				  RST => RESET,
				  D_IN => IMM_OP,
				  Q_OUT(15 downto 8) =>info, ---dummy signal to make opcode and imm route
				  Q_OUT(7 downto 4) => OPCODE_OUT,
				  Q_OUT(3 downto 0) => IMM_OUT
				  );

end Structural;

