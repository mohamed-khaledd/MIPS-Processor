module tb_mips_processor;
    reg clk, rst;

    // Instantiation of the MIPS processor
    mips_processor uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        rst = 1;
        #10 rst = 0;

        // Loading instructions into instruction memory
        uut.im.memory[0] = 32'b000000_01000_01010_01001_00000_100000;  // add $t1, $t0, $t2
        uut.im.memory[1] = 32'b000000_01000_01001_01010_00000_100010;  // sub $t2, $t0, $t1
        uut.im.memory[2] = 32'b100011_01000_01010_0000000000000000;    // lw $t2, 0($t0)
        uut.im.memory[3] = 32'b101011_01000_01011_0000000000000100;    // sw $t3, 4($t0)
        uut.im.memory[4] = 32'b000100_01000_01001_0000000000000010;    // beq $t0, $t1, label
        uut.im.memory[5] = 32'b101011_01000_01100_0000000000001000;    // sw $t4, 8($t0)

        // Initializing  $t0,$t1,$t2
        uut.rf.regFile[8] = 32'd10;   // $t0 
        uut.rf.regFile[9] = 32'd20;   // $t1 
        uut.rf.regFile[10] = 32'd30;  // $t2
        
        // Initializing data memory at location 10
        uut.dm.memory[10] = 32'd100; 
 
        #200 $stop;
    end

    // Monitoring signals
    initial begin
        $monitor("Time: %0d, PC: %h, Instr: %h, RD1: %h, RD2: %h, ALUResult: %h, MemReadData: %h", 
                 $time, uut.pc, uut.instr, uut.rd1, uut.rd2, uut.alu_result, uut.read_data);
    end
endmodule
