module ms_riscv32_mp(ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , ms_riscv32_mp_dmdata_in , ms_riscv32_mp_instr_in , ms_riscv32_mp_rc_in , ms_riscv32_mp_eirq_in , ms_riscv32_mp_tirq_in , ms_riscv32_mp_sirq_in , ms_riscv32_mp_dmwr_req_out , ms_riscv32_mp_imaddr_out , ms_riscv32_mp_dmaddr_out , ms_riscv32_mp_dmdata_out , ms_riscv32_mp_dmwr_mask_out);
input ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in, ms_riscv32_mp_tirq_in , ms_riscv32_mp_sirq_in , ms_riscv32_mp_eirq_in;
input reg[31:0] ms_riscv32_mp_dmdata_in;
input reg[31:0] ms_riscv32_mp_instr_in;
input reg[63:0] ms_riscv32_mp_rc_in;
output ms_riscv32_mp_dmwr_req_out;
output reg[31:0] ms_riscv32_mp_imaddr_out , ms_riscv32_mp_dmaddr_out , ms_riscv32_mp_dmdata_out;
output reg[3:0] ms_riscv32_mp_dmwr_mask_out;

//pc

reg [31:0] pc_mux_out , pc_plus_4_out , i_addr_out;
wire rst_in, branch_taken_in;
wire [1:0] pc_src_in;
wire [31:0] pc_in , epc_in , trap_address_in;
wire [31:1] iaddr_in;
wire misaligned_instr_out ;

//alu
wire [31:0] op_1_in , op_2_in ;
wire [3:0] opcode_in ;
reg[31:0] result_out;

//decoder

wire trap_taken_in , funct7_5_in ;
wire [6:0] opcode_in ;
wire [2:0] funct3_in ;
wire [1:0] iadder_out_1_to_0_in;
 wire [2:0] wb_mux_sel_out , imm_type_out , csr_op_out;
  wire mem_wr_req_out , alu_src_out , iadder_src_out , csr_wr_en_out , rf_wr_en_out , illegal_instr_out, misaligned_load_out, misaligned_store_out , load_unsigned_out;
wire [3:0]alu_opcode_out ;
 wire  [2:0] load_size_out;

//branch_unit

wire [31:0] rs1_in , rs2_in ;
wire [6:2] opcode_6_to_2_in;
wire [2:0] funct3_in;
reg branch_taken_out;

//immediate generator

wire [31:7] instr_in;
wire [2:0] imm_type_in;
 reg [31:0] imm_out;

//immediate adder

wire [31:0] pc_in , rs1_in , imm_in;
 reg [31:0] iadder_out;
wire iadder_src_in;

//instruction mux

 wire flush_in , instr_in;
 wire[6:0] opcode_out;
 wire[2:0] funct3_out;
 wire[6:0] funct7_out;
 wire[11:0] csr_addr_out;
 wire[4:0] rs1_addr_out;
 wire[4:0] rs2_addr_out;
 wire[4:0] rd_addr_out;
 wire[31:7] instr_31_7_out;

//integer file

wire ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , wr_en_in;
wire [4:0] rs_2_addr_in , rd_addr_in  , rs_1_addr_in;
wire [31:0] rd_in;
 reg[31:0] rs_1_out , rs_2_out ;

// load unit
wire [1:0] iadder_out_1_to_0_in , load_size_in ;
wire load_unsigned_in;
wire [31:0] ms_riscv32_mp_dmdata_in;
reg [31:0] lu_output_out;

// reg_block1
wire [31:0] pc_mux_in;
wire ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in ;
 reg [31:0] pc_out ;

// reg_block2

wire clk_in, reset_in , branch_taken_in ,load_unsigned_in , alu_src_in , csr_wr_en_in , rf_wr_en_in ;
wire [4:0] rd_addr_in;
wire [11:0] csr_addr_in;
wire [31:0] rs1_in,rs2_in , pc_in , pc_plus_4_in , iadder_in , imm_in;
wire [3:0] alu_opcode_in;
wire [1:0] load_size_in;
wire [2:0] wb_mux_sel_in , csr_op_in;
reg[31:0] imm_reg_out , rs1_reg_out,rs2_reg_out,pc_reg_out,pc_plus_4_reg_out,iadder_out_reg_out;
reg[4:0] rd_addr_reg_out;
reg[11:0] csr_addr_reg_out;
reg load_unsigned_reg_out , alu_src_reg_out , csr_wr_en_reg_out , rf_wr_en_reg_out;
reg [3:0] alu_opcode_reg_out;
reg[1:0] load_size_reg_out;
reg[2:0] wb_mux_sel_reg_out , csr_op_reg_out;

// store_unit
wire [1:0] funct3_in ;
wire [31:0] iadder_in;
wire [31:0] rs2_in;
wire mem_wr_req_in;
reg[31:0] ms_riscv32_mp_dmdata_out ;
wire [31:0] ms_riscv32_mp_dmaddr_out ;
reg[3:0] ms_riscv32_mp_dmwr_mask_out;
wire ms_riscv32_mp_dmwr_req_out;

