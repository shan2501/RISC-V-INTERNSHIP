module msrv32_decoder(trap_taken_in , funct7_5_in , opcode_in , funct3_in , iadder_out_1_to_0_in , wb_mux_sel_out , imm_type_out , csr_op_out , mem_wr_req_out , alu_opcode_out,load_size_out , load_unsigned_out , alu_src_out , iadder_src_out , csr_wr_en_out , rf_wr_en_out , illegal_instr_out , misaligned_load_out , misaligned_store_out);
input trap_taken_in , funct7_5_in ;
input [6:0] opcode_in ;
input [2:0] funct3_in ;
input [1:0] iadder_out_1_to_0_in;
output wire [2:0] wb_mux_sel_out , imm_type_out , csr_op_out;
output  wire mem_wr_req_out , alu_src_out , iadder_src_out , csr_wr_en_out , rf_wr_en_out , illegal_instr_out, misaligned_load_out, misaligned_store_out , load_unsigned_out;
output wire [3:0]alu_opcode_out ;
output wire  [2:0] load_size_out;
reg is_branch , is_jal , is_jalr , is_auipc , is_lui , is_op , is_op_imm , is_load , is_store , is_system , is_misc_mem;
reg is_addi , is_ori , is_xori , is_slti , is_andi , is_sltiu;
wire is_csr;
wire inter;
reg is_implemented_instr;
always@(opcode_in)
begin
case(opcode_in[6:2])
5'b11000 :
begin
 is_branch=1;
 is_implemented_instr=1;
end
5'b11011 :
begin
 is_jal=1;
  is_implemented_instr=1;
end
5'b11001 : 
begin
is_jalr = 1;
 is_implemented_instr=1;
end
5'b00101 : 
begin
is_auipc = 1;
 is_implemented_instr=1;
end
5'b01101 :
begin
 is_lui = 1;
  is_implemented_instr=1;
end
5'b01100 :
begin
  is_op = 1;
   is_implemented_instr=1;
end
5'b00100 :
begin
 is_op_imm = 1 ; 
  is_implemented_instr=1;
end
5'b01000 : 
begin
is_store = 1;
 is_implemented_instr=1;
end
5'b11100 :
begin
 is_system = 1;
  is_implemented_instr=1;
end
5'b00011 :
begin
 is_misc_mem = 1;
  is_implemented_instr=1;
end
5'b00000 : 
begin
is_load = 1;
 is_implemented_instr=1;
end
endcase
end
assign is_csr = (funct3_in[0] | funct3_in[1] | funct3_in[2]) & is_system;
assign csr_wr_en_out = is_csr;
assign rf_wr_en_out = (is_lui|is_auipc|is_jalr|is_jal|is_op|is_load|is_csr|is_op_imm)?1:0;
assign wb_mux_sel_out[0] = is_load|is_auipc|is_jalr|is_jal ? 1:0;
assign wb_mux_sel_out[1] = is_lui|is_auipc ? 1:0;
assign wb_mux_sel_out[2] = is_csr|is_jal|is_jalr ? 1:0;
assign imm_type_out[0]  = is_op_imm| is_load | is_jalr | is_branch | is_jal ? 1:0;
assign imm_type_out[1] = is_store| is_branch | is_csr ? 1:0;
assign imm_type_out[2] = is_lui | is_auipc | is_jal | is_csr ? 1:0;
assign iadder_src_out = is_load | is_store | is_jalr ? 1:0;

always @(funct3_in)
begin
case(funct3_in)
3'b000 : is_addi = is_load ;
3'b010 : is_slti = is_load ;
3'b011 : is_sltiu = is_load;
3'b111 : is_andi = is_load;
3'b110 : is_ori = is_load;
3'b100 : is_xori = is_load;
endcase
end

assign inter = ~(is_xori|is_ori|is_addi|is_slti|is_sltiu|is_andi) ? 1:0;
assign alu_opcode_out[3] = inter & funct7_5_in;
assign alu_opcode_out [2:0] = funct3_in;
assign csr_op_out = funct3_in; 
assign illegal_instr_out = (~is_implemented_instr | ~opcode_in[1] | ~opcode_in[0] )? 1 : 0;
assign load_size_out = funct3_in[1:0];
assign load_unsigned_out = funct3_in[2];
assign alu_src_out = opcode_in[4];
assign mal_word = (funct3_in[1:0] == 2'b10 && iadder_out_1_to_0_in !=0) ? 1:0 ;
assign mal_half = (funct3_in[1:0] == 2'b01 && iadder_out_1_to_0_in[0] !=0)? 1:0 ;
assign misaligned_load_out = ( mal_word | mal_half && is_load)? 1:0;
assign misaligned_store_out = (mal_word|mal_half && is_store)? 1:0;
endmodule


