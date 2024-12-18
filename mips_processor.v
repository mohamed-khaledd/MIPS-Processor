module mips_processor(clk, rst);
  
  input clk, rst;
  
  reg [31:0] pc;
  wire [31:0] instr, rd1, rd2, signImm, alu_result, read_data, srcb, Result;
  wire [4:0] WriteReg;
  wire [2:0] alu_control;
  wire MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, jump, zero;
  wire [31:0] pc_next, pc_branch, pc4;

  // Program Counter Logic

  assign pc4 = pc + 4;
  assign pc_branch = pc4 + (signImm << 2);
  assign pc_next = (jump) ? {pc[31:28], instr[25:0], 2'b00} : ((Branch & zero) ? pc_branch : pc4);

  always @(posedge clk or posedge rst) begin
    if (rst) 
      pc <= 0;
    else 
      pc <= pc_next;
  end

   ///// Modules Instantiation: ////
  
  // Instruction Memory:
  instruction_memory im(pc[11:2], instr);


  // Register file:
  assign WriteReg = (RegDst) ? instr[15:11] : instr[20:16];
  register_file rf(instr[25:21], instr[20:16], WriteReg, RegWrite, Result, clk, rd1, rd2);


  // Sign Extension unit:
  sign_extension se(instr[15:0], signImm);


  // Control unit:
  control_unit cu(instr[31:26], instr[5:0], MemtoReg, MemWrite, Branch, alu_control, ALUSrc, RegDst, RegWrite, jump);


  // ALU:
  assign srcb = (ALUSrc) ? signImm : rd2;
  ALU alu(rd1, srcb, alu_control, zero, alu_result);


  // Data Memory:
  data_memory dm(alu_result[11:2], rd2, clk, MemWrite, read_data);


  // Result Selection:
  assign Result = (MemtoReg) ? read_data : alu_result;

endmodule