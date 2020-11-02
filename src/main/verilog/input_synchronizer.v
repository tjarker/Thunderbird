module input_synchronizer(

    input   clock,
    input   reset_i,
    input   brake,
    input   left,
    input   right,
    input   hazard,
    output  reset_o,
    output  B,
    output  L,
    output  R,
    output  H
);

reg reset_o;
reg B;
reg L;
reg R;
reg H;

always @(posedge clock) begin
    reset_o = reset_i;
    B <= brake;
    L <= left;
    R <= right;
    H <= hazard;
end

endmodule