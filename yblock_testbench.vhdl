library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------
-- ENTITY --
------------

entity yblock_testbench is
end entity;


------------------
-- ARCHITECTURE --
------------------

architecture rtl of yblock_testbench is


    ----------------
    -- COMPONENTS --
    ----------------

    component yblock
    
        port (

            -- Inputs
            pclk : in std_logic;
            en   : in std_logic;
            rst  : in std_logic;

            yin  : in unsigned(7 downto 0);

            -- Outputs
            done : out std_logic

        );

    end component;


    -------------
    -- SIGNALS --
    -------------
    
    signal pclk : std_logic := '0';
    signal en   : std_logic := '1';
    signal rst  : std_logic := '0';

    signal yin  : unsigned(7 downto 0) := "00000000";
    signal done : std_logic;

begin


    -----------------------------
    -- COMPONENT INSTANTIATION --
    -----------------------------

    yblock_inst : yblock

        port map (

            pclk => pclk,
            en   => en,
            rst  => rst,

            yin  => yin,
            done  => done

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
        wait for 32 ns;
        en <= not en;
    end process;

    -- Reset
    reset : process
    begin
        wait for 150 ns;
        rst <= '1';
        wait for 1 ns;
        rst <= '0';
    end process;

    -- Input
    input1 : process(pclk)
    begin
        if rising_edge(pclk) and yin > 0 then
            yin <= yin - 1;
        elsif rising_edge(pclk) and yin < 1 then
            yin <= "00001000";
        end if;
    end process;

end architecture;