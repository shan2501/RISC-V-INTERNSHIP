module msrv32_pc(rst_in , pc_src_in , pc_in , epc_in , trap_address_in , branch_taken_in ,iaddr_in , misaligned_instr_out, pc_mux_out , pc_plus_4_out , i_addr_out);
input rst_in, branch_taken_in;
input [1:0] pc_src_in;
input [31:0] pc_in , epc_in , trap_address_in;
input [31:1] iaddr_in;
output misaligned_instr_out ;
output reg [31:0] pc_mux_out , pc_plus_4_out , i_addr_out;

reg [31:0] ladder_out , next_pc ;
parameter boot_address = 32'h00000000 ; 


always @ (*)
begin
ladder_out = {iaddr_in , 1'b0};
pc_plus_4_out = pc_in + 32'h00000004;
case(branch_taken_in)
1'b1:next_pc = ladder_out;
1'b0:next_pc = pc_plus_4_out;
endcase
end

always @(*)
begin
case(pc_src_in)
2'b00 : pc_mux_out = boot_address;
2'b01 : pc_mux_out = epc_in;
2'b10 : pc_mux_out = trap_address_in;
2'b11 : pc_mux_out = next_pc;
default : pc_mux_out = next_pc;
endcase
end

assign misaligned_instr_out = next_pc[1] & branch_taken_in ;

always @ ( * )
begin 
if ( rst_in)
i_addr_out = boot_address;
else
i_addr_out = pc_mux_out;
end
endmodule
