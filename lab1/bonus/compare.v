`timescale 1ns/1ps

module compare(
               less,       //1 bit less     (input)
               equal,
               bonus,
               comp,
               result     //1 bit result   (output)
               );

input         less;
input         equal;
input [3-1:0] bonus; 
input         comp;

output        result;

reg           result;

always@( * ) begin

    if (bonus == 3'b000)
        result = less;
    else if (bonus == 3'b001)
        result = ~less && ~equal;
    else if (bonus == 3'b010)
        result = less | equal;
    else if (bonus == 3'b011)
        result = ~less | equal;
    else if (bonus == 3'b110)
        result = equal;
    else if (bonus == 3'b100)
        result = ~equal;
    
    result = result & comp;
end

endmodule
