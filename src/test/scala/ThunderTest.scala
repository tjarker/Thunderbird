import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class ThunderTester(dut: Thunderbird) extends PeekPokeTester(dut){
  poke(dut.io.H, 0)
  poke(dut.io.L, 0)
  poke(dut.io.R, 0)
  poke(dut.io.B, 0)
  step(1)
  println("Testing blink left:")
  poke(dut.io.L,1)
  for(i <- 0 until 8){
    println(s"${peek(dut.io.Lo).toInt.toBinaryString.reverse.padTo(3,'0').reverse} | ${peek(dut.io.Ro).toInt.toBinaryString.padTo(3,'0')}")
    step(1)
  }
  println("Testing blink right:")
  poke(dut.io.L,0)
  poke(dut.io.R,1)
  for(i <- 0 until 8){
    println(s"${peek(dut.io.Lo).toInt.toBinaryString.reverse.padTo(3,'0').reverse} | ${peek(dut.io.Ro).toInt.toBinaryString.padTo(3,'0')}")
    step(1)
  }
  println("Testing hazard:")
  poke(dut.io.L,1)
  poke(dut.io.H,1)
  for(i <- 0 until 8){
    println(s"${peek(dut.io.Lo).toInt.toBinaryString.padTo(3,'0')} | ${peek(dut.io.Ro).toInt.toBinaryString.padTo(3,'0')}")
    step(1)
  }
}


class ThunderTest extends FlatSpec with Matchers{
  "Thunderbird" should "pass" in {
    chisel3.iotesters.Driver(() => new Thunderbird(0)) {
      c => new ThunderTester(c)
    } should be(true)
  }
}