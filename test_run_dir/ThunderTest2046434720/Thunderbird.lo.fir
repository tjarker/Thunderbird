circuit Thunderbird :
  module Thunderbird :
    input clock : Clock
    input reset : UInt<1>
    input io_L : UInt<1>
    input io_R : UInt<1>
    input io_H : UInt<1>
    input io_B : UInt<1>
    output io_Lo : UInt<3>
    output io_Ro : UInt<3>
  
    reg stateReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[Thunderbird.scala 16:25]
    reg turnReg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), turnReg) @[Thunderbird.scala 18:24]
    node _T = eq(UInt<2>("h0"), stateReg) @[Conditional.scala 37:30]
    node _GEN_0 = mux(io_L, UInt<2>("h1"), UInt<2>("h0")) @[Thunderbird.scala 29:24]
    node _GEN_1 = mux(io_R, UInt<2>("h2"), _GEN_0) @[Thunderbird.scala 27:24]
    node _GEN_2 = mux(io_H, UInt<2>("h3"), _GEN_1) @[Thunderbird.scala 25:18]
    node _T_1 = eq(UInt<2>("h1"), stateReg) @[Conditional.scala 37:30]
    node _T_2 = eq(io_L, UInt<1>("h0")) @[Thunderbird.scala 38:18]
    node _GEN_3 = mux(_T_2, UInt<2>("h0"), UInt<2>("h1")) @[Thunderbird.scala 38:25]
    node _GEN_4 = mux(io_H, UInt<2>("h3"), _GEN_3) @[Thunderbird.scala 36:18]
    node _T_3 = eq(UInt<2>("h2"), stateReg) @[Conditional.scala 37:30]
    node _T_4 = eq(io_R, UInt<1>("h0")) @[Thunderbird.scala 47:18]
    node _GEN_5 = mux(_T_4, UInt<2>("h0"), UInt<2>("h2")) @[Thunderbird.scala 47:25]
    node _GEN_6 = mux(io_H, UInt<2>("h3"), _GEN_5) @[Thunderbird.scala 45:18]
    node _T_5 = eq(UInt<2>("h3"), stateReg) @[Conditional.scala 37:30]
    node _GEN_7 = mux(_T_5, UInt<2>("h0"), stateReg) @[Conditional.scala 39:67]
    node _GEN_8 = mux(_T_3, _GEN_6, _GEN_7) @[Conditional.scala 39:67]
    node _GEN_9 = mux(_T_1, _GEN_4, _GEN_8) @[Conditional.scala 39:67]
    node _GEN_10 = mux(_T, _GEN_2, _GEN_9) @[Conditional.scala 40:58]
    node _T_6 = eq(UInt<2>("h0"), stateReg) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<2>("h1"), stateReg) @[Conditional.scala 37:30]
    node _T_8 = bits(turnReg, 1, 0) @[Thunderbird.scala 64:25]
    node _T_9 = cat(_T_8, UInt<1>("h1")) @[Thunderbird.scala 64:32]
    node _T_10 = eq(turnReg, UInt<3>("h7")) @[Thunderbird.scala 65:20]
    node _GEN_11 = mux(_T_10, UInt<1>("h0"), _T_9) @[Thunderbird.scala 65:29]
    node _T_11 = eq(UInt<2>("h2"), stateReg) @[Conditional.scala 37:30]
    node _T_12 = bits(turnReg, 2, 1) @[Thunderbird.scala 71:37]
    node _T_13 = cat(UInt<1>("h1"), _T_12) @[Thunderbird.scala 71:27]
    node _T_14 = eq(turnReg, UInt<3>("h7")) @[Thunderbird.scala 72:20]
    node _GEN_12 = mux(_T_14, UInt<1>("h0"), _T_13) @[Thunderbird.scala 72:29]
    node _T_15 = eq(UInt<2>("h3"), stateReg) @[Conditional.scala 37:30]
    node _GEN_13 = mux(_T_15, UInt<3>("h7"), UInt<1>("h0")) @[Conditional.scala 39:67]
    node _GEN_14 = mux(_T_11, turnReg, _GEN_13) @[Conditional.scala 39:67]
    node _GEN_15 = mux(_T_11, _GEN_12, turnReg) @[Conditional.scala 39:67]
    node _GEN_16 = mux(_T_11, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67]
    node _GEN_17 = mux(_T_7, turnReg, _GEN_16) @[Conditional.scala 39:67]
    node _GEN_18 = mux(_T_7, _GEN_11, _GEN_15) @[Conditional.scala 39:67]
    node _GEN_19 = mux(_T_7, UInt<1>("h0"), _GEN_14) @[Conditional.scala 39:67]
    node _GEN_20 = mux(_T_6, UInt<1>("h0"), _GEN_18) @[Conditional.scala 40:58]
    node _GEN_21 = mux(_T_6, UInt<1>("h0"), _GEN_17) @[Conditional.scala 40:58]
    node _GEN_22 = mux(_T_6, UInt<1>("h0"), _GEN_19) @[Conditional.scala 40:58]
    io_Lo <= _GEN_21 @[Thunderbird.scala 20:9 Thunderbird.scala 63:13 Thunderbird.scala 77:13]
    io_Ro <= _GEN_22 @[Thunderbird.scala 21:9 Thunderbird.scala 70:13 Thunderbird.scala 78:13]
    stateReg <= mux(reset, UInt<2>("h0"), _GEN_10) @[Thunderbird.scala 26:18 Thunderbird.scala 28:18 Thunderbird.scala 30:18 Thunderbird.scala 32:18 Thunderbird.scala 37:18 Thunderbird.scala 39:18 Thunderbird.scala 41:18 Thunderbird.scala 46:18 Thunderbird.scala 48:18 Thunderbird.scala 50:18 Thunderbird.scala 54:16]
    turnReg <= mux(reset, UInt<3>("h0"), _GEN_20) @[Thunderbird.scala 60:15 Thunderbird.scala 64:15 Thunderbird.scala 66:17 Thunderbird.scala 71:15 Thunderbird.scala 73:17]
