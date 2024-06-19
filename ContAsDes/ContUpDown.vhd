library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity ContadorFinal is
	
	port (  
		reloj: in  std_logic;  
		Enable: out STD_LOGIC_VECTOR (3 downto 0);
		sw1: in std_logic;
		sw2: in std_logic;
		salida: out STD_LOGIC_VECTOR (7 downto 0)  
		
	);  

end ContadorFinal;

architecture Behavioral of ContadorFinal is
--Declaración de señales

signal segundo:integer range 0 to 119999999;  
signal unidad: integer range 0 to 9;  
signal decenas: integer range 0 to 9;
signal centenas: integer range 0 to 9;  
signal bandera: std_logic_vector(2 downto 0); 
signal numero: integer  range 0 to 9;  
signal msegundo: integer range 0 to 1199999; 

--Comienzo
begin

process(unidad, decenas, centenas, reloj)

begin
	if (rising_edge(reloj)) then
		
		if (sw1 = '0' and sw2 = '0') then       --Boton de Reset!
			unidad<=0;
			decenas<=0;
			centenas<=0;
		end if;
		
		if (sw2 = '0' and sw1 = '1') then 
			if (segundo =  119999999) then       --Ciclo de un 1 segundo para 
				segundo <=0;                    --Incrementar el contador en 1 dato
				if (unidad =9) then  --Unidades
				unidad <=0; 
				else  
				unidad <= unidad +1;  
				end if;  
				if(unidad=9 ) then  
				decenas <= decenas+1;  
				end if;  
				if( decenas=9)then   --Decenas
				unidad<=unidad+1;
				end if; 
				if (decenas = 9 and unidad =9) then
				decenas<=0;
				unidad<=0;
				centenas<=centenas+1;		--Centenas
				end if;
				if(decenas=9 and unidad= 9 and centenas= 9)then  
				decenas<=0;
				unidad <=0;
				centenas<=0;
				end if;  
			else
				segundo <= (segundo) +1;
			end if; 
	   end if;
		if (sw2 = '1' and sw1 = '1') then 
		  if (segundo =  119999999) then       --Ciclo de un 1 segundo para 
				segundo <=0;        --Ciclo de un 1 segundo para 
				                   --Incrementar el contador en 1 dato
				if (unidad =0) then  --Unidades
				unidad <=9; 
				else  
				unidad <= unidad -1;  
				end if;  
				if(unidad=0 ) then  
				decenas <= decenas-1;  
				end if;  
				if( decenas=0)then   --Decenas
				unidad<=unidad-1;
				end if; 
				if (decenas = 0 and unidad =0) then
				decenas<=9;
				unidad<=9;
				centenas<=centenas-1;		--Centenas
				end if;
				if(decenas=0 and unidad= 0 and centenas= 0)then  
				decenas<=9;
				unidad <=9;
				centenas<=9;
				end if;  
			else
				segundo <= (segundo) +1;
			end if; 
	   end if;
	end if;
end process;

process (reloj, unidad, decenas, centenas)  
  
begin  
if (rising_edge(reloj))then             --Selección de que display mostrar
	if (msegundo= 699999)then            --a un poco mas de 100 FPS
		msegundo<= 0;  
		bandera<= not(bandera);  
		if( bandera = "000") then  
			numero <= unidad;  
			Enable <="1110";
			bandera<="001";
		end if;
		if (bandera = "001") then
			numero <= decenas;  
			Enable <="1101";
			bandera<="101";
		end if;
		if (bandera = "010") then
			numero <= centenas;
			Enable <= "1011";
			bandera<="000";
		end if;
	else  
		msegundo <= msegundo + 1;
	end if;
  
  		case numero is  
		when 0=> salida <= "11000000";  
		when 1=> salida <= "11111001";  
		when 2=> salida <= "10100100";  
		when 3=> salida <= "10110000";  
		when 4=> salida <= "10011001";  
		when 5=> salida <= "10010010";  
		when 6=> salida <= "10000010";  
		when 7=> salida <= "11111000";  
		when 8=> salida <= "10000000";  
		when 9=> salida <= "10011000";  
		when others => salida <="11111111";  
		  
		end case;  
end if;  
end process;  

end Behavioral;