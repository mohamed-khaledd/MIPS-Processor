module instruction_memory(A, RD);
  
  /* Module Description:
     - The module has an input A which is the address of the instruction to be fetched.
     - The module has an output RD which is the instruction read.
     Note: A is 10 bits as the size of instruction memory is 4 KB.
  */
  
    input wire [9:0] A;
    output wire [31:0] RD;
 
    reg [31:0] memory [0:1023];
    integer i;

    initial begin        
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'b0;    // // Initializing all memory to zero
        end
    end
    assign RD = memory[A];
endmodule

