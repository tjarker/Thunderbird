--------------------------------------------------------------------------------------------------------
-- 
-- This component produces a 3 Hz clock signal from the 100 MHz clock available on the Basys3 board.  
-- (Uses a free running 25 bit counter. The 3 Hz clock is MSB from counter, buffered using a GBUF.)
--
--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
Library UNISIM;
use UNISIM.vcomponents.all;
 
entity clock_divider is
	port(	 clk	  	:	in	std_logic;		-- clock signal from board (Basys3: 100 MHz)
			 Clock	  	:	out	std_logic);		-- The 3 Hz clock signal 
end clock_divider;

architecture Structure of clock_divider is

	signal count_present, count_next	: std_logic_vector(24 downto 0) := (others => '0') ; 
    signal Clock_int : std_logic;

begin
	
    -- a 24 bit counter is used to divide the clock. MSB is 3 Hz clock
    
	count_next <= count_present + '1';
    
    Clock_int <= count_present(24);
	
	process(clk)
	begin
		if rising_edge(clk) then
			count_present <= count_next;
		end if;
	end process;
		
    -- The clock signal from the clock_divider needs a clock-buffer
    
    BUFG_inst : BUFG
    port map (
       O => Clock, -- 1-bit output: Clock output
       I => Clock_int -- 1-bit input: Clock input
	);

end Structure;

