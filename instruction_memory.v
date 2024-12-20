module InstructionMemory(
    input [31:0] addr,
    output [31:0] data_out
);
  
  /* Module Description:
     - The module has an input addr which is the address of the instruction to be fetched.
     - The module has an output data_out which is the instruction read.
     Note: A is 10 bits as the size of instruction memory is 4 KB.
  */
 
    reg [31:0] memory [0:1023];
    integer i;

    initial begin        
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'b0;    // // Initializing all memory to zero
        end
    end
    assign data_out = memory[addr[31:2]];  // word addressing, Least significant 2 bits are zeros
endmodule

