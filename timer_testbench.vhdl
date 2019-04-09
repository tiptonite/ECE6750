library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity timer_testbench is
end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of timer_testbench is


    ----------------
    -- COMPONENTS --
    ----------------

    component timer
    
        port (

            -- Inputs
            clk  : in std_logic;
            en   : in std_logic;
            rst  : in std_logic;
            done : in std_logic;

            -- Outputs
            out1 : out unsigned(10 downto 0)

        );

    end component;


    -------------
    -- SIGNALS --
    -------------
    
    signal clk  : std_logic := '0';
    signal en   : std_logic := '1';
    signal rst  : std_logic := '0';
    signal done : std_logic := '0';

    signal out1 : unsigned(10 downto 0);

begin


    -----------------------------
    -- COMPONENT INSTANTIATION --
    -----------------------------

    timer_inst : timer

        port map (

            clk  => clk,
            en   => en,
            rst  => rst,
            done => done,

            out1 => out1

        );


    ---------------
    -- PROCESSES --
    ---------------

    -- Clock generator
    clock : process
    begin
        wait for 1 ns;
        clk <= not clk;
    end process;

    -- Enable
    enable : process
    begin
        wait for 25 ns;
        en <= not en;
    end process;

    -- Reset
    reset : process
    begin
        wait for 40 ns;
        rst <= '1';
        wait for 2 ns;
        rst <= '0';
    end process;

    -- Input 1
    input1 : process
    begin
        wait for 10 ns;
        done <= not done;
    end process;

end architecture;