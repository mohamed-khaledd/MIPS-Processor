module tb_mips_processor;
    reg clk, rst;

    // Instantiation of the MIPS processor
    SingleCycleMIPSProcessor uut (
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
        uut.im.memory[1] = 32'b000000_01001_01000_01100_00000_100010;  // sub $t4, $t1, $t0
        uut.im.memory[2] = 32'b100011_01000_01010_0000000000000000;    // lw $t2, 0($t0)
        uut.im.memory[3] = 32'b101011_01000_01011_0000000000000100;    // sw $t3, 4($t0)
        uut.im.memory[4] = 32'b000100_01011_01001_0000000000000001;    // beq $t3, $t1, label
        uut.im.memory[5] = 32'b000000_01000_01010_01101_00000_100000;  // add $t5, $t0, $t2 (to be skipped if branch is taken)
        uut.im.memory[6] = 32'b101011_01000_01100_0000000000001000;    // sw $t4, 8($t0)


        // Initializing  $t0,$t1,$t2
        uut.rf.regFile[8] = 32'd12;   // $t0 
        uut.rf.regFile[9] = 32'd20;   // $t1 
        uut.rf.regFile[10] = 32'd30;  // $t2
        uut.rf.regFile[11] = 32'd42;  // $t3
      
        // Initializing data memory at location 10
        uut.dm.memory[12] = 32'd100; 
 
        #200 $stop;
    end

    // Monitoring signals
    initial begin
        $monitor("Time: %0d, PC: %h, Instr: %h, RD1: %h, RD2: %h, ALUResult: %h, MemReadData: %h", 
                 $time, uut.pc, uut.instr, uut.rd1, uut.rd2, uut.alu_result, uut.read_data);
    end
endmodule


/*
Expected Results:
------------------
First instruction "add $t1, $t0, $t2"    -----> $t1 = 12 + 30 = 42
Second instruction "sub $t4, $t1, $t0"   -----> $t4 = 20 - 12 = 8
Third instruction "lw $t2, 0($t0)"       -----> $t2 = 100 (the contents of memory address 12)
Fourth instruction "sw $t3, 4($t0)"      -----> 42 will be stored in memory address 16
Fifth instruction "beq $t3, $t1, label"  -----> checks wheather $t1 = $t3 or not and branches if equal.
Sixth instruction "add $t5, $t0, $t2"    -----> this will be skipped
Seventh instruction "sw $t4, 8($t0)"     -----> 8 will be stored in memory address 20
-----------------------------------------------------------------------------------------------
To check 'add' works correctly: $t1 should contain 42
To check 'sub' works correctly: $t4 should contain 8
To check 'lw' works correctly: $t2 should contain 100
To check 'sw' works correctly: Memory address 16 should contain 42
To check 'beq' works correctly: $t5 should be zero (if it contain 42, then branch is incorrect) + Memory address 20 should contain 8
*/
