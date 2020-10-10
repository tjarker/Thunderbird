import chisel3._
import chisel3.util._

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
  def synchronize[T <: Data](in: T) : T = {
    return RegNext(in)
  }
}
