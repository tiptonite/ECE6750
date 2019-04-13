library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buttonDebounce is
port(

		clk	:in	std_logic;
		reset :in	std_logic;
		button	:in	std_logic;
		number	:out	unsigned(23 downto 0);
		add		:in	std_logic_vector(9 downto 0)


);
end buttonDebounce;

architecture RTL of buttonDebounce is
type state is (IDLE,COUNT,COUNT2,TRIG,ACC);
signal PS :state;
signal NS :state;
signal done :std_logic;
signal timer :unsigned(31 downto 0):=(others=>'0');
signal accumulate :unsigned(23 downto 0) := (others=>'0');
signal nexttimer :unsigned(15 downto 0) :=(others =>'0');
signal extend :unsigned(23 downto 0) := (others =>'0');
begin
accState :process(clk,reset)
	begin
	if reset='0' then
		PS<=IDLE;
	
		accumulate<=(others=>'0');
	
	elsif rising_edge(clk) then
		PS <= NS;
		if(PS=ACC) then
			accumulate<=accumulate+unsigned(add);
		end if;
	end if;
end process accState;
		
debounce: process(button,PS,reset,timer)
variable added :integer :=0;
	begin
		
			case PS is
				when IDLE =>
					
					if(button='0') then
						NS<=COUNT;
					else
						NS<=IDLE;
						
					end if;
				when COUNT=>
					if timer=X"0000FFFF" then
						NS<=TRIG;
						
					else
						NS<=COUNT;
					
					end if;
				when TRIG=>
					if(button='1') then
						NS<=COUNT2;
					else
						NS<=TRIG;
					end if;
--				when COUNT =>
--					if(done='1') then
--						if(button='0') then
--							NS<=ACC;
--						else
--							NS<=COUNT;
--						end if;
--					else
--						NS<=COUNT;
--					end if;
				when COUNT2=>
					if timer=X"0000FFFF" then
						NS<=ACC;
						
					else
						NS<=COUNT2;
						
					end if;
				when ACC =>
						NS<=IDLE;
						
						--accumulate<=accumulate+unsigned(add);
						
						
				end case;
			
			
		end process debounce;
		
counter:process(clk,PS)
begin
if PS=COUNT or PS=COUNT2 then
	if rising_edge(clk) then
		if timer/=X"FFFF" then
			timer<=timer+1;
	
	end if;
	end if;
	
else 
	
	timer<=X"00000000";
end if;
	

end process counter;

number(23 downto 0)<=accumulate(23 downto 0);




end architecture RTL;