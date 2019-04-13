library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.NUMERIC_STD.all;
library work;
use work.bus_multiplier_pkg.all;

entity Convolution_6750 is
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
end Convolution_6750;

architecture RTL of Convolution_6750 is

signal digit1 :std_logic_vector(3 downto 0) :=(others=>'0');
signal digit2 :std_logic_vector(3 downto 0):=(others=>'0');
signal digit3 :std_logic_vector(3 downto 0):=(others=>'0');
signal digit4 :std_logic_vector(3 downto 0):=(others=>'0');
signal digit5 :std_logic_vector(3 downto 0):=(others=>'0');
signal digit6 :std_logic_vector(3 downto 0):=(others=>'0');
signal num_out :std_logic_vector(23 downto 0) := (others =>'0');

signal ConvEnable :std_logic := '0';
signal ConvDone :std_logic :='0';
Signal ConvOutput  :unsigned(7 downto 0);
signal ConvInput :unsigned(7 downto 0);
Signal ConvFilter :unsigned(7 downto 0);
signal ConvStart    :std_logic := '0';

signal X :bus_array;
signal H :bus_array;


component convolution is
    port(
        clk             :in     std_logic;
        enable          :in     std_logic;
        reset           :in     std_logic;
        x_in            :in     bus_array;
        h_in            :in     bus_array;
        y_out           :out    unsigned(7 downto 0)

    );
end component;

component sevenSeg is
	port(
		clk		:in std_logic;
		num_in	:in	std_logic_vector(3 downto 0);
		seg_out	:out	std_logic_vector(7 downto 0);
		dec		:in	std_logic
	
	);
	end component;

component yblock is
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

component timer is

    port (

        -- Inputs
        clk : in std_logic;
        en   : in std_logic;
        rst  : in std_logic;
        done : in std_logic;

        -- Outputs
        out1 : out std_logic_vector(23 downto 0)

    );

end component;

component buttonDebounce is
port(

		clk	:in	std_logic;
		reset :in	std_logic;
		button	:in	std_logic;
		trigger	:out	std_logic

);
end component;

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

button : buttonDebounce
    port map(
        clk=>MAX10_CLK1_50,
		reset=> KEY(0),
		button=> KEY(1),
		trigger=>ConvEnable

    );

ConvTimer : timer
    port map(
        clk=>MAX10_CLK1_50,
        en=>ConvEnable,
        rst=> KEY(0),
        done=>ConvDone,

        -- Outputs
        out1=>num_out


    );

ConvResult : yblock
    port map(
        pclk=>MAX10_CLK1_50,
        en=>ConvEnable,
        rst=> KEY(0),

        yin=>ConvOutput,

        -- Outputs
        done=>ConvDone





    );

ConvUnit : convolution
    port map(
        clk=>MAX10_CLK1_50,
        enable=>ConvEnable,
        reset=> KEY(0),
        x_in=>X,
        h_in=>H,
        y_out=>ConvOutput





    );

ConvData :DataOutput
    port map(

        clk=>MAX10_CLK1_50,
        enable=>ConvEnable,
        reset=> KEY(0),

        x_out=>X,
        h_out=>H

    );
dig1: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit1(3 downto 0),
		seg_out(7 downto 0) =>HEX0(7 downto 0),
		dec => '0'
);

dig2: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit2(3 downto 0),
		seg_out(7 downto 0) =>HEX1(7 downto 0),
		dec => '0'
);
dig3: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit3(3 downto 0),
		seg_out(7 downto 0) =>HEX2(7 downto 0),
		dec => '0'
);
dig4: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit4(3 downto 0),
		seg_out(7 downto 0) =>HEX3(7 downto 0),
		dec => '0'
);
dig5: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit5(3 downto 0),
		seg_out(7 downto 0) =>HEX4(7 downto 0),
		dec => '0'
);
dig6: sevenSeg
	port map(
		clk => MAX10_CLK1_50,
		num_in (3 downto 0) => digit6(3 downto 0),
		seg_out(7 downto 0) =>HEX5(7 downto 0),
		dec => '0'
);



digit1(3 downto 0)<=num_out(3 downto 0);
digit2(3 downto 0)<=num_out(7 downto 4);
digit3(3 downto 0)<=num_out(11 downto 8);
digit4(3 downto 0)<=num_out(15 downto 12);
digit5(3 downto 0)<=num_out(19 downto 16);
digit6(3 downto 0)<=num_out(23 downto 20);



end RTL;