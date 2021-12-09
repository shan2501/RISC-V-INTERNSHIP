module msrv32_alu (op_1_in , op_2_in , opcode_in , result_out);
input [31:0] op_1_in , op_2_in ;
input [3:0] opcode_in ;
output reg[31:0] result_out;

wire ltus , lts ,cop1 ,cop2;
wire [31:0] crs1 , crs2;
assign crs1 = ~op_1_in + 1'b1;
assign crs2 = ~op_2_in + 1'b1;
assign cgs = crs1 > crs2 ? 1:0;
assign ltus = op_1_in < op_2_in ? 1:0;
assign lts = (op_1_in[31] != op_2_in[31])? ((op_1_in[31]==0)? 0:1):((op_1_in[31]==1)?cgs:ltus);

always @(*)
begin
case (opcode_in)
4'b0000: result_out = op_1_in + op_2_in ; 
4'b1000: result_out = op_1_in - op_2_in;
4'b0010: result_out = lts;
4'b0011: result_out = ltus;
4'b0111: result_out = op_1_in & op_2_in;
4'b0110: result_out = op_1_in | op_2_in;
4'b0100: result_out = op_1_in ^| op_2_in;
4'b0001: result_out = op_1_in << op_2_in;
4'b0101: result_out = op_1_in >> op_2_in;
4'b1101: result_out = op_1_in >>> op_2_in;
default: result_out = 32'h00000000;
endcase
end

endmodule


