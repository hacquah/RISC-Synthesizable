----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:58 04/06/2016 
-- Design Name: 
-- Module Name:    TOP_LEVEL - Behavioral 
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

entity FETCH is
    Port (  CLK : in  STD_LOGIC;
				Reset : in STD_LOGIC;
				Instruction : out  STD_LOGIC_VECTOR (15 downto 0)
           );
end FETCH;

architecture Structural of FETCH is
constant width : integer:=16;
constant addr : integer:=4;
constant byte : integer:=8;
constant ir_addr : integer:=5;

-----PC-------
signal ena : std_logic:='1';
signal inst_adr : std_logic_vector(ir_addr-1 downto 0):=(others=>'0');

-----PT1----
signal doutb : std_logic_vector(width-1 downto 0):=(others=>'0');
signal decode : std_logic_vector(15 downto 0):=(others=>'0');

----Decode-----
--signal opcode: std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal ra: std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal rb: std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal immediate: std_logic_vector(byte-1 downto 0):=(others=>'0');

-----PT2-------
--signal opcode_pt3 :  std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal a_addr : std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal b_addr : std_logic_vector(addr-1 downto 0):=(others=>'0');
--signal imm_mux : std_logic_vector(byte-1 downto 0):=(others=>'0');

begin
	PC : entity work.PC
	generic map( addr_bits =>5)
	port map( CLK => Clk,
				 Reset=> Reset,
				 Inst_Adr => inst_adr
				 );
	Program_ROM: entity work.Program_ROM
	port map( CLKA => CLK,
				  ADDRA => inst_adr,
				  ENA => ena,
				  DOUTA => doutb );
				 
	PT1: entity work.PT1
	generic map(width=>16)
	port map( CLK => Clk,
				 RESET => Reset,
				 INSTR => doutb,
				 INSTR_OUT => decode
				 );
		
	Instruction <= decode;
end Structural;

