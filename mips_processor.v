module SingleCycleMIPSProcessor(
    input clk,
    input reset,
);

    // Instruction Fields:
    wire [31:0] Instr;
    wire [5:0] Op,Funct;
    wire [4:0] Rs, Rt, Rd;
    wire [15:0] Immediate;
    wire [25:0] JumpAddr;

    assign Op = Instr[31:26];
    assign Rs = Instr[25:21];
    assign Rt = Instr[20:16];
    assign Rd = Instr[15:11];
    assign Funct = Instr[5:0];
    assign Immediate = Instr[15:0];
    assign JumpAddr = Instr[25:0];

  
    // Program Counter:
    reg [31:0] PC;
    wire [31:0] PCNext, PCPlus4, BranchAddr;
    wire [31:0] JumpTarget;
  
    assign PCPlus4 = PC + 4;
    assign JumpTarget = {PCPlus4[31:28], JumpAddr, 2'b00};
    assign BranchAddr = PCPlus4 + ({{16{Immediate[15]}}, Immediate} << 2);
    assign PCNext = (Jump) ? JumpTarget : (Branch & Zero) ? BranchAddr : PCPlus4;
 
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 0;
        else
            PC <= PCNext;
    end

    
    // Instruction Memory
    InstructionMemory im(
        .addr(PC),
        .data_out(Instr)
    );
  

    // Control Unit
    wire MemtoReg, MemWrite, ALUSrc, Branch, RegDst, Jump;
    wire [2:0] ALUControl;

    ControlUnit control(
        .opcode(Op),
        .funct(Funct),
        .mem_to_reg(MemtoReg),
        .mem_write(MemWrite),
        .alu_src(ALUSrc),
        .branch(Branch),
        .reg_dst(RegDst),
        .write_enable(RegWrite),
        .jump(Jump),
        .alu_control(ALUControl)
    );

  
    // Register File
    wire [31:0] ReadData1, ReadData2, WriteData;
    wire RegWrite;
   
    assign WriteData = (MemtoReg) ? ReadData : ALUResult;

    RegisterFile rf(
        .clk(clk),
        .read_reg1(Rs),
        .read_reg2(Rt),
        .write_reg((RegDst) ? Rd : Rt),
        .write_data(WriteData),
        .write_enable(RegWrite),
        .read_data1(ReadData1),
        .read_data2(ReadData2)
    );

  
    // ALU
    wire [31:0] ALUInput2, ALUResult;
    wire Zero;

    assign ALUInput2 = (ALUSrc) ? {{16{Immediate[15]}}, Immediate} : ReadData2;

    ALU alu(
        .input1(ReadData1),
        .input2(ALUInput2),
        .alu_control(ALUControl),
        .zero(Zero),
        .result(ALUResult)
    );

    
    // Data Memory
    wire [31:0] ReadData;

    DataMemory dataMem(
        .clk(clk),
        .addr(ALUResult),
        .write_data(ReadData2),
        .mem_write(MemWrite),
        .read_data(ReadData)
    );
  
endmodule
