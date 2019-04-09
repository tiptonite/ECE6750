library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity adder is


    -----------
    -- PORTS --
    -----------

    port (

        -- Inputs
        pclk : in std_logic;
        en   : in std_logic;
        rst  : in std_logic;

        in1  : in unsigned(7 downto 0);
        in2  : in unsigned(7 downto 0);

        -- Outputs
        out1 : out unsigned(7 downto 0)

    );

end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of adder is

begin


    ---------------
    -- PROCESSES --
    ---------------

    process (pclk)
    begin
        if rising_edge(pclk) then

            if rst = '1' then
                out1 <= "00000000";
            elsif en = '1' then
                out1 <= in1 + in2;
            end if;

        end if;
    end process;

end architecture;