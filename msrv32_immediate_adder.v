module msrv32_immediate_adder(pc_in , rs1_in , iadder_src_in , imm_in , iadder_out);
input [31:0] pc_in , rs1_in , imm_in;
output reg [31:0] iadder_out;
input iadder_src_in;

always @ (*)
begin
if (iadder_src_in)
iadder_out = pc_in + imm_in ;
else
iadder_out = rs1_in + imm_in;
end
endmodule