module fma16(input logic[15:0] x, y, z,
             input logic mul, add, negp, negz,
             input logic[1:0] roundmode,
             output logic[15:0] result, 
             output logic[3:0] flags);
        logic isneg, msb;
        logic[9:0] product;
        logic[4:0] sum;

    mult m1(x[9:0], y[9:0], mul, product, msb);
    add a1(x[14:10], y[14:10], msb, sum);
    
    assign isneg = negp ^ x[15] ^ y[15];
    assign result = {isneg, sum, product};
    assign flags = 4'b0000;

endmodule

module mult(input logic [9:0] xm, ym,
            input logic mul,
            output logic [9:0] product,
            output logic msb);
            logic [10:0] x1, y1;
            logic [21:0] prod1;
            logic [9:0] prod2, prod3;

    
    assign x1 = {1'b1, xm};
    assign y1 = {1'b1, ym};

    assign prod1 = x1 * y1;

    assign prod2 = prod1[20:11];
    assign prod3 = prod1[19:10];
    
    assign product = prod1[21] ? prod2 : prod3;

    assign msb = prod1[21];

endmodule

module add(input logic [4:0] xe, ye,
           input logic msb,
           output logic [4:0] sum);
           logic [4:0] sum1;

    assign sum1 = xe + ye - 15;
    assign sum = sum1 + {4'b0000, msb};

endmodule