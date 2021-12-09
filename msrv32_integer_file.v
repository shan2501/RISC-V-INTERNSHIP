module msrv32_integer_file(ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , rs_2_addr_in , rd_addr_in , wr_en_in , rd_in , rs_1_addr_in , rs_1_out , rs_2_out);
input ms_riscv32_mp_clk_in , ms_riscv32_mp_rst_in , wr_en_in;
input [4:0] rs_2_addr_in , rd_addr_in  , rs_1_addr_in;
input [31:0] rd_in;
output reg[31:0] rs_1_out , rs_2_out ;
integer i , j;

reg [31:0] reg_file [0:31] ; 

always @ (*)
begin
if(rs_1_addr_in == rd_addr_in && wr_en_in == 1 && rd_addr_in !=0)
rs_1_out = rd_in;
else
rs_1_out = reg_file[rs_1_addr_in];
end

always @ (*)
begin
if(rs_2_addr_in == rd_addr_in && wr_en_in == 1 && rd_addr_in !=0)
rs_2_out = rd_in;
else
rs_2_out = reg_file[rs_2_addr_in];
end



always @ (posedge ms_riscv32_mp_clk_in )
begin
if(ms_riscv32_mp_rst_in==1)
begin
for(j=0 ; j<32 ; j=j+1)
reg_file[j] <= 32'h00000000;
end
else 
begin
if(wr_en_in && rd_addr_in )
reg_file[rd_addr_in] <= rd_in; 
end
end
endmodule


