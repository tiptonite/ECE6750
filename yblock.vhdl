library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity yblock is


    -----------
    -- PORTS --
    -----------

    port (

        -- Inputs
        pclk : in std_logic;
        en   : in std_logic;
        rst  : in std_logic;

        yin  : in unsigned(7 downto 0);

        -- Outputs
        done : out std_logic := '0'

    );

end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of yblock is

begin


    ---------------
    -- PROCESSES --
    ---------------

    process (pclk)

        variable yin_2   : std_logic := '0';

    begin
        if rising_edge(pclk) then

            if rst = '1' then
                done <= '0';
                yin_2 := '0';
            elsif en = '1' and yin = "00000010" then
                yin_2 := '1';
            elsif en = '1' and yin = "00000001" and yin_2 = '1' then
                yin_2 := '0';
                done <= '1';
            elsif en = '1' then
                yin_2 := '0';
                done <= '0';
            end if;

        end if;
    end process;

end architecture;