library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_contador_bcd is
-- No hay puertos en el testbench
end tb_contador_bcd;

architecture Behavioral of tb_contador_bcd is
    -- Señales para el reloj, reset y salida del contador
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal bcd_out : STD_LOGIC_VECTOR(3 downto 0);

    -- Instancia del componente contador_bcd
    component contador_bcd
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               bcd_out : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin
    -- Instancia el contador en el banco de pruebas
    uut: contador_bcd Port Map(
        clk => clk,
        reset => reset,
        bcd_out => bcd_out
    );

    -- Generación de reloj con un periodo de 10 ns
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Proceso de prueba
    test_process: process
    begin
        -- Inicialización
        reset <= '1';         -- Activa el reset
        wait for 20 ns;       -- Espera 20 ns
        reset <= '0';         -- Desactiva el reset

        -- Simulación del conteo de 0 a 9
        wait for 100 ns;

        -- Activa el reset de nuevo para comprobar el reinicio
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- Espera un tiempo más para observar el comportamiento
        wait for 100 ns;

        -- Finaliza la simulación
        wait;
    end process;
end Behavioral;