//wbmuxsel

wire alu_src_reg_in;
wire [2:0] wb_mux_sel_reg_in;
wire [31:0] alu_result_in , lu_output_in , imm_reg_in , iadder_out_reg_in , csr_data_in , pc_plus_4_reg_in , rs2_reg_in;
reg[31:0] wb_mux_out , alu_2nd_src_mux_out;

// wr_en_generator

wire flush_in , rf_wr_en_reg_in , csr_wr_en_reg_in;
reg wr_en_integer_file_out , wr_en_csr_file_out;

// machine_control
wire ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , ms_riscv32_mp_eirq_in , ms_riscv32_tirq_in , ms_riscv32_sirq_in ,illegal_instr_in , misaligned_load_in , misaligned_store_in;
wire misaligned_instr_in;
wire [4:0] opcode_6_to_2_in , rs1_addr_in , rs2_addr_in , rd_addr_in;
wire [2:0] funct3_in;
wire [6:0] funct7_in;
wire mie_in;

wire i_or_e_out , instret_inc_out , mie_clear_out , mie_set_out , misaligned_exception_out , set_epc_out , set_cause_out , flush_out , trap_taken_out , meie_in , mtie_in , msie_in , meip_in , mtip_in , msip_in;
wire [3:0] cause_out , pc_src_out;

//csr

wire i_or_e_in  , instret_inc_in , mie_clear_in , mie_set_in , set_epc_in , set_cause_in , ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , meie_out , mtie_out , msie_out , meip_out , mtip_out , msip_out ;
wire ms_riscv32_mp_eirq_in , wire_riscv32_mp_sirq_in , ms_riscv32_mp_tirq_in ;
wire csr_data_out , mie_out , wr_en_in;
wire [3:0] cause_in , csr_op_in;
wire [31:0] csr_data_out , csr_data_in ,pc_in , iadder_in , trap_address_out , epc_out;
wire [11:0] csr_addr_in ;
wire [4:0] csr_uimm_in;
wire [63:0] ms_riscv32_mp_rc_in;

// connections

msrv32_pc_mux m1 (.pc_src_in (pc_src_out) , .epc_in(set_epc_out) , .trap_address_in(trap_address_out),.branch_taken_in(branch_taken_out) , .iaddr_in(iadder_out),.rst_in(ms_riscv32_mp_rst_in) , .i_addr_out(ms_riscv32_mp_imaddr_out) , .pc_plus_4_out(.pc_plus_4_out) ,.misaligned_instr_out(.misaligned_instr_out), .pc_mux_out(pc_mux_out) , .pc_in(pc_out));
msrv32_reg_block_1 m2 (.pc_mux_in(pc_mux_out) , .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in) ,.ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in) , .pc_out(pc_out));
msrv32_imm_generator m3(.instr_in(instr_31_7_out) , .imm_type_in(imm_type_out),.imm_out(imm_out));
msrv32_immediate_adder m4 (.imm_in(imm_out) , .pc_in(pc_out) , .iadder_src_in(iadder_src_out) ,.rs1_in(rs_1_out), .iadder_out(iadder_out) );
msrv32_integer_file m5(.rd_in(wb_mux_out) , .wr_en_in(wr_en_integer_file_out) , .rd_addr_in(rd_addr_out) , .rs_2_addr_in(rs2_addr_out) , .rs_1_addr_in(rs1_addr_out) ,.rs_1_out(rs_1_out), .rs_2_out(rs_2_out), .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in));
msrv32_wr_en_generator m6(.flush_in(flush_out) , .rf_wr_en_reg_in(rf_wr_en_reg_out) , .csr_wr_en_reg_in(csr_wr_en_reg_out) , .csr_file_wr_en_out(csr_file_wr_en_out) , .wr_en_integer_file_out(wr_en_integer_file_out));
msrv32_instruction_mux m7 (.flush_in(flush_out) , .ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in) , .opcode_out(opcode_out) , .funct3_out(funct3_out) , .funct7_out(funct7_out) , .rs1_addr_out(rs1_addr_out) ,.rs2_addr_out(rs2_addr_out) , .rd_addr_out(rd_addr_out) , .csr_addr_out(csr_addr_out) , .instr_31_7_out(instr_31_7_out));
msrsv32_branch_unit m8 (.rs1_in(rs_1_out) , .rs2_in(rs_2_out) , .opcode_6_to_2_in(opcode_out), .funct3_in(funct3_out) , .branch_taken_out(branch_taken_out));
msrv32_decoder m9(.opcode_in(opcode_out) , .funct3_in(funct3_out) , .trap_taken_in(trap_taken_out) , .funct7_5_in(funct7_out) , .iadder_out_1_to_0_in(iadder_out) , .wb_mux_sel_out(wb_mux_sel_out) , .imm_type_out(imm_type_out) , .csr_op_out(csr_op_out),  .mem_wr_req_out(mem_wr_req_out) , .alu_src_out(alu_src_out) , .iadder_src_out(iadder_src_out) , .csr_wr_en_out(csr_wr_en_out) ,
 .rf_wr_en_out(rf_wr_en_out), .illegal_instr_out(illegal_instr_out), .misaligned_load_out(misaligned_load_out), .misaligned_store_out(misaligned_store_out) , .load_unsigned_out(load_unsigned_out); 

msrv32_machine_control m10(.ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in), .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in), .ms_riscv32_mp_tirq_in(ms_riscv32_mp_tirq_in) , .ms_riscv32_mp_sirq_in(ms_riscv32_mp_sirq_in) , .ms_riscv32_mp_eirq_in(ms_riscv32_mp_eirq_in) , .illegal_instr_in(illegal_instr_out) , .misaligned_load_in(misaligned_load_out),.misaligned_store_in(mialigned_store_out),.misaligned_instr_in(misaligned_instr_out),
 .opcode_6_to_2_in(opcode_out) , .funct3_in(funct3_out) , .funct7_in(funct7_out) , .cause_out(cause_out),.rs1_addr_in(rs1_addr_out),.rs2_addr_in(rs2_addr_out) , .rd_addr_in(rd_addr_out) ,.i_or_e_out(i_or_e_out) , .instret_inc_out(instret_inc_out) , .mie_clear_out(mie_clear_out) , .mie_set_out(mie_set_out) , .misaligned_exception_out(misaligned_exception_out) , .set_epc_out(set_epc_out ) , .set_cause_out(set_cause_out) , .flush_out(flush_out) , .trap_taken_out(trap_taken_out) , .meie_in(meie_out), .mtie_in(mtie_out) , .msie_in(msie_out) , .meip_in(meip_out) , .mtip_in(mtip_out) , .msip_in(msip_out));

