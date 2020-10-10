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
    node _T = eq(stateReg, UInt<2>("h2")) @[Thunderbird.scala 23:17]
    node _T_1 = eq(stateReg, UInt<2>("h1")) @[Thunderbird.scala 23:43]
    node _T_2 = or(_T, _T_1) @[Thunderbird.scala 23:31]
    node _T_3 = bits(turnReg, 1, 0) @[Thunderbird.scala 24:23]
    node _T_4 = cat(_T_3, UInt<1>("h1")) @[Thunderbird.scala 24:30]
    node _T_5 = eq(turnReg, UInt<3>("h7")) @[Thunderbird.scala 25:18]
    node _GEN_0 = mux(_T_5, UInt<1>("h0"), _T_4) @[Thunderbird.scala 25:27]
    node _GEN_1 = mux(_T_2, _GEN_0, turnReg) @[Thunderbird.scala 23:56]
    node _T_6 = eq(UInt<2>("h0"), stateReg) @[Conditional.scala 37:30]
    node _GEN_2 = mux(io_L, UInt<2>("h1"), UInt<2>("h0")) @[Thunderbird.scala 36:24]
    node _GEN_3 = mux(io_R, UInt<2>("h2"), _GEN_2) @[Thunderbird.scala 34:24]
    node _GEN_4 = mux(io_H, UInt<2>("h3"), _GEN_3) @[Thunderbird.scala 32:18]
    node _T_7 = eq(UInt<2>("h1"), stateReg) @[Conditional.scala 37:30]
    node _T_8 = eq(io_L, UInt<1>("h0")) @[Thunderbird.scala 45:18]
    node _GEN_5 = mux(_T_8, UInt<2>("h0"), UInt<2>("h1")) @[Thunderbird.scala 45:25]
    node _GEN_6 = mux(io_H, UInt<2>("h3"), _GEN_5) @[Thunderbird.scala 43:18]
    node _T_9 = eq(UInt<2>("h2"), stateReg) @[Conditional.scala 37:30]
    node _T_10 = eq(io_R, UInt<1>("h0")) @[Thunderbird.scala 54:18]
    node _GEN_7 = mux(_T_10, UInt<2>("h0"), UInt<2>("h2")) @[Thunderbird.scala 54:25]
    node _GEN_8 = mux(io_H, UInt<2>("h3"), _GEN_7) @[Thunderbird.scala 52:18]
    node _T_11 = eq(UInt<2>("h3"), stateReg) @[Conditional.scala 37:30]
    node _GEN_9 = mux(_T_11, UInt<2>("h0"), stateReg) @[Conditional.scala 39:67]
    node _GEN_10 = mux(_T_9, _GEN_8, _GEN_9) @[Conditional.scala 39:67]
    node _GEN_11 = mux(_T_7, _GEN_6, _GEN_10) @[Conditional.scala 39:67]
    node _GEN_12 = mux(_T_6, _GEN_4, _GEN_11) @[Conditional.scala 40:58]
    node _T_12 = eq(UInt<2>("h0"), stateReg) @[Conditional.scala 37:30]
    node _T_13 = eq(UInt<2>("h1"), stateReg) @[Conditional.scala 37:30]
    node _T_14 = eq(UInt<2>("h2"), stateReg) @[Conditional.scala 37:30]
    node _T_15 = bits(turnReg, 1, 0) @[Bitwise.scala 108:18]
    node _T_16 = bits(_T_15, 0, 0) @[Bitwise.scala 108:18]
    node _T_17 = bits(_T_15, 1, 1) @[Bitwise.scala 108:44]
    node _T_18 = cat(_T_16, _T_17) @[Cat.scala 29:58]
    node _T_19 = bits(turnReg, 2, 2) @[Bitwise.scala 108:44]
    node _T_20 = cat(_T_18, _T_19) @[Cat.scala 29:58]
    node _T_21 = eq(UInt<2>("h3"), stateReg) @[Conditional.scala 37:30]
    node _GEN_13 = mux(_T_21, UInt<3>("h7"), UInt<1>("h0")) @[Conditional.scala 39:67]
    node _GEN_14 = mux(_T_14, _T_20, _GEN_13) @[Conditional.scala 39:67]
    node _GEN_15 = mux(_T_14, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67]
    node _GEN_16 = mux(_T_13, turnReg, _GEN_15) @[Conditional.scala 39:67]
    node _GEN_17 = mux(_T_13, UInt<1>("h0"), _GEN_14) @[Conditional.scala 39:67]
    node _GEN_18 = mux(_T_12, UInt<1>("h0"), _GEN_1) @[Conditional.scala 40:58]
    node _GEN_19 = mux(_T_12, UInt<1>("h0"), _GEN_16) @[Conditional.scala 40:58]
    node _GEN_20 = mux(_T_12, UInt<1>("h0"), _GEN_17) @[Conditional.scala 40:58]
    io_Lo <= _GEN_19 @[Thunderbird.scala 20:9 Thunderbird.scala 70:13 Thunderbird.scala 76:13]
    io_Ro <= _GEN_20 @[Thunderbird.scala 21:9 Thunderbird.scala 73:13 Thunderbird.scala 77:13]
    stateReg <= mux(reset, UInt<2>("h0"), _GEN_12) @[Thunderbird.scala 33:18 Thunderbird.scala 35:18 Thunderbird.scala 37:18 Thunderbird.scala 39:18 Thunderbird.scala 44:18 Thunderbird.scala 46:18 Thunderbird.scala 48:18 Thunderbird.scala 53:18 Thunderbird.scala 55:18 Thunderbird.scala 57:18 Thunderbird.scala 61:16]
    turnReg <= mux(reset, UInt<3>("h0"), _GEN_18) @[Thunderbird.scala 24:13 Thunderbird.scala 26:15 Thunderbird.scala 67:15]
