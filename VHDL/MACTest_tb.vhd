library IEEE;

USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
library work;
use work.bus_multiplier_pkg.all;
entity MACTest_tb is
end MACTest_tb;


architecture test of MACTest_tb is

component MACTest is
port(
        clk     :std_logic;
        x_in            :in     std_logic_vector(7 downto 0);
        h_in            :in    std_logic_vector(7 downto 0);
        y_out           :out   std_logic_vector(7 downto 0)

    );
end component;

signal CLK  : std_logic;
signal X : std_logic_vector(7 downto 0);
signal H : std_logic_vector(7 downto 0);
signal Y : std_logic_vector(7 downto 0);
signal RESET :std_logic;
signal ENABLE :std_logic;


constant PERIOD : time :=20 ns;

begin
DUT : MACTest
port map(
    clk => CLK,
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
    wait for PERIOD;
    X<="00000001";
    H<="00000001";
    wait for PERIOD*5;
    wait;
end process testProc;

end test;