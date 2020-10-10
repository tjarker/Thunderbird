--------------------------------------------------------------------------------------------------------
-- This component synchronizes input signals from the outside world.
-- Needed to avoid metastability in the FSM state register D-flip-flops (more in cource 02139).
--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity input_synchronizer is
	port(	clock	:	in	std_logic;		-- Clock signal in (fast 50Mhz clock)
			Brake	: 	in 	std_logic;		-- Brake signal in
			Left	: 	in 	std_logic;		-- Left turn signal in
			Right	: 	in 	std_logic;		-- Right turn signal in
			Hazard	: 	in 	std_logic;		-- Hazard signal in
			Res		:	in	std_logic;		-- Reset signal in
			B		: 	out std_logic;		-- Brake signal out
			L		: 	out std_logic;		-- Left turn signal out
			R		: 	out std_logic;		-- Right turn signal out
			H		: 	out std_logic;		-- Hazard signal out
			Reset	:	out	std_logic);		-- Reset signal out
end input_synchronizer;

architecture Structure of input_synchronizer is

begin

-----------------------------------------------------------------------
-- Process statement which generate a Flip-Flop (registor) 
-- for each input/output signal
-----------------------------------------------------------------------
 
process(clock)
begin
	if rising_edge(clock) then		-- Registers update on every rising edge for the clock signal
		Reset	<= Res;
		B 		<= Brake;
		L 		<= Left;
		R		<= Right;
		H		<= Hazard;
	end if;
end process;

end Structure;