library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity adder_testbench is
end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of adder_testbench is


    ----------------
    -- COMPONENTS --
    ----------------

    component adder
    
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

    end component;


    -------------
    -- SIGNALS --
    -------------
    
    signal pclk : std_logic := '0';
    signal en   : std_logic := '0';
    signal rst  : std_logic := '0';

    signal in1  : unsigned(7 downto 0) := "00000000";
    signal in2  : unsigned(7 downto 0) := "00000000";
    signal out1 : unsigned(7 downto 0);

begin


    -----------------------------
    -- COMPONENT INSTANTIATION --
    -----------------------------

    adder_inst : adder

        port map (

            pclk => pclk,
            en   => en,
            rst  => rst,

            in1  => in1,
            in2  => in2,
            out1 => out1

        );


    ---------------
    -- PROCESSES --
    ---------------

    -- Clock generator
    clock : process
    begin
        wait for 1 ns;
        pclk <= not pclk;
    end process;

    -- Enable
    enable : process
    begin
        wait for 10 ns;
        en <= not en;
    end process;

    -- Reset
    reset : process
    begin
        wait for 15 ns;
        rst <= '1';
        wait for 1 ns;
        rst <= '0';
    end process;

    -- Input 1
    input1 : process
    begin
        wait for 2 ns;
        in1 <= not in1;
    end process;

    -- Input 2
    input2 : process
    begin
        wait for 1 ns;
        in2 <= not in2;
    end process;

end architecture;