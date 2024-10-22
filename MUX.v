`timescale 1ns / 1ps
module MUX(
    input [31:0] D0,
    input [31:0] D1,
    input S,
    output reg [31:0] Y
    );

always @ (*)
    begin
        if(S == 1)
            Y = D1;
        else
            Y = D0;
    end
endmodule
