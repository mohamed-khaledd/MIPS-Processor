module tb_mips_processor;
    reg clk, rst;

    // Instantiate the MIPS processor
    mips_processor uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        rst = 1;
        #10 rst = 0;
        #200 $stop;
    end

    // Monitoring signals
    initial begin
        $monitor("Time: %0d, PC: %h, Instr: %h, RD1: %h, RD2: %h, ALUResult: %h, MemReadData: %h", 
                 $time, uut.pc, uut.instr, uut.rd1, uut.rd2, uut.alu_result, uut.read_data);
    end
endmodule
