module msrv32_wr_en_generator(flush_in , rf_wr_en_reg_in , csr_wr_en_reg_in , wr_en_integer_file_out , wr_en_csr_file_out);
input flush_in , rf_wr_en_reg_in , csr_wr_en_reg_in;
output reg wr_en_integer_file_out , wr_en_csr_file_out;

always @ (*)
begin
if(flush_in)
wr_en_csr_file_out = 0;
else
wr_en_csr_file_out = csr_wr_en_reg_in;
end

always @ (*)
begin
if(flush_in)
wr_en_integer_file_out = 0;
else
wr_en_integer_file_out = rf_wr_en_reg_in;
end
endmodule