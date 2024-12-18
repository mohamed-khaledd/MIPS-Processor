module register_file(RA1, RA2, WA, WE, WD, clk, RD1, RD2);

   /* Module Description:
      - The module has 6 inputs:
        1) RA1, which is the address of the first register to read from.
        2) RA2, which is the address of the second register to read from.
        3) WA, which is the address of the register where data will be written.
        4) WE, which is the write enable signal.
        5) WD, which is the data that will be written into the register specified by WA.
        6) clk, which is the clock signal.
      - The module has 2 outputs:
        1) RD1, which is the data read from the register specified by RA1.
        2) RD2, which is the data read from the register specified by RA2.
   */
   
    input wire [4:0] RA1, RA2, WA;
    input wire clk, WE;
    input wire [31:0] WD;
    output wire [31:0] RD1, RD2;

    reg [31:0] regFile [0:31];
    integer i;

    initial begin
        
        for (i = 0; i < 32; i = i + 1) begin
            regFile[i] = 32'b0;    // Initializing all registers to zero
        end

        regFile[8] = 32'd10;   // $t0 initialized to 10
        regFile[9] = 32'd20;   // $t1 initialized to 20
        regFile[10] = 32'd30;  // $t2 initialized to 30
    end

    assign RD1 = regFile[RA1];
    assign RD2 = regFile[RA2];

    always @(posedge clk) begin
        if (WE)
            regFile[WA] <= WD;
    end
endmodule

