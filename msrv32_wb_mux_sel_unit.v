module msrv32_wb_mux_sel_unit(alu_src_reg_in , wb_mux_sel_reg_in , alu_result_in , lu_output_in , imm_reg_in , iadder_out_reg_in , csr_data_in , pc_plus_4_reg_in , rs2_reg_in , wb_mux_out , alu_2nd_src_mux_out);
input alu_src_reg_in;
input [2:0] wb_mux_sel_reg_in;
input [31:0] alu_result_in , lu_output_in , imm_reg_in , iadder_out_reg_in , csr_data_in , pc_plus_4_reg_in , rs2_reg_in;
output reg[31:0] wb_mux_out , alu_2nd_src_mux_out;

always @(*)
begin
if(alu_src_reg_in == 1)
alu_2nd_src_mux_out = rs2_reg_in;
else
alu_2nd_src_mux_out = imm_reg_in;
end

always @(*)
begin
case(wb_mux_sel_reg_in)
3'b000 : wb_mux_out = alu_result_in;
3'b001 : wb_mux_out = lu_output_in;
3'b010 : wb_mux_out= imm_reg_in;
3'b011 : wb_mux_out= iadder_out_reg_in;
3'b100 : wb_mux_out = csr_data_in;
3'b101 : wb_mux_out = pc_plus_4_reg_in;
default : wb_mux_out = alu_result_in;
endcase
end
endmodule
