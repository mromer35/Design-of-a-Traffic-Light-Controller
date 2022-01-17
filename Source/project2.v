module project2(
	input c,
	input clk,
	input rst_n,
	output reg HWR,
	output reg HWG,
	output reg HWY,
	output reg FRR,
	output reg FRG,
	output reg FRY

);

reg [2:0] state;
reg [2:0] count;
reg enableCount = 1'd0;
reg endCount = 1'd0;
parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3;

//Senses if a vehicle is on the farm road
always @ (posedge clk) 
begin
	if(c) //vehicle detected! Begin traffic light interval
		enableCount <= 1'b1;
		
	else if(endCount) //ends traffic light interval, default settings are restored
		enableCount <= 1'b0;
		
end



always @ (posedge clk or negedge rst_n)
begin
	//negative triggered reset signal, all setting restored to default
	if(!rst_n)
		begin
			state <= A;
			count <= 3'd0;
			endCount <= 1'b0;
		end
		
	else
	begin
		//When enableCount = 1, then a vehicle is detected on the farm road,
		//begins light intervals
		if(enableCount)
		begin
		case(state)
			A:
				if(count == 3'd1) //transition A->B
					begin
						state <= B;
						count <= count + 3'd1;
					end
				else//# of cycles, 2, have not yet been reached. Increment count
				begin
					endCount <= 1'b0;//resets the endCount to 0. Used for end of intervals
					count <= count + 3'd1;
				end
				
			B:	
				if(count == 3'd2) //transition B->C
				begin
					state <= C;
					count <= count + 3'd1;
				end
				else//# of cycles have not yet been reached. Increment count
				begin
					count <= count + 3'd1;
				end
				
			C: 
					if(count == 3'd4) //transition C->D
					begin
						state <= D; 
						count <= count + 3'd1;
					end
					else//# of cycles have not yet been reached. Increment count
					begin
						count <= count + 3'd1;
					end

						
			D: 
					if(count == 3'd5) //transition D->A, end of interval
					begin
						state <= A; 
						count <= 3'd0; //reset timer
						endCount <= 1'd1;//endCount=1 which resets enableCount = 0
					end
					else//# of cycles have not yet been reached. Increment count
					begin
						count <= count + 3'd1;
					end
				
			default:
				state <= A;
			

	endcase
	end
	
	else//when no car is sensed, enableCount=0, then deafult state is assigned.
	begin
		state <=A;
	end
end
	
end


//Outputs, depended on the present state.
always @ (state)
begin
case(state)
		A:
		begin
			HWG = 1;
			HWY = 0;
			HWR = 0;
			FRG = 0;
			FRY = 0;
			FRR = 1;
		end
		B:
		begin
			HWG = 0;
			HWY = 1;
			HWR = 0;
			FRG = 0;
			FRY = 0;
			FRR = 1;
		end
		C:
		begin
			HWG = 0;
			HWY = 0;
			HWR = 1;
			FRG = 1;
			FRY = 0;
			FRR = 0;
		end
		D:
		begin
			HWG = 0;
			HWY = 0;
			HWR = 1;
			FRG = 0;
			FRY = 1;
			FRR = 0;
		end

	endcase
end
endmodule

