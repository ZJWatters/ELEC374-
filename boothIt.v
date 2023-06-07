module boothIt (
    input signed [31:0] a, input signed [31:0] b,
    output signed [63:0] c
);

    wire signed [31:0] negA;					// Negative (2's compilent) of multiplicand a
    reg [2:0] combBits [15:0]; 				//the recoded bits
    reg signed [32:0] partProd [15:0];  		// The partial products which are computed based on combBits
    reg signed [63:0] shiftedpartProd [15:0];	// The partial products shifted to the correct amount, in preparation to add them
    reg signed [63:0] sumpartProd;		
    //loop iterators 
	 integer i, j;
    
    //2's comp of A
    assign negA = -a;
    
    // Compute product when a (or negA) or b changes
    always @ (*)
    begin
        
        // Special case
        combBits[0] = {b[1], b[0], 1'b0};
            
              
        for(i=1;i<16;i=i+1) begin
                combBits[i] = {b[2*i+1],b[2*i],b[2*i-1]};
       
        end
        
        // Compute partial products
        for(i=0;i<16;i=i+1)	begin
            
            case(combBits[i])
                
                //bit =  +1, partial product = a
                3'b001 , 3'b010 : partProd[i] = {a[31],a};
                //bit = +2, partial product = 2*a
                3'b011 : partProd[i] = {a,1'b0};
                //bit = -2, partial product = -2*a
                3'b100 : partProd[i] = {negA[31:0],1'b0};
                //bit = -1, partial product = -a
                3'b101 , 3'b110 : partProd[i] = negA;
                
               
                default : partProd[i] = 0;
                
            endcase
          
                        // Sign extend  partial product
            shiftedpartProd[i] = partProd[i] << (2*i);
            
            
         end
        
        //add pp's together
        sumpartProd = shiftedpartProd[0];
        

        for(i=1;i<16;i=i+1) begin
            sumpartProd = sumpartProd + shiftedpartProd[i];
        end
        
        
    end
    
    // The output is the computed product
    assign c = sumpartProd;

endmodule

