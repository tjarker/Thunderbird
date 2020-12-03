import chiseltest._
import org.scalatest.FreeSpec
import chisel3._

class ThunderTest extends FreeSpec with ChiselScalatestTester{

  def readBin(port: UInt) : Int = {
    port.peek.litValue.toString(2).toInt
  }

  "Thunderbird should blink left" in {
    test(new Thunderbird(0)){ dut =>

      println("Left turn sequence:")

      val seq = Seq(0x00,0x01,0x03,0x07)

      // initialize inputs
      dut.io.H.poke(false.B)
      dut.io.B.poke(false.B)
      dut.io.R.poke(false.B)

      dut.io.L.poke(true.B)

      dut.clock.step(1)

      for(i <- 0 until 10) {
        println("%03d | %03d".format(readBin(dut.io.Lo),readBin(dut.io.Ro)))
        dut.clock.step(1)
        dut.io.Lo.expect(seq(i%4).U)
        dut.io.Ro.expect(0.U)
      }
    }
  }

  "Thunderbird should blink right" in {
    test(new Thunderbird(0)){ dut =>

      println("Right turn sequence:")

      val seq = Seq(0x00,0x04,0x06,0x07)

      // initialize inputs
      dut.io.H.poke(false.B)
      dut.io.B.poke(false.B)
      dut.io.L.poke(false.B)

      dut.io.R.poke(true.B)

      dut.clock.step(1)

      for(i <- 0 until 10) {
        println("%03d | %03d".format(readBin(dut.io.Lo),readBin(dut.io.Ro)))
        dut.clock.step(1)
        dut.io.Ro.expect(seq(i%4).U)
        dut.io.Lo.expect(0.U)
      }
    }
  }

  "Thunderbird should show hazard" in {
    test(new Thunderbird(0)){ dut =>

      println("Hazard sequence:")

      val seq = Seq(0x00,0x07)

      // initialize inputs
      dut.io.R.poke(false.B)
      dut.io.B.poke(false.B)
      dut.io.L.poke(false.B)

      dut.io.H.poke(true.B)

      dut.clock.step(1)

      for(i <- 0 until 10) {
        println("%03d | %03d".format(readBin(dut.io.Lo),readBin(dut.io.Ro)))
        dut.io.Ro.expect(seq(i%2).U)
        dut.io.Lo.expect(seq(i%2).U)
        dut.clock.step(1)
      }
    }
  }

  "Thunderbird should show brake under left Turn" in {
    test(new Thunderbird(0)){ dut =>

      println("Brake under left turn sequence:")

      val seq = Seq(0x00,0x01,0x03,0x07)

      // initialize inputs
      dut.io.H.poke(false.B)
      dut.io.R.poke(false.B)

      dut.io.B.poke(true.B)
      dut.io.L.poke(true.B)

      dut.clock.step(1)

      for(i <- 0 until 10) {
        println("%03d | %03d".format(readBin(dut.io.Lo),readBin(dut.io.Ro)))
        dut.clock.step(1)
        dut.io.Lo.expect(seq(i%4).U)
        dut.io.Ro.expect(7.U)
      }
    }
  }

}