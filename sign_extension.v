module sign_extension(imm, SignImm);

  /* Module Description: 
     - The module has an input imm which is the value to be extended.  
     - The module has an output SignImm which is the sign-extended value.
  */

  input wire [15:0] imm;
  output wire [31:0] SignImm;

  assign SignImm = {{16{imm[15]}}, imm};

endmodule
