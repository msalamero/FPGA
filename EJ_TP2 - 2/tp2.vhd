----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:21 05/17/2024 
-- Design Name: 
-- Module Name:    tp2 - Behavioral 
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

entity Control is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           motor : out STD_LOGIC;
           lampara : out STD_LOGIC);
end Control;

architecture Behavioral of Control is
begin
    process(a, b, c)
    variable count: integer := 0;
    begin
        count := 0;
        
        if (a = '1') then
            count := count + 1;
        end if;
        
        if (b = '1') then
            count := count + 1;
        end if;
        
        if (c = '1') then
            count := count + 1;
        end if;
        
        case count is
            when 0 =>
                motor <= '0';
                lampara <= '0';
            when 1 =>
                motor <= '0';
                lampara <= '1';
            when 2 =>
                motor <= '1';
                lampara <= '1';
            when 3 =>
                motor <= '1';
                lampara <= '0';
            when others =>
                motor <= '0';
                lampara <= '0';
        end case;
    end process;
end Behavioral;