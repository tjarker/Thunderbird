module Thunderbird
(
    input           clock,
    input           reset,
    input           io_L,
    input           io_R,
    input           io_H,
    input           io_B,
    output  [2:0]   io_Lo,
    output  [2:0]   io_Ro
);

// synchronization variables
reg L;
reg R;
reg H;
reg B;
reg Res;
wire clk;

// state machine variables
reg [1:0]state;
localparam idle = 2'b00;
localparam leftTurn = 2'b01;
localparam rightTurn = 2'b10;
localparam hazard = 2'b11;

// turn sequence variables
reg [2:0]turn;
wire [2:0]allLow, allHigh;
assign allLow = 3'b000;
assign allHigh = 3'b111;
reg [2:0]Lo, Ro;
assign io_Lo = Lo;
assign io_Ro = Ro;

// create clock divider instance
clock_divider clock_div(clock,clk);

// input synchronization
always @(posedge clock) begin
    B <= io_B;
    L <= io_L;
    R <= io_R;
    H <= io_H;
    Res <= reset;
end

// turn sequence register
always @(posedge clk) begin
    if(Res) turn <= allLow;
    else begin
        if(state == leftTurn || state == rightTurn) begin
            turn <= turn == allHigh ? allLow : {turn[1:0],1'b1};
        end
        else begin 
            turn <= allLow;
        end
    end
end

// tail light output control
always @(state or turn) begin
    case(state)
        idle: begin
            if(!H && B) begin
                Lo <= allHigh;
                Ro <= allHigh;
            end 
            else begin
                Lo <= allLow;
                Ro <= allLow;
            end
        end
        leftTurn: begin
            Lo <= turn;
            Ro <= B ? allHigh : allLow;
        end
        rightTurn: begin
            Ro <= turn;
            Lo <= B ? allHigh : allLow;
        end
        hazard: begin
            Lo <= allHigh;
            Ro <= allHigh;
        end
    endcase
end

// state machine
always @(posedge clk) begin
    if(Res) begin
        state <= idle;
    end
    else begin
        case(state)
            idle: begin
                if(H) state <= hazard;
                else if(R) state <= rightTurn;
                else if(L) state <= leftTurn;
                else state <= idle;
            end
            leftTurn: begin
                if(H) state <= hazard;
                else if(!L) state <= idle;
                else state <= leftTurn;
            end
            rightTurn: begin
                if(H) state <= hazard;
                else if(!R) state <= idle;
                else state <= rightTurn;
            end
            default: state <= idle;
        endcase
    end
end

endmodule