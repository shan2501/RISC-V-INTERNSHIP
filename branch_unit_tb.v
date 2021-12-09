module branch_unit_tb (rs1_in , rs2_in , opcode_6_to_2_in , funct3_in , branch_taken_out);
reg [31:0] rs1_in , rs2_in ;
reg [6:2] opcode_6_to_2_in;
reg [2:0] funct3_in;
wire branch_taken_out;
integer a , b, c;

branch_unit b( rs1_in , rs2_in , opcode_6_to_2_in , funct3_in , branch_taken_out);

task initialize;
begin
rs1_in = 0;
rs2_in = 0;
opcode_6_to_2_in = 0 ; funct3_in = 0 ; branch_taken_out = 0;
end
endtask

task op (input [4:0] j)
begin
opcode_6_to_2_in = j;
end
endtask

task funct(input [2:0] k)
begin
funct3_in =k;
end
endtask

task read(input [31:0] m,n)
begin
rs1_in = m;
rs2_in = n;
end
endtask

intial
begin
initialize;
op(24);
for(a=0 ; a<32;a=a+1)
begin
b = 31-a;
read(a,b);
for(c=0;c<8;c++)
funct(c);
end


