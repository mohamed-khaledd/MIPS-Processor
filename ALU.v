module ALU(o1, o2, alu_control, Z_flag, alu_result);

  /* Module Description:
     - The module has 3 inputs:
       1) o1, which is the first operand.
       2) o2, which is the second operand.
       3) alu_control, which is the control signal.
     - The module has 2 outputs:
       1) Z_flag, which is the zero flag.
       2) alu_result, which is the result of the ALU operation.
  */

    input wire [31:0] o1, o2;
    input wire [2:0] alu_control;
    output wire Z_flag;
    output reg [31:0] alu_result;

    assign Z_flag = (alu_result == 0) ? 1'b1 : 1'b0;

    always @(*) begin
        case (alu_control)
            3'b000: alu_result = o1 & o2; // bitwise and
            3'b001: alu_result = o1 | o2; // bitwise or
            3'b010: alu_result = o1 + o2; // addition
            3'b110: alu_result = o1 - o2; // subtraction
            3'b111: alu_result = (o1 < o2) ? 32'b1 : 32'b0; // set on less than
            default: alu_result = 32'b0; 
        endcase
    end
endmodule
