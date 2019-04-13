library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.bus_multiplier_pkg.all;

entity DataOutput_tb is 
end DataOutput_tb;

architecture test of DataOutput_tb is
signal CLK  : std_logic;
signal X : bus_array;
signal H : bus_array;
signal RESET :std_logic;
signal ENABLE :std_logic;

constant PERIOD : time :=20 ns;

component DataOutput is
    port(
        clk :in std_logic;
        enable :in std_logic;
        reset :in std_logic;

        x_out :out bus_array;
        h_out :out bus_array

    );
end component;


begin

DUT : DataOutput 
    port map(
        clk=> CLK,
        enable=> ENABLE,
        reset=>RESET,

        x_out=>X,
        h_out=>H

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
    ENABLE<='0';
    RESET<='0';
    wait for PERIOD;
    RESET<='1';
    ENABLE<='1';
    wait for PERIOD*10;
    wait;
end process testProc;

end test;
