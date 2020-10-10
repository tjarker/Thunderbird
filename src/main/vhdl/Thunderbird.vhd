library ieee;
use ieee.std_logic_1164.all;

entity Thunderbird is
    port(

        clock       :   in      std_logic; -- clock input
        reset       :   in      std_logic; -- reset input
        io_L        :   in      std_logic; -- left turn signal
        io_R        :   in      std_logic; -- right turn signal
        io_H        :   in      std_logic; -- hazard signal
        io_B        :   in      std_logic; -- brake signal
        io_Lo       :   out     std_logic_vector(2 downto 0); -- left tail light
        io_Ro       :   out     std_logic_vector(2 downto 0)  -- right tail light

    );
end entity;

architecture struct of Thunderbird is

    component clock_divider is
        port(	 
                clk	  	:	in	std_logic;		
                Clock	:	out	std_logic
        );		
    end component;

    component input_synchronizer is
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
    end component;

    -- definition of states and state signals
    type states is (idle, leftTurn, rightTurn, hazard);
    signal state, nextState : states;

    -- declaration of remaining signals
    signal turn, nextTurn, allLow, allHigh : std_logic_vector(2 downto 0);
    signal iClk, res, L, R, H, B : std_logic;

begin

    -- instantiation of the clock divider
    clkDiv: clock_divider port map(clk=>clock, Clock=>iClk);
    -- instantiation of the input synchronizer stage
    sync: input_synchronizer port map(clock=>clock, Brake=>io_B, Left=>io_L, Right=>io_R, Hazard=>io_H, Res=>reset, B=>B, L=>L, R=>R, H=>H, Reset=>res);

    -- all lights turned on/off signals
    allLow <= "000";
    allHigh <= "111";

    -- next state of the turn sequence register
    nextTurn <= allLow                  when state=idle or (turn=allHigh and (state=leftTurn or state=rightTurn)) else
                turn(1 downto 0) & '1'  when (state=leftTurn or state=rightTurn) else
                turn;

    -- tail light control
    process(state,turn) begin
        case state is
            when idle =>
                if(H='0' and B='1') then
                    io_Lo <= allHigh;
                    io_Ro <= allHigh;
                else
                    io_Lo <= allLow;
                    io_Ro <= allLow;
                end if;
            when leftTurn =>
                io_Lo <=    turn;
                if(B='1') then
                    io_Ro <= allHigh;
                else
                    io_Ro <= allLow;
                end if;
            when rightTurn =>
                if(B='1') then
                    io_Lo <= allHigh;
                else
                    io_Lo <= allLow;
                end if;        
                io_Ro <=    turn;
            when hazard =>
                io_Lo <=    allHigh;
                io_Ro <=    allHigh;
        end case;
    end process;

    -- state control
    process(state) begin
        case state is 
            when idle =>
                if(H='1') then
                    nextState <= hazard;
                elsif(R='1') then
                    nextState <= rightTurn;
                elsif(L='1') then
                    nextState <= leftTurn;
                else
                    nextState <= idle;
                end if;    
            when leftTurn =>
                if(H='1') then
                    nextState <= hazard;
                elsif(L='0') then
                    nextState <= idle;
                else
                    nextState <= leftTurn;
                end if;
            when rightTurn =>
                if(H='1') then
                    nextState <= hazard;
                elsif(R='0') then
                    nextState <= idle;
                else
                    nextState <= rightTurn;
                end if;
            when hazard =>
                nextState <= idle;
        end case;
    end process;

    -- sequential update of state elements
    process(iClk) begin
        if(rising_edge(iClk)) then
            if(res = '1') then
                state <= idle;
                turn <= "000";
            else
                state <= nextState;
                turn <= nextTurn;
            end if;
        end if;
    end process;

end architecture;