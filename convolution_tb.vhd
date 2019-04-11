library IEEE;

USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
library work;
use work.bus_multiplier_pkg.all;
entity convolution_tb is
end convolution_tb;


architecture test of convolution_tb is

component convolution is
port(
        clk             :in     std_logic;
        enable          :in     std_logic;
        reset           :in     std_logic;
        x_in            :in     bus_array;
        h_in            :in     bus_array;
        y_out           :out unsigned(7 downto 0)

    );
end component;

signal CLK  : std_logic;
signal X : bus_array;
signal H : bus_array;
signal Y : unsigned(7 downto 0) := (others=>'0');
signal RESET :std_logic;
signal ENABLE :std_logic;


constant PERIOD : time :=20 ns;

begin
DUT : convolution
port map(
    clk => CLK,
    enable=>ENABLE,
    reset=>RESET,
    x_in => X,
    h_in => H,
    y_out=> Y




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
    H<=(others=>"00000001");
    X<=(0=>"00000000",others=>"00000001");
    wait for PERIOD;
    X<=(others=>"00000001");
    wait for PERIOD;
    wait;
end process testProc;

end test;