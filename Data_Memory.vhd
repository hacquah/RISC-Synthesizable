--------------------------------------------------------------
-- A simple 8*8 RAM module with dual read and single write
-- operates on opposing edges
-- 
-- by Dr Fortier
-- 
-- KEYWORD: array, concurrent processes, generic, conv_integer 
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity Data_Memory is
generic(	width:	integer:=16;
			depth:	integer:=4096;
			addr:	integer:=12);--16);
port(	Clock:		in std_logic;	
	Enable:		in std_logic;
	Read:		in std_logic;
	Write:		in std_logic;
	Address:	in std_logic_vector(addr-1 downto 0);
	Data_in: 	in std_logic_vector(width-1 downto 0);
	Data_out: 	out std_logic_vector(width-1 downto 0)

);
end Data_Memory;

--------------------------------------------------------------

architecture behavioral of Data_Memory is

-- use an array to define internal temporary signals

type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type:=((others=> (others=>'0')));

begin	
	 --tmp_ram(conv_integer(Read_AddrA))<= "00000000";	   
    -- Read Functional Section operates on rising edge
    process(Clock, Read)
    begin
	 if (Clock'event and Clock='1') then
	   if (Enable='1') then
		if (Read='1') then
		    -- built in function conv_integer change the type
		    -- from std_logic_vector to integer
		    Data_out <= tmp_ram(conv_integer(Address)); 
		else
		    Data_out <= (Data_out'range => 'Z');
		end if;
	   end if;
	end if;
    end process;
	
    -- Write Functional Section operate on falling edge
    process(Clock, Write)
    begin
	if (Clock'event and Clock='0') then
	    if Enable='1' then
		if Write='1' then
		    tmp_ram(conv_integer(Address)) <= Data_in;
		end if;
		---extra code to wrap around in case full
	    end if;
	end if;
    end process;

end behavioral;
----------------------------------------------------------------