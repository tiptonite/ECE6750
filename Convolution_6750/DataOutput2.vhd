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


dataout :process(clk,count0,count1)
variable count1 :=127;
variable count0 := 1127;
begin
        if(rising_edge(clk) and enable ='1') then
                if(count0 /= 1) then
                    count0 := count0 - 1;
                end if;
                if (count1 /= 0) then
                    count1 := count1 - 1;
                end if;
                if(count0<=127) then
                    x_out(count0)<="00000000";
                end if;
                x_out(count1)<="00000001";
        end if;


end process;


end architecture;
