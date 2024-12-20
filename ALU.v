module ALU(
    input [31:0] input1, input2,
    input [2:0] alu_control,
    output zero,
    output [31:0] result
);

  /* Module Description:
     - The module has 3 inputs:
       1) input1, which is the first operand.
       2) input2, which is the second operand.
       3) alu_control, which is the control signal.
     - The module has 2 outputs:
       1) zero, which is the zero flag.
       2) result, which is the result of the ALU operation.

       Note: This ALU supports addition and subtraction only
  */

    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
    assign result = (alu_control == 3'b010) ? input1 + input2 : (alu_control == 3'b110) ? input1 - input2 : 32'b0;

endmodule
