module InstructionMemory(
    input [31:0] addr,
    output [31:0] data_out
);
  
  /* Module Description:
     - The module has an input addr which is the address of the instruction to be fetched.
     - The module has an output data_out which is the instruction read.
  */
 
    reg [31:0] memory [0:1023];  // 4 KB (1024 locations)
    assign data_out = memory[addr[31:2]];  // word addressing, Least significant 2 bits are zeros
    
endmodule

