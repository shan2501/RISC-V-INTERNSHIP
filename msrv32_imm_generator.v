module msrv32_imm_generator(instr_in , imm_type_in , imm_out);
input [31:7] instr_in;
input [2:0] imm_type_in;
output reg [31:0] imm_out;
reg [31:0] i_type , j_type , s_type , b_type , u_type , csr_type ;

always @ (*)
begin
i_type = {{20{instr_in[31]}}, instr_in[31:20]};
j_type = {{12{instr_in[31]}} , instr_in[19:12] , instr_in[20] , instr_in[30:21],1'b0};
s_type = {{20{instr_in[31]}} , instr_in[31:25] , instr_in[11:7]};
b_type = {{20{instr_in[31]}} , instr_in[7],instr_in[30:25] , instr_in[11:8] , 1'b0};
u_type = { instr_in[31:12] , 12'h0000};
csr_type = {27'b0 , instr_in[19:15]};
case(imm_type_in)
3'b000 , 3'b001 ,3'b111 : imm_out = i_type;
3'b010:imm_out = s_type;
3'b011:imm_out = b_type;
3'b100:imm_out = u_type;
3'b101:imm_out = j_type;
3'b110:imm_out = csr_type;
default : imm_out = 32'h00000000;
endcase
end
endmodule
