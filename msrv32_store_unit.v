module msrv32_store_unit (funct3_in , iadder_in , rs2_in , mem_wr_req_in , ms_riscv32_mp_dmdata_out , ms_riscv32_mp_dmaddr_out , ms_riscv32_mp_dmwr_mask_out , ms_riscv32_mp_dmwr_req_out);
input [1:0] funct3_in ;
input [31:0] iadder_in;
input [31:0] rs2_in;
input mem_wr_req_in;
output reg[31:0] ms_riscv32_mp_dmdata_out ;
output wire [31:0] ms_riscv32_mp_dmaddr_out ;
output reg[3:0] ms_riscv32_mp_dmwr_mask_out;
output wire ms_riscv32_mp_dmwr_req_out;

assign ms_riscv32_mp_dmaddr_out = {iadder_in[31:2],2'b00};
assign ms_riscv32_mp_dmwr_req_out = mem_wr_req_in;

always @ (*)
begin
case (funct3_in)
2'b00 : 
begin
case(iadder_in)
2'b00:
ms_riscv32_mp_dmdata_out = {8'b0 , 8'b0 , 8'b0 ,rs2_in[7:0]};
2'b01:
ms_riscv32_mp_dmdata_out = {8'b0 , 8'b0 ,rs2_in[7:0],8'b0};
2'b10:
ms_riscv32_mp_dmdata_out = {8'b0 ,rs2_in[7:0] ,8'b0 , 8'b0 };
2'b11:
ms_riscv32_mp_dmdata_out = {rs2_in[7:0],8'b0 , 8'b0 , 8'b0};
endcase
end
2'b01:
begin
case(iadder_in[1])
1'b0 :
ms_riscv32_mp_dmdata_out = {16'b0 ,rs2_in [15:0]};
1'b1:
ms_riscv32_mp_dmdata_out = {rs2_in [15:0], 16'b0};
endcase
end
2'b10:
ms_riscv32_mp_dmdata_out = {rs2_in};
default:
ms_riscv32_mp_dmdata_out = 32'b0;
endcase
end

always @(*)
begin
case (funct3_in)
2'b00 : 
begin
case(iadder_in)
2'b00:
ms_riscv32_mp_dmwr_mask_out = {3'b0 , mem_wr_req_in};
2'b01:
ms_riscv32_mp_dmwr_mask_out = {2'b0 , mem_wr_req_in ,1'b0};
2'b10:
ms_riscv32_mp_dmwr_mask_out ={1'b0 , mem_wr_req_in,2'b0};
2'b11:
ms_riscv32_mp_dmwr_mask_out = {mem_wr_req_in , 3'b0};
endcase
end
2'b01:
begin
case(iadder_in[1])
1'b0:
ms_riscv32_mp_dmwr_mask_out = {2'b0 ,{2{mem_wr_req_in}}};
1'b1:
ms_riscv32_mp_dmwr_mask_out = {{2{mem_wr_req_in} }, 2'b0};
endcase
end
2'b10:
ms_riscv32_mp_dmwr_mask_out = {4{mem_wr_req_in}};
default:
ms_riscv32_mp_dmwr_mask_out = {4'b0};
endcase
end
endmodule
