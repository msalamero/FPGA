library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_bcd is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           bcd_out : out STD_LOGIC_VECTOR (3 downto 0));
end contador_bcd;

architecture Behavioral of contador_bcd is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= "0000"; 
        elsif rising_edge(clk) then
            if count = "1001" then -- contador en 9
                count <= "0000"; 
            else
                count <= count + 1; 
            end if;
        end if;
    end process;

    bcd_out <= count; 
end Behavioral;
