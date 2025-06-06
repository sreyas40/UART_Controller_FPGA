`timescale 1ns / 1ps

module uart_top(
input rx_Serial,
input clk,
output tx_Serial
    );
wire data_Valid;
wire [7:0] rx_Byte;
wire active_Ind = 0;
wire tx_Done = 0;
reg tx_Trigger = 1'b0;

uart_rx UART_RX_INST (
.i_Clock(clk),
.i_Rx_Serial(rx_Serial),
.o_Rx_DV(data_Valid),
.o_Rx_Byte(rx_Byte));

always @(posedge clk)begin
if (data_Valid) begin
tx_Trigger <= 1'b1;
end
else if (tx_Trigger) begin
tx_Trigger <=1'b0;
end
end

uart_tx UART_TX_INST(
.i_Clock(clk),
.i_Tx_DV(tx_Trigger),
.i_Tx_Byte(rx_Byte),
.o_Tx_Active(active_Ind),
.o_Tx_Serial(tx_Serial),
.o_Tx_Done(tx_Done)
);

endmodule
