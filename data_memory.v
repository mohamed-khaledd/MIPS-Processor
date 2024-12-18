module data_memory(A, WD, clk, WE, RD);

  /* Module Description:
     - The module has 4 inputs:
       1) A, which is the address of the data to be read.
       2) WD, which is the data to be written in the data memory.
       3) clk, which is the clock signal.
       4) WE, which is the write enable signal.
     - The module has an output RD which is the data read.
     Note: A is 12 bits as the size of instruction memory is 16 KB.
  */
  
    input wire [11:0] A;
    input wire [31:0] WD;
    input wire clk, WE;
    output wire [31:0] RD;
  
    reg [31:0] memory [0:4095];
    integer i;

    initial begin
        for (i = 0; i < 4096; i = i + 1) begin
            memory[i] = 32'b0;    // // Initializing all memory to zero
        end
    end

    assign RD = memory[A];

    always @(posedge clk) begin
        if (WE)
            memory[A] <= WD;
    end
endmodule
