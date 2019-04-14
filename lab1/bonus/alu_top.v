`timescale 1ns/1ps

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               equal,
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               bonus,
               comp,
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               set
               );

input         src1;
input         src2;
input         less;
input         equal;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;
input [3-1:0] bonus; 
input         comp;

output        result;
output        cout;
output        set;

reg           result;
reg           _src1;
reg           _src2;
reg           cout;
reg           set;
wire          compare_result;

compare cmp(less, equal, bonus, comp, compare_result);

always@( * ) begin
    // init
    _src1 = src1;
    _src2 = src2;
    if (A_invert) _src1 = ~src1;
    if (B_invert) _src2 = ~src2;
    {cout, result} = _src1 + _src2 + cin;
    set = result;

/*
    if (bonus == 3'b000)
        compare_result = less;
    else if (bonus == 3'b001)
        compare_result = ~less && ~equal;
    else if (bonus == 3'b010)
        compare_result = less | equal;
    else if (bonus == 3'b011)
        compare_result = ~less | equal;
    else if (bonus == 3'b110)
        compare_result = equal;
    else if (bonus == 3'b100)
        compare_result = ~equal;
*/
    
    if (operation == 2'b00) // AND
        result = _src1 & _src2;
    else if (operation == 2'b01) // OR
        result = _src1 | _src2;
    else if (operation == 2'b10) // ADD
        {cout, result} = _src1 + _src2 + cin;
    else if (operation == 2'b11) begin // LESS
        
/*
        case(bonus_control)
            3'b000: result = less;
            3'b001: result = ~less;
            3'b010: result = less | equal;
            3'b011: result = ~less | equal;
            3'b110: result = equal;
            3'b100: result = ~equal;
        endcase
*/
        result = compare_result & comp;
    end
end

endmodule