msrv32_csr_file m11 (.i_or_e_in(i_or_e_out) ,.cause_in(cause_out) , .instret_inc_in(instret_inc_out) ,.mie_set_in(mie_set_out), .mie_clear_in(.mie_clear_out),.misaligned_exception_in(misaligned_exception_out),.set_epc_out(set_epc_in),set_cause_out(set_cause_in) ,.ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in) , .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in) , .meie_out(meie_out) , .mtie_out(mtie_out) , .msie_out(msie_out) , .meip_out(meip_out),.mtip_out(mtip_out),.msip_out(msip_out),.epc_out(epc_out) , .csr_data_out(csr_data_out) , .ms_riscv32_mp_rc_in(ms_riscv32_mp_rc_in) , .wr_en_in(wr_en_csr_file_out) ,
.csr_addr_in(csr_addr_reg_out) , .csr_op_in(csr_op_reg_out) , .csr_uimm_in(imm_reg_out) , .csr_data_in(rs1_reg_out) , .pc_in(pc_reg_out) , .iadder_in(iadder_out_reg_out) );


msrv32_reg_block2 m12 (ms_riscv32_mp_clk_in , .ms_riscv32_mp_rst_in , rd_addr_out , csr_addr_out , rs_1_out , rs_2_out ,pc_mux_out , pc_plus_4_out , branch_taken_out , iadder_out , alu_opcode_out , load_size_out , load_unsigned_out , alu_src_out, csr_wr_en_out, rf_wr_en_out , wb_mux_sel_out , csr_op_out, imm_out , imm_reg_out , csr_op_reg_out , wb_mux_sel_reg_out , rf_wr_en_reg_out , csr_wr_en_reg_out, alu_src_reg_out, load_unsigned_reg_out , load_size_reg_out , alu_opcode_reg_out , iadder_out_reg_out , pc_plus_4_reg_out , pc_reg_out , rs2_reg_out , rs1_reg_out , csr_addr_reg_out , rd_addr_reg_out);
  
msrv32_store_unit m13 (funct3_out , iadder_out , rs_2_out , mem_wr_req_out , ms_riscv32_mp_dmdata_out , ms_riscv32_mp_dmaddr_out , ms_riscv32_mp_dmwr_mask_out , ms_riscv32_mp_dmwr_req_out);

msrv32_load_unit m14 (ms_riscv32_mp_dmdata_in , iadder_out_reg_out , load_unsigned_reg_out , load_size_reg_out , lu_output_out);

msrv32_alu m15 (rs1_reg_out , alu_2nd_src_mux_out , alu_opcode_reg_out , result_out);

msrv32_wb_mux_sel_unit(alu_src_reg_out , wb_mux_sel_reg_out , result_out , lu_output_out ,imm_reg_out ,iadder_out_reg_out, csr_data_out , pc_plus_4_reg_out, rs2_reg_out , wb_mux_out , alu_2nd_src_mux_out);

endmodule