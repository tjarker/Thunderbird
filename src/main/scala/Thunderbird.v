module Thunderbird(
  input        clock,
  input        reset,
  input        io_L,
  input        io_R,
  input        io_H,
  input        io_B,
  output [2:0] io_Lo,
  output [2:0] io_Ro
);
  reg  L; // @[lib.scala 16:19]
  reg [31:0] _RAND_0;
  reg  R; // @[lib.scala 16:19]
  reg [31:0] _RAND_1;
  reg  H; // @[lib.scala 16:19]
  reg [31:0] _RAND_2;
  reg  B; // @[lib.scala 16:19]
  reg [31:0] _RAND_3;
  reg [23:0] _T; // @[lib.scala 9:27]
  reg [31:0] _RAND_4;
  wire  tick; // @[lib.scala 10:25]
  wire [23:0] _T_2; // @[lib.scala 11:39]
  reg [1:0] stateReg; // @[Thunderbird.scala 26:25]
  reg [31:0] _RAND_5;
  wire  _T_11; // @[Conditional.scala 37:30]
  wire  _T_12; // @[Conditional.scala 37:30]
  wire  _T_13; // @[Thunderbird.scala 65:18]
  wire  _T_14; // @[Conditional.scala 37:30]
  wire  _T_15; // @[Thunderbird.scala 74:18]
  wire  _T_16; // @[Conditional.scala 37:30]
  reg [2:0] turnReg; // @[Thunderbird.scala 33:24]
  reg [31:0] _RAND_6;
  wire  _T_4; // @[Thunderbird.scala 42:26]
  wire  _T_5; // @[Thunderbird.scala 42:52]
  wire  _T_6; // @[Thunderbird.scala 42:40]
  wire  _T_7; // @[Thunderbird.scala 42:13]
  wire [1:0] _T_8; // @[Thunderbird.scala 43:23]
  wire [2:0] _T_9; // @[Thunderbird.scala 43:30]
  wire  _T_10; // @[Thunderbird.scala 44:18]
  wire  _T_18; // @[Thunderbird.scala 89:12]
  wire  _T_19; // @[Thunderbird.scala 89:15]
  wire [2:0] _GEN_14; // @[Thunderbird.scala 89:20]
  wire [2:0] _GEN_15; // @[Thunderbird.scala 96:14]
  wire  _T_23; // @[Bitwise.scala 108:18]
  wire  _T_24; // @[Bitwise.scala 108:44]
  wire  _T_26; // @[Bitwise.scala 108:44]
  wire [2:0] _T_27; // @[Cat.scala 29:58]
  wire [2:0] _GEN_16; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_17; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_18; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_19; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_20; // @[Conditional.scala 39:67]
  assign tick = _T == 24'hffffff; // @[lib.scala 10:25]
  assign _T_2 = _T + 24'h1; // @[lib.scala 11:39]
  assign _T_11 = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  assign _T_12 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  assign _T_13 = L == 1'h0; // @[Thunderbird.scala 65:18]
  assign _T_14 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  assign _T_15 = R == 1'h0; // @[Thunderbird.scala 74:18]
  assign _T_16 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  assign _T_4 = stateReg == 2'h2; // @[Thunderbird.scala 42:26]
  assign _T_5 = stateReg == 2'h1; // @[Thunderbird.scala 42:52]
  assign _T_6 = _T_4 | _T_5; // @[Thunderbird.scala 42:40]
  assign _T_7 = tick & _T_6; // @[Thunderbird.scala 42:13]
  assign _T_8 = turnReg[1:0]; // @[Thunderbird.scala 43:23]
  assign _T_9 = {_T_8,1'h1}; // @[Thunderbird.scala 43:30]
  assign _T_10 = turnReg == 3'h7; // @[Thunderbird.scala 44:18]
  assign _T_18 = H == 1'h0; // @[Thunderbird.scala 89:12]
  assign _T_19 = _T_18 & B; // @[Thunderbird.scala 89:15]
  assign _GEN_14 = _T_19 ? 3'h7 : 3'h0; // @[Thunderbird.scala 89:20]
  assign _GEN_15 = B ? 3'h7 : 3'h0; // @[Thunderbird.scala 96:14]
  assign _T_23 = _T_8[0]; // @[Bitwise.scala 108:18]
  assign _T_24 = _T_8[1]; // @[Bitwise.scala 108:44]
  assign _T_26 = turnReg[2]; // @[Bitwise.scala 108:44]
  assign _T_27 = {_T_23,_T_24,_T_26}; // @[Cat.scala 29:58]
  assign _GEN_16 = _T_16 ? 3'h7 : 3'h0; // @[Conditional.scala 39:67]
  assign _GEN_17 = _T_14 ? _T_27 : _GEN_16; // @[Conditional.scala 39:67]
  assign _GEN_18 = _T_14 ? _GEN_15 : _GEN_16; // @[Conditional.scala 39:67]
  assign _GEN_19 = _T_12 ? turnReg : _GEN_18; // @[Conditional.scala 39:67]
  assign _GEN_20 = _T_12 ? _GEN_15 : _GEN_17; // @[Conditional.scala 39:67]
  assign io_Lo = _T_11 ? _GEN_14 : _GEN_19; // @[Thunderbird.scala 38:9 Thunderbird.scala 90:15 Thunderbird.scala 95:13 Thunderbird.scala 103:15 Thunderbird.scala 107:13]
  assign io_Ro = _T_11 ? _GEN_14 : _GEN_20; // @[Thunderbird.scala 39:9 Thunderbird.scala 91:15 Thunderbird.scala 97:15 Thunderbird.scala 101:13 Thunderbird.scala 108:13]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  L = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  R = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  H = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  B = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T = _RAND_4[23:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  stateReg = _RAND_5[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  turnReg = _RAND_6[2:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    L <= io_L;
    R <= io_R;
    H <= io_H;
    B <= io_B;
    if (reset) begin
      _T <= 24'h0;
    end else if (tick) begin
      _T <= 24'h0;
    end else begin
      _T <= _T_2;
    end
    if (reset) begin
      stateReg <= 2'h0;
    end else if (tick) begin
      if (_T_11) begin
        if (H) begin
          stateReg <= 2'h3;
        end else if (R) begin
          stateReg <= 2'h2;
        end else if (L) begin
          stateReg <= 2'h1;
        end else begin
          stateReg <= 2'h0;
        end
      end else if (_T_12) begin
        if (H) begin
          stateReg <= 2'h3;
        end else if (_T_13) begin
          stateReg <= 2'h0;
        end else begin
          stateReg <= 2'h1;
        end
      end else if (_T_14) begin
        if (H) begin
          stateReg <= 2'h3;
        end else if (_T_15) begin
          stateReg <= 2'h0;
        end else begin
          stateReg <= 2'h2;
        end
      end else begin
        stateReg <= 2'h0;
      end
    end
    if (reset) begin
      turnReg <= 3'h0;
    end else if (_T_11) begin
      turnReg <= 3'h0;
    end else if (_T_7) begin
      if (_T_10) begin
        turnReg <= 3'h0;
      end else begin
        turnReg <= _T_9;
      end
    end
  end
endmodule
