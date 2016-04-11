---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2014
-- Module Name:    MUX_2to1
-- Project Name:   CLOCK COUNTER
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    2 Select MUX
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2TO1 is
	 generic( num_bits: integer:=16);
    Port ( SEL  : in  STD_LOGIC;
           IN_1 : in  STD_LOGIC_VECTOR(num_bits-1 downto 0);
           IN_2 : in  STD_LOGIC_VECTOR(num_bits-1 downto 0);
           MOUT : out STD_LOGIC_VECTOR(num_bits-1 downto 0)
			  );
end mux_2to1;

architecture Behavioral of mux_2to1 is
--signal RB_FIN : std_logic_vector(15 downto 0):=(others=>'0');
--RB_FIN  <= x"00" & RB_IN;
begin

    MOUT <= IN_1 when SEL='0' ELSE x"00" & IN_1 & IN_2 ;

end Behavioral;

