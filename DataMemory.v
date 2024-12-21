module DataMemory(
    input clk,
    input [31:0] addr,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data
);

  /* Module Description:
     - The module has 4 inputs:
       1) addr, which is the address of the data to be read.
       2) write_data, which is the data to be written in the data memory.
       3) clk, which is the clock signal.
       4) write_enable, which is the write enable signal.
     - The module has an output read_data which is the data read.
  */
  
    reg [31:0] memory [0:4095];  // 16 KB (4096 locations) 

    assign read_data = memory[addr[31:2]];  // word addressing, Least significant 2 bits are zeros

    always @(posedge clk) begin
        if (write_enable)
            memory[addr[31:2]] <= write_data;
    end
endmodule
