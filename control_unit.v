module control_unit(op,funct,MemtoReg,MemWrite,branch,alu_control,alu_src,RegDst,RegWrite,jump);

  /* Module Description: 
   - The module has 2 inputs:   
       1) op, which is the op-code of the instruction.
       2) funct, which is the function of r-format instructions.
   - The module has 8 outputs:
       1) MemtoReg, which decides whether the data to be written into a register comes from the memory or from the ALU result.
       2) MemWrite, which enables writing data to memory.
       3) branch, which is the branch signal.
       4) alu_control, which is the alu control signal.
       5) alu_src, which determines the second operand for the ALU operation.
       6) RegDst, which determines which register will be written to.
       7) RegWrite, which enables writing data to a register.
       8) jump, which is the jump signal.
  */

  input wire [5:0] op,funct;
  output reg MemtoReg,MemWrite,branch,alu_src,RegDst,RegWrite,jump;
  output reg [2:0] alu_control;

  always @ (*) begin
      case(op)
          6'b000000: // R-format
           begin
              case(funct)
                 6'b100000: alu_control = 3'b010;  // add
                 6'b100010: alu_control = 3'b110;  // subtract
                 6'b100100: alu_control = 3'b000;  // and
                 6'b100101: alu_control = 3'b001;  // or
                 6'b101010: alu_control = 3'b111;  // slt
              endcase
              MemtoReg = 1'b0;
              MemWrite = 1'b0;
              branch = 1'b0;
              alu_src = 1'b0;
              RegDst = 1'b1;
              RegWrite  = 1'b1;
              jump = 1'b0;
            end

          6'b100011: // lw
            begin
              alu_control = 3'b010;
              MemtoReg = 1'b1;
              MemWrite = 1'b0;
              branch = 1'b0;
              alu_src = 1'b1;
              RegDst = 1'b0;
              RegWrite  = 1'b1;
              jump = 1'b0;
            end


          6'b101011: // sw
            begin
              alu_control = 3'b010;
              MemtoReg = 1'bx;
              MemWrite = 1'b1;
              branch = 1'b0;
              alu_src = 1'b1;
              RegDst = 1'bx;
              RegWrite  = 1'b0;
              jump = 1'b0;
            end

          6'b000100: // beq
            begin
              alu_control = 3'b110;
              MemtoReg = 1'bx;
              MemWrite = 1'b0;
              branch = 1'b1;
              alu_src = 1'b0;
              RegDst = 1'bx;
              RegWrite  = 1'b0;
              jump = 1'b0;
            end

          6'b001000: // addi
            begin 
              alu_control = 3'b010;  
              MemtoReg = 1'b0;
              MemWrite = 1'b0;
              branch = 1'b0;
              alu_src = 1'b1;
              RegDst = 1'b0;
              RegWrite  = 1'b1;
              jump = 1'b0;
            end


          6'b000010: // j 
            begin
              alu_control = 3'bxxx;   
              MemtoReg = 1'bx;
              MemWrite = 1'b0;
              branch = 1'bx;
              alu_src = 1'bx;
              RegDst = 1'bx;
              RegWrite  = 1'b0;
              jump = 1'b1;
            end

      endcase
    end

endmodule
