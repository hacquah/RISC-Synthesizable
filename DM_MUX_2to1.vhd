----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:15:20 04/01/2016 
-- Design Name: 
-- Module Name:    DM_MUX_2to1 - Behavioral 
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

entity dm_mux2to1 is
    Port ( SEL  : in  STD_LOGIC;
           ALU_IN : in  STD_LOGIC_VECTOR(15 downto 0);
           DM_IN : in  STD_LOGIC_VECTOR(15 downto 0);
           WB_DATA : out STD_LOGIC_VECTOR(15 downto 0)
			  );
end dm_mux2to1;

architecture Behavioral of dm_mux2to1 is

begin

    WB_DATA <= ALU_IN when SEL='0' ELSE DM_IN;

end Behavioral;


