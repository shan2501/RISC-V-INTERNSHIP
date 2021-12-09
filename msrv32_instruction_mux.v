module msrv32_instruction_mux(flush_in , instr_in , opcode_out , funct3_out , funct7_out , rs1_addr_out , rs2_addr_out , rd_addr_out , csr_addr_out , instr_31_7_out);
input flush_in 
input [31:0] instr_in;
output wire[6:0] opcode_out;
output wire[2:0] funct3_out;
output wire[6:0] funct7_out;
output wire[11:0] csr_addr_out;
output wire[4:0] rs1_addr_out;
output wire[4:0] rs2_addr_out;
output wire[4:0] rd_addr_out;
output wire[31:7] instr_31_7_out;

wire [31:0] instr_out;
assign instr_out = flush_in ? 32'h00000013 : instr_in ;

assign opcode_out = instr_out[6:0];
assign funct3_out = instr_out[14:12];
assign funct7_out = instr_out[31:25];
assign csr_addr_out = instr_out[31:20];
assign rs1_addr_out = instr_out[19:15];
assign rs2_addr_out = instr_out[24:20];
assign rd_addr_out = instr_out[11:7];
assign instr_31_7_out = instr_out[31:7];
endmodule
