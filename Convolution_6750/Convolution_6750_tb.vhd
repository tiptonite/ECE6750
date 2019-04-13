library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.bus_multiplier_pkg.all;

entity Convolution_6750_tb is 
end Convolution_6750_tb;

architecture test of Convolution_6750_tb is
signal CLK  : std_logic;
signal H0 :std_logic_vector(7 downto 0);
signal H1 :std_logic_vector(7 downto 0);
signal H2 :std_logic_vector(7 downto 0);
signal H3 :std_logic_vector(7 downto 0);
signal H4 :std_logic_vector(7 downto 0);
signal H5 :std_logic_vector(7 downto 0);
signal RESET :std_logic;
signal ENABLE :std_logic;

constant PERIOD : time :=20 ns;

component Convolution_6750 is
    port(

    MAX10_CLK1_50	:in	std_logic;
    KEY				:in	std_logic_vector(1 downto 0);
    HEX0				:out	std_logic_vector(7 downto 0);
    HEX1				:out	std_logic_vector(7 downto 0);
    HEX2				:out	std_logic_vector(7 downto 0);
    HEX3				:out	std_logic_vector(7 downto 0);
    HEX4				:out	std_logic_vector(7 downto 0);
    HEX5				:out	std_logic_vector(7 downto 0)


    );
end component;


begin

DUT : Convolution_6750 
    port map(
    MAX10_CLK1_50=>CLK,
    KEY(0)=>RESET,
    KEY(1)=>ENABLE,
    HEX0=>OPEN,
    HEX1=>OPEN,
    HEX2=>OPEN,
    HEX3=>OPEN,
    HEX4=>OPEN,
    HEX5=>OPEN

    );





sclk_process : process
begin
    CLK <='1';
    wait for PERIOD/2;
    CLK <='0';
    wait for PERIOD/2;
end process;

testProc : process
begin
    ENABLE<='1';
    RESET<='0';
    wait for PERIOD;
    RESET<='1';
    ENABLE<='0';
    wait for PERIOD*10;
    ENABLE<='1';
    wait;
end process testProc;

end test;
