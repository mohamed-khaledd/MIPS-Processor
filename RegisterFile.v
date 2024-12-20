module RegisterFile(
    input clk,
    input [4:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data1, read_data2
);

   /* Module Description:
      - The module has 6 inputs:
        1) read_reg1, which is the address of the first register to read from.
        2) read_reg2, which is the address of the second register to read from.
        3) write_reg, which is the address of the register where data will be written.
        4) write_enable, which is the write enable signal.
        5) write_data, which is the data that will be written into the register specified by WA.
        6) clk, which is the clock signal.
      - The module has 2 outputs:
        1) read_data1, which is the data read from the register specified by RA1.
        2) read_data2, which is the data read from the register specified by RA2.
   */

    reg [31:0] regFile [0:31];
    integer i;

    initial begin        
        for (i = 0; i < 32; i = i + 1) begin
            regFile[i] = 32'b0;    // Initializing all registers to zero
        end
    end

    assign read_data1 = regFile[read_reg1];
    assign read_data2 = regFile[read_reg2];

    always @(posedge clk) begin
       if (write_enable)
          regFile[write_reg] <= write_data;
    end
endmodule
