library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity timer is


    -----------
    -- PORTS --
    -----------

    port (

        -- Inputs
        clk : in std_logic;
        en   : in std_logic;
        rst  : in std_logic;
        done : in std_logic;

        -- Outputs
        out1 : out unsigned(10 downto 0)

    );

end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of timer is

begin


    ---------------
    -- PROCESSES --
    ---------------

    process (clk)
        variable count : unsigned(10 downto 0) := "00000000001";
    begin
        if rising_edge(clk) then

            if rst = '1' then
                count := "00000000001";
            end if;

            if done = '1' then
                out1 <= count;
            elsif en = '1' then
                count := count + 1;
            end if;

        end if;
    end process;

end architecture;