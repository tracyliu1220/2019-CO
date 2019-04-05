`timescale 1ns/1ps
/*
module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)

               set, // bot
               overflow //bot
               );
*/
module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		 //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
// if (rst_n != 1)
    // endmodule;

input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire    [32-1:0] result;
reg             zero = 0;
reg             cout;
wire             overflow;

wire            Ainvert, Bnegate;
wire    [2-1:0] operator;
wire    [32-1:0] w_cout;
wire             set;
// reg     [5-1:0] idx;

genvar          idx;

if (ALU_control == 4'b0000)
    assign operator = 2'b00;
else if (ALU_control == 4'b0001)
    assign operator = 2'b01;
else if (ALU_control == 4'b0010)
    assign operator = 2'b10;
else if (ALU_control == 4'b0110) begin
    assign operator = 2'b10;
    assign Bnegate = 1;
end




      //ax(src1, src2, less, A_invert, B_invert, cin, operation, result, cout);
alu_top a00(src1[ 0], src2[ 0], set, Ainvert, Bnegate,    Bnegate, operator, result[ 0], w_cout[ 0]),
        a01(src1[ 1], src2[ 1],   1'b0, Ainvert, Bnegate, w_cout[ 0], operator, result[ 1], w_cout[ 1]),
        a02(src1[ 2], src2[ 2],   1'b0, Ainvert, Bnegate, w_cout[ 1], operator, result[ 2], w_cout[ 2]),
        a03(src1[ 3], src2[ 3],   1'b0, Ainvert, Bnegate, w_cout[ 2], operator, result[ 3], w_cout[ 3]),
        a04(src1[ 4], src2[ 4],   1'b0, Ainvert, Bnegate, w_cout[ 3], operator, result[ 4], w_cout[ 4]),
        a05(src1[ 5], src2[ 5],   1'b0, Ainvert, Bnegate, w_cout[ 4], operator, result[ 5], w_cout[ 5]),
        a06(src1[ 6], src2[ 6],   1'b0, Ainvert, Bnegate, w_cout[ 5], operator, result[ 6], w_cout[ 6]),
        a07(src1[ 7], src2[ 7],   1'b0, Ainvert, Bnegate, w_cout[ 6], operator, result[ 7], w_cout[ 7]),
        a08(src1[ 8], src2[ 8],   1'b0, Ainvert, Bnegate, w_cout[ 7], operator, result[ 8], w_cout[ 8]),
        a09(src1[ 9], src2[ 9],   1'b0, Ainvert, Bnegate, w_cout[ 8], operator, result[ 9], w_cout[ 9]),
        a10(src1[10], src2[10],   1'b0, Ainvert, Bnegate, w_cout[ 9], operator, result[10], w_cout[10]),
        a11(src1[11], src2[11],   1'b0, Ainvert, Bnegate, w_cout[10], operator, result[11], w_cout[11]),
        a12(src1[12], src2[12],   1'b0, Ainvert, Bnegate, w_cout[11], operator, result[12], w_cout[12]),
        a13(src1[13], src2[13],   1'b0, Ainvert, Bnegate, w_cout[12], operator, result[13], w_cout[13]),
        a14(src1[14], src2[14],   1'b0, Ainvert, Bnegate, w_cout[13], operator, result[14], w_cout[14]),
        a15(src1[15], src2[15],   1'b0, Ainvert, Bnegate, w_cout[14], operator, result[15], w_cout[15]),
        a16(src1[16], src2[16],   1'b0, Ainvert, Bnegate, w_cout[15], operator, result[16], w_cout[16]),
        a17(src1[17], src2[17],   1'b0, Ainvert, Bnegate, w_cout[16], operator, result[17], w_cout[17]),
        a18(src1[18], src2[18],   1'b0, Ainvert, Bnegate, w_cout[17], operator, result[18], w_cout[18]),
        a19(src1[19], src2[19],   1'b0, Ainvert, Bnegate, w_cout[18], operator, result[19], w_cout[19]),
        a20(src1[20], src2[20],   1'b0, Ainvert, Bnegate, w_cout[19], operator, result[20], w_cout[20]),
        a21(src1[21], src2[21],   1'b0, Ainvert, Bnegate, w_cout[20], operator, result[21], w_cout[21]),
        a22(src1[22], src2[22],   1'b0, Ainvert, Bnegate, w_cout[21], operator, result[22], w_cout[22]),
        a23(src1[23], src2[23],   1'b0, Ainvert, Bnegate, w_cout[22], operator, result[23], w_cout[23]),
        a24(src1[24], src2[24],   1'b0, Ainvert, Bnegate, w_cout[23], operator, result[24], w_cout[24]),
        a25(src1[25], src2[25],   1'b0, Ainvert, Bnegate, w_cout[24], operator, result[25], w_cout[25]),
        a26(src1[26], src2[26],   1'b0, Ainvert, Bnegate, w_cout[25], operator, result[26], w_cout[26]),
        a27(src1[27], src2[27],   1'b0, Ainvert, Bnegate, w_cout[26], operator, result[27], w_cout[27]),
        a28(src1[28], src2[28],   1'b0, Ainvert, Bnegate, w_cout[27], operator, result[28], w_cout[28]),
        a29(src1[29], src2[29],   1'b0, Ainvert, Bnegate, w_cout[28], operator, result[29], w_cout[29]),
        a30(src1[30], src2[30],   1'b0, Ainvert, Bnegate, w_cout[29], operator, result[30], w_cout[30]);
alu_bot a31(src1[31], src2[31],   1'b0, Ainvert, Bnegate,       cout, operator, result[31], set, overflow);

/*
for (idx = 0; idx < 32; idx = idx + 1) begin
    assign zero = zero | result[idx];
end
assign zero = ~zero;
*/

endmodule
