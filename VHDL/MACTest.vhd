library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity MACTest is

    port(
        clk     :in std_logic;
        x_in            :in     std_logic_vector(7 downto 0);
        h_in            :in    std_logic_vector(7 downto 0);
        y_out           :out   std_logic_vector(7 downto 0)

    );


end MACTest;


architecture RTL of MACTest is


component multadd
        PORT
        (
            clock0		: IN STD_LOGIC  := '1';
            dataa_0		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            dataa_1		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            dataa_2		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            dataa_3		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            datab_0		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            datab_1		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            datab_2		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            datab_3		: IN STD_LOGIC_VECTOR (7 DOWNTO 0) :=  (OTHERS => '0');
            result		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END component multadd;

begin

    MAC : multadd

    port map(
        clock0=>clk,
        dataa_0=>x_in,
        dataa_1=>h_in,
        dataa_2=>open,
        dataa_3=>open,
        datab_0=>open,
        datab_1=>open,
        datab_2=>open,
        datab_3=>open,
        result=> y_out 
    );





end RTL;