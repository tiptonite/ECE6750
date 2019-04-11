library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
package bus_multiplier_pkg is
        type bus_array is array(0 to 127 ) of unsigned(7 downto 0);
end package;
library work;
use work.bus_multiplier_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity convolution is
    port(
        clk             :in     std_logic;
        enable          :in     std_logic;
        reset           :in     std_logic;
        x_in            :in     bus_array;
        h_in            :in     bus_array;
        y_out           :out    unsigned(7 downto 0)

    );
end convolution;

architecture RTL of convolution is
    type mac_out is array (31 downto 0) of unsigned(7 downto 0);
    signal MAC_result :mac_out;
    type a_out_stage1 is array (15 downto 0) of unsigned(7 downto 0);
    signal stage1_out :a_out_stage1;
    type a_out_stage2 is array (7 downto 0) of unsigned(7 downto 0);
    signal stage2_out :a_out_stage2;
    type a_out_stage3 is array (3 downto 0) of unsigned(7 downto 0);
    signal stage3_out :a_out_stage3;
    type a_out_stage4 is array (1 downto 0) of unsigned(7 downto 0);
    signal stage4_out :a_out_stage4;
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

    component adder
        Port(
            pclk : in std_logic;
            en   : in std_logic;
            rst  : in std_logic;

            in1  : in unsigned(7 downto 0);
            in2  : in unsigned(7 downto 0);

            -- Outputs
            out1 : out unsigned(7 downto 0)

        );
    END component adder;
 
    
begin

    MAC_inst : for n in 0 to 31 generate

        MAC : multadd

        port map(
            clock0=>clk,
           dataa_0=>std_logic_vector(x_in(n*4)),
           dataa_1=>std_logic_vector(x_in(n*4+1)),
           dataa_2=>std_logic_vector(x_in(n*4+2)),
           dataa_3=>std_logic_vector(x_in(n*4+3)),
           datab_0=>std_logic_vector(h_in(n*4)),
           datab_1=>std_logic_vector(h_in(n*4+1)),
           datab_2=>std_logic_vector(h_in(n*4+2)),
           datab_3=>std_logic_vector(h_in(n*4+3)),
            unsigned(result)=> MAC_result(n)
        );
    end generate;

    ADD_inst_stage1 : for a in 0 to 15 generate

        ADD1 : adder

        port map(
            pclk=>clk,
            en=>enable,
            rst=>reset,

            in1=> MAC_result(a*2),
            in2=> MAC_result(a*2+1),

            -- Outputs
            out1=>stage1_out(a)
        ); 
    end generate;

        ADD_inst_stage2 : for a in 0 to 7 generate

        ADD2 : adder

        port map(
            pclk=>clk,
            en=>enable,
            rst=>reset,

            in1=>stage1_out(a*2),
            in2=>stage1_out(a*2+1),

            -- Outputs
            out1=>stage2_out(a)
        ); 
    end generate;

        ADD_inst_stage3 : for a in 0 to 3 generate

        ADD3 : adder

        port map(
            pclk=>clk,
            en=>enable,
            rst=>reset,

            in1=>stage2_out(a*2),
            in2=>stage2_out(a*2+1),

            -- Outputs
            out1=>stage3_out(a)
        );
    end generate;

        ADD_inst_stage4 : for a in 0 to 1 generate

        ADD4 : adder

        port map(
            pclk=>clk,
            en=>enable,
            rst=>reset,

            in1=>stage3_out(a*2),
            in2=>stage3_out(a*2+1),

            -- Outputs
            out1=>stage4_out(a)
        );
    end generate;

        ADD5 : adder
        port map(
            pclk=>clk,
            en=>enable,
            rst=>reset,

            in1=>stage4_out(0),
            in2=>stage4_out(1),

            -- Outputs
            out1=>y_out
        );


end RTL ; -- arch
























