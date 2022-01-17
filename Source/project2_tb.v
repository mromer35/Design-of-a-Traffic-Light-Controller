module project2_tb();

reg c_sig;
reg clk_sig;
reg rst_n_sig;
wire HWR_sig;
wire HWG_sig;
wire HWY_sig;
wire FRR_sig;
wire FRG_sig;
wire FRY_sig;

initial
begin
	c_sig = 1'b1;
	clk_sig = 1'b0;
	rst_n_sig = 1'b1;

@(posedge clk_sig);
	c_sig = 1'b0;
	rst_n_sig = 1'b1;

end

always
begin
	#10 clk_sig = ~clk_sig;
end

project2 project2_inst
(
	.c(c_sig) ,	// input  c_sig
	.clk(clk_sig) ,	// input  clk_sig
	.rst_n(rst_n_sig) ,	// input  rst_n_sig
	.HWR(HWR_sig) ,	// output  HWR_sig
	.HWG(HWG_sig) ,	// output  HWG_sig
	.HWY(HWY_sig) ,	// output  HWY_sig
	.FRR(FRR_sig) ,	// output  FRR_sig
	.FRG(FRG_sig) ,	// output  FRG_sig
	.FRY(FRY_sig) 	// output  FRY_sig
);

defparam project2_inst.A = 'b000;
defparam project2_inst.B = 'b001;
defparam project2_inst.C = 'b010;
defparam project2_inst.D = 'b011;



endmodule