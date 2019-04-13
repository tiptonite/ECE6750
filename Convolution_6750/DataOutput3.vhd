library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.bus_multiplier_pkg.all;


entity DataOutput is
    port(
        clk :in std_logic;
        enable :in std_logic;
        reset :in std_logic;

        x_out :out bus_array := (127=>"00000001", others=>"00000000");
        h_out :out bus_array := (others =>("00000001"))

    );
end DataOutput;

architecture RTL of DataOutput is 

signal Ncount0 :integer := 1127;
signal Ncount1 :integer := 127;
signal count0 :integer;
signal count1 :integer;
begin
clocking :process(clk,reset)
begin
    if reset='0' then
        count0<=1127;
        count1<=127;
    elsif rising_edge(clk) then
        count0<=Ncount0;
        count1<=Ncount1;
    end if;
end process;
dataout :process(clk,count0,count1)

begin
        if(enable='1') then
                if(count0 /= 1) then
                    Ncount0 <= count0 - 1;
                end if;
                if (count1 /= 0) then
                    Ncount1 <= count1 - 1;
                end if;
                if(count0<=127) then
                    x_out(count0)<="00000000";
                end if;
                x_out(count1)<="00000001";
        end if;


end process;


end architecture;
