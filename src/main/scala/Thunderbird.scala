import chisel3._
import chisel3.util._
import lib._

object lib {
  def tickGen(max: Int): Bool = {
    if(max==0){
      return WireDefault(true.B)
    }else{
      val ticker = RegInit(0.U(log2Ceil(max).W))
      val tick = ticker === (max-1).U
      ticker := Mux(tick, 0.U, ticker + 1.U)
      return tick
    }
  }
}

class Thunderbird(clockDiv: Int) extends Module{
  val io = IO(new Bundle{
    val L = Input(Bool())
    val R = Input(Bool())
    val H = Input(Bool())
    val B = Input(Bool())
    val Lo = Output(UInt(3.W))
    val Ro = Output(UInt(3.W))
  })

  // synchronize inputs
  val L = RegNext(io.L)
  val R = RegNext(io.R)
  val H = RegNext(io.H)
  val B = RegNext(io.B)

  // clock divider
  val tick = tickGen(clockDiv)

  // states and state register
  val idle :: leftTurn :: rightTurn :: hazard :: Nil = Enum(4)
  val stateReg = RegInit(idle)
  val nextState = WireDefault(idle)
  when(tick){
    stateReg := nextState
  }

  // register for turn sequence
  val turnReg = RegInit(0.U(3.W))
  val allLow = WireDefault("b000".U)
  val allHigh = WireDefault("b111".U)

  // default output assignment
  io.Lo := allLow
  io.Ro := allLow

  // turn sequence register control
  when(tick && (stateReg === rightTurn || stateReg === leftTurn)){
    turnReg := turnReg(1, 0) ## 1.U(1.W) // shift left and insert 1 at lsb
    when(turnReg === allHigh) {
      turnReg := allLow
    }
  }

  // state control
  switch(stateReg) {
    is(idle) {
      when(H) {
        nextState := hazard
      }.elsewhen(R) {
        nextState := rightTurn
      }.elsewhen(L) {
        nextState := leftTurn
      }.otherwise {
        nextState := idle
      }
    }
    is(leftTurn) {
      when(H) {
        nextState := hazard
      }.elsewhen(!L) {
        nextState := idle
      }.otherwise {
        nextState := leftTurn
      }
    }
    is(rightTurn) {
      when(H) {
        nextState := hazard
      }.elsewhen(!R) {
        nextState := idle
      }.otherwise {
        nextState := rightTurn
      }
    }
    is(hazard) {
      nextState := idle
    }
  }

  // output control
  switch(stateReg) {
    is(idle) {
      turnReg := 0.U
      when(!H && B){
        io.Lo := allHigh
        io.Ro := allHigh
      }
    }
    is(leftTurn) {
      io.Lo := turnReg
      when(B){
        io.Ro := allHigh
      }
    }
    is(rightTurn) {
      io.Ro := Reverse(turnReg)
      when(B){
        io.Lo := allHigh
      }
    }
    is(hazard) {
      io.Lo := allHigh
      io.Ro := allHigh
    }
  }
}

// generate Verilog
object Thunderbird extends App {
  chisel3.Driver.execute(args, () => new Thunderbird(16777216))
}