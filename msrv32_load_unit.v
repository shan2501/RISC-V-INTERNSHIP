module msrv32_load_unit (ms_riscv32_mp_dmdata_in , iadder_out_1_to_0_in , load_unsigned_in , load_size_in , lu_output_out);
input [1:0] iadder_out_1_to_0_in , load_size_in ;
input load_unsigned_in;
input [31:0] ms_riscv32_mp_dmdata_in;
output reg [31:0] lu_output_out;

always @ (*)
begin
case(load_size_in)
2'b00:
begin
case(iadder_out_1_to_0_in)
2'b00:
begin
lu_output_out[7:0] = ms_riscv32_mp_dmdata_in[7:0];
if(load_unsigned_in == 1'b1)
lu_output_out[31:8] = 24'b0;
else
lu_output_out[31:8] = {{24{ms_riscv32_mp_dmdata_in[7]}}};
end
2'b01:
begin
lu_output_out[7:0] = ms_riscv32_mp_dmdata_in[15:8];
if(load_unsigned_in == 1'b1)
lu_output_out[31:8] = 24'b0;
else
lu_output_out[31:8] = {{24{ms_riscv32_mp_dmdata_in[15]}}};
end
2'b10:
begin
lu_output_out[7:0] = ms_riscv32_mp_dmdata_in[23:16];
if(load_unsigned_in == 1'b1)
lu_output_out[31:8] = 24'b0;
else
lu_output_out[31:8] = {{24{ms_riscv32_mp_dmdata_in[23]}}};
end
2'b11:
begin
lu_output_out[7:0] = ms_riscv32_mp_dmdata_in[31:24];
if(load_unsigned_in == 1'b1)
lu_output_out[31:8] = 24'b0;
else
lu_output_out[31:8] = {{24{ms_riscv32_mp_dmdata_in[31]}}};
end
endcase
end
2'b01:
begin
case(iadder_out_1_to_0_in[1])
1'b0:
begin
lu_output_out[15:0] = ms_riscv32_mp_dmdata_in[15:0];
if(load_unsigned_in == 1'b1)
lu_output_out[31:16] = 16'b0;
else
lu_output_out[31:16] = {{24{ms_riscv32_mp_dmdata_in[15]}}};
end
1'b1:
begin
lu_output_out[15:0] = ms_riscv32_mp_dmdata_in[31:16];
if(load_unsigned_in == 1'b1)
lu_output_out[31:16] = 16'b0;
else
lu_output_out[31:16] = {{24{ms_riscv32_mp_dmdata_in[31]}}};
end
endcase
end
2'b10:
lu_output_out = ms_riscv32_mp_dmdata_in;
2'b11:
lu_output_out = ms_riscv32_mp_dmdata_in;
endcase
end

endmodule




