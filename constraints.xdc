## Clock Signal
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## UART TXD (FPGA Transmit, FTDI Receive)
set_property PACKAGE_PIN D4 [get_ports tx_Serial]
set_property IOSTANDARD LVCMOS33 [get_ports tx_Serial]

## UART RXD (FPGA Receive, FTDI Transmit)
set_property PACKAGE_PIN C4 [get_ports rx_Serial]
set_property IOSTANDARD LVCMOS33 [get_ports rx_Serial]

## LED Indicators
set_property PACKAGE_PIN H17 [get_ports active_Ind]  # LED0
set_property IOSTANDARD LVCMOS33 [get_ports active_Ind]

set_property PACKAGE_PIN K15 [get_ports tx_Done]  # LED1
set_property IOSTANDARD LVCMOS33 [get_ports tx_Done]
