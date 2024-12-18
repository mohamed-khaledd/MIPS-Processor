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
        
        // Testing add, sub, lw, sw, beq

        memory[0] = 32'b000000_00001_00010_00011_00000_100000;  // add $t1, $t0, $t2
        memory[1] = 32'b000000_00001_00010_00100_00000_100010;  // sub $t2, $t0, $t1 
        memory[2] = 32'b100011_00001_00101_0000000000000000;    // lw $t2, 0($t0)
        memory[3] = 32'b101011_00001_00110_0000000000000100;    // sw $t3, 4($t0)
        memory[4] = 32'b000100_00001_00010_0000000000000010;    // beq $t0, $t1, label
        memory[5] = 32'b101011_00001_00111_0000000000001000;    // sw $t4, 8($t0)

    end
    assign RD = memory[A];
endmodule

