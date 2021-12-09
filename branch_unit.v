module branch_unit( rs1_in , rs2_in , opcode_6_to_2_in , funct3_in , branch_taken_out);
input [31:0] rs1_in , rs2_in ;
input [6:2] opcode_6_to_2_in;
input [2:0] funct3_in;
output reg branch_taken_out;
wire [31:0] crs1 , crs2;

assign beq = (rs1_in == rs2_in)? 1:0;
assign bne = ~beq;
assign crs1 = ~rs1_in + 1'b1;
assign crs2 = ~rs2_in + 1'b1;

assign crsl = (crs1 < crs2)? 1:0;
assign bltu = (rs1_in < rs2_in)? 1:0;
assign bgeu = ~bltu;

assign bge = (rs1_in[31] != rs2_in[31])? ((rs1_in[31]==0)? 1:0):((rs1_in[31]==1)?crsl:bgeu);
assign blt =~bge;

always @ (*)
begin
if(opcode_6_to_2_in == 5'b11000)
begin
case(funct3_in)
3'b000 : branch_taken_out=beq;
3'b001 : branch_taken_out= bne;
3'b100 :branch_taken_out = blt;
3'b101 : branch_taken_out = bge;
3'b110 : branch_taken_out = bltu;
3'b111 : branch_taken_out = bgeu;
default: branch_taken_out = 0;
endcase
end
else if (opcode_6_to_2_in == 5'b11011 ||opcode_6_to_2_in == 5'b11001)
branch_taken_out = 1;
else
branch_taken_out = 1;
end
endmodule




