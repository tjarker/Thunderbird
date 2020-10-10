import chisel3._
import chisel3.util._


class Thunderbird extends Module{
  val io = IO(new Bundle{
    val L = Input(Bool())
    val R = Input(Bool())
    val H = Input(Bool())
    val B = Input(Bool())
    val Lo = Output(UInt(3.W))
    val Ro = Output(UInt(3.W))
  })

  val idle :: leftTurn :: rightTurn :: hazard :: Nil = Enum(4)
  val stateReg = RegInit(idle)

  val turnReg = RegInit(0.U(3.W))

  io.Lo := "b000".U
  io.Ro := "b000".U

  when(stateReg === rightTurn || stateReg === leftTurn){
    turnReg := turnReg(1, 0) ## 1.U(1.W)
    when(turnReg === 7.U) {
      turnReg := 0.U
    }
  }

  switch(stateReg) {
    is(idle) {
      when(io.H) {
        stateReg := hazard
      }.elsewhen(io.R) {
        stateReg := rightTurn
      }.elsewhen(io.L) {
        stateReg := leftTurn
      }.otherwise {
        stateReg := idle
      }
    }
    is(leftTurn) {
      when(io.H) {
        stateReg := hazard
      }.elsewhen(!io.L) {
        stateReg := idle
      }.otherwise {
        stateReg := leftTurn
      }
    }
    is(rightTurn) {
      when(io.H) {
        stateReg := hazard
      }.elsewhen(!io.R) {
        stateReg := idle
      }.otherwise {
        stateReg := rightTurn
      }
    }
    is(hazard) {
      stateReg := idle
    }
  }

  switch(stateReg) {
    is(idle) {
      turnReg := 0.U
      when(!io.H && io.B){
        io.Lo := "b111".U
        io.Ro := "b111".U
      }
    }
    is(leftTurn) {
      io.Lo := turnReg
      when(io.B){
        io.Ro
      }
    }
    is(rightTurn) {
      io.Ro := Reverse(turnReg)
    }
    is(hazard) {
      io.Lo := "b111".U
      io.Ro := "b111".U
    }
  }
}
