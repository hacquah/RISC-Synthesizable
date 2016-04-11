----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:53 04/07/2016 
-- Design Name: 
-- Module Name:    FPU - Behavioral 
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

entity FPU is
	 generic ( addr_size: integer:=4;
				  addr_bits: integer:=16);
    Port ( CLK : in STD_LOGIC;
			  RESET : in STD_LOGIC;
			  OPCODE : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
			  RA_VAL : in  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           RB_VAL : in  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           IMMEDIATE : in  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
			  
           ALU_OUT : out  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
           LDST_OUT : out  STD_LOGIC_VECTOR (addr_bits-1 downto 0);
			  CCR : out STD_LOGIC_VECTOR (addr_size-1 downto 0)
			  );
end FPU;

architecture Structural of FPU is
-----MUX----
signal mux_sel: std_logic:='1';
signal mux_out: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');

-----ALU----
signal alu_value: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');
signal ldst_value: std_logic_vector(addr_bits-1 downto 0):=(others=>'0');


begin
	ALU: entity work.ALU
	port map( CLK      => CLK,
				 RA       => RA_VAL,
             RB       => mux_out,
             OPCODE   => OPCODE,
				 
             CCR      => CCR,
             ALU_OUT  => alu_value,
             LDST_OUT => ldst_value
				 );
				 
	IMM_MUX : entity work.mux_2TO1
   generic map( num_bits=>16)
	port map( SEL => mux_sel,
				 IN_1 => RB_VAL,
				 IN_2 => IMMEDIATE,
				 MOUT => mux_out
				 );	
				 
	Reg_ALU_OUT: entity GenReg
	generic map( num_bits=>16)
	port map( CLK => CLK,
				 RST => RESET,
				 D_IN => alu_value,
				 Q_OUT => ALU_OUT
				 );
				 
	Reg_LDST_OUT: entity GenReg
	generic map( num_bits=>16)
	port map( CLK => CLK,
				 RST => RESET,
				 D_IN => ldst_value,
				 Q_OUT => LDST_OUT
				 );

end Structural;

