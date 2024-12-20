module ControlUnit(
    input [5:0] opcode, funct,
    output reg mem_to_reg, mem_write, alu_src, branch, reg_dst, reg_write, jump,
    output reg [2:0] alu_control
);

  /* Module Description: 
   - The module has 2 inputs:   
       1) opcode, which is the op-code of the instruction.
       2) funct, which is the function of r-format instructions.
   - The module has 8 outputs:
       1) mem_to_reg, which decides whether the data to be written into a register comes from the memory or from the ALU result.
       2) mem_write, which enables writing data to memory.
       3) branch, which is the branch signal.
       4) alu_control, which is the alu control signal.
       5) alu_src, which determines the second operand for the ALU operation.
       6) reg_dst, which determines which register will be written to.
       7) reg_write, which enables writing data to a register.
       8) jump, which is the jump signal.
  */

    always @(*) begin
        mem_to_reg = 0; mem_write = 0; alu_src = 0; branch = 0; reg_dst = 0; reg_write = 0; jump = 0; alu_control = 3'b000;   // default values

        case (opcode)
            6'b000000: begin // R-type
                reg_dst = 1; reg_write = 1;
                case (funct)
                    6'b100000: alu_control = 3'b010; // ADD
                    6'b100010: alu_control = 3'b110; // SUB
                    default: alu_control = 3'b000;
                endcase
            end
          
            6'b100011: begin // LW
                alu_src = 1; mem_to_reg = 1; reg_write = 1; alu_control = 3'b010;
            end
          
            6'b101011: begin // SW
                alu_src = 1; mem_write = 1; alu_control = 3'b010;
            end
          
            6'b000100: begin // BEQ
                branch = 1; alu_control = 3'b110;
            end
          
            6'b000010: begin // JUMP
                jump = 1;
            end
            default: ;
        endcase
    end
endmodule
