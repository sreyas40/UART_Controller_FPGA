`timescale 1ns/10ps
module uart_top_tb ();
 
  // Clock and baud rate parameters
  parameter c_CLOCK_PERIOD_NS = 10; // 100 MHz clock
  parameter c_CLKS_PER_BIT    = 868;  // Clock cycles per UART bit
  parameter c_BIT_PERIOD      = 8680; // UART bit period
   
  reg r_Clock = 0; // Clock
  reg r_Rx_Serial = 1; // Simulated serial input
  wire w_Tx_Serial; // Transmitted serial output
  wire [7:0] w_Rx_Byte; // Received byte
  
  // Instantiate the UART Top Module
  uart_top UART_TOP_INST (
    .rx_Serial(r_Rx_Serial),
    .clk(r_Clock),
    .tx_Serial(w_Tx_Serial)
  );

  // Task to send a byte over UART
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer ii;
    begin
      // Send Start Bit
      r_Rx_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      
      // Send Data Bits
      for (ii=0; ii<8; ii=ii+1) begin
        r_Rx_Serial <= i_Data[ii];
        #(c_BIT_PERIOD);
      end
      
      // Send Stop Bit
      r_Rx_Serial <= 1'b1;
      #(c_BIT_PERIOD);
    end
  endtask
   
  // Clock generation
  always #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;

  // Main Testing
  initial begin
    $display("Sent Byte - a5");
    $monitor("Received Byte: %0x", uart_tx.i_Tx_Byte);
    
    // Send a byte and check if it's echoed back
    @(posedge r_Clock);
    UART_WRITE_BYTE(8'hA5);
    
    // Wait for transmission to complete
    #(c_BIT_PERIOD * 11);
    
    // Verify that the received byte matches the sent byte
    if (w_Tx_Serial == r_Rx_Serial)
      $display("Test Passed - Correct Byte Echoed");
    else
      $display("Test Failed - Incorrect Byte Echoed");
  
    $stop;
  end
   
endmodule
