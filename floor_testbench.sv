`timescale 1ns / 100ps
`default_nettype none

module floor_testbench();
   wire [31:0] x1,x2;
   wire signed [31:0] x, y;
   wire        ovf;
   logic [31:0] x1i,x2i;
   logic signed [31:0] xi;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic signed [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;
   bit 	      fovf;
   bit 	      checkovf;

   logic sign_xi;
   logic [7:0] exponent_xi;
   logic [22:0] mantissa_xi;

   assign x1 = x1i;
   assign x2 = x2i;
   assign x = xi;

   wire [4:0] ps;
   wire sr;
   wire [4:0] sl;
   wire cr;
   wire [55:0] man1,man2,man3;
   
   // DEBUG:
   wire inf, zero;
   wire ulp,guard,round,sticky,flag;
   floor u1(x,y);

   initial begin
      // $dumpfile("test_fadd.vcd");
      // $dumpvars(0);

      $display("start of checking module fadd");
      $display("difference message format");
      $display("x1 = [input 1(bit)], [exponent 1(decimal)]");
      $display("x2 = [input 2(bit)], [exponent 2(decimal)]");
      $display("ref. : result(float) sign(bit),exponent(decimal),mantissa(bit) overflow(bit)");
      $display("fadd : result(float) sign(bit),exponent(decimal),mantissa(bit) overflow(bit)");

      for (i=0; i<10000000; i++) begin
        sign_xi = $urandom();
        exponent_xi = $urandom() % 8'd10 + 8'd127;
        mantissa_xi = $urandom();
        xi = {sign_xi, exponent_xi, mantissa_xi};
        fy = $floor($bitstoshortreal(xi));
        fybit = $shortrealtobits(fy);

        #1;

        if (fybit != y) begin
          // $display("is_inf(%b) is_zero(%b)", inf, zero);
          // $display("ulp(%b) g(%b) r(%b) s(%b) flag(%b)", ulp,guard,round,sticky,flag);
          $display("carry = %b", carry);
          $display("tmp = %b", tmp);
          $display("x = %b %b %b %e", x[31:31], x[30:23], x[22:0], $bitstoshortreal(x));
          $display("y = %b %e", y, $bitstoshortreal(y));
          $display("y = %b %e\n", fybit, fy);
        end
      end
   end

      // for (i=120; i<160; i++) begin
      //    for (j=120; j<160; j++) begin
      //       for (s1=0; s1<2; s1++) begin
      //          for (s2=0; s2<2; s2++) begin
      //             for (it=0; it<10; it++) begin
      //                for (jt=0; jt<10; jt++) begin
      //                   #1;

      //                   case (it)
      //                     0 : m1 = 23'b0;
      //                     1 : m1 = {22'b0,1'b1};
      //                     2 : m1 = {21'b0,2'b10};
      //                     3 : m1 = {1'b0,3'b111,19'b0};
      //                     4 : m1 = {1'b1,22'b0};
      //                     5 : m1 = {2'b10,{21{1'b1}}};
      //                     6 : m1 = {23{1'b1}};
      //                     default : begin
      //                        if (i==256) begin
      //                           {m1,dum1} = 0;
      //                        end else begin
      //                           {m1,dum1} = $urandom();
      //                        end
      //                     end
      //                   endcase

      //                   case (jt)
      //                     0 : m2 = 23'b0;
      //                     1 : m2 = {22'b0,1'b1};
      //                     2 : m2 = {21'b0,2'b10};
      //                     3 : m2 = {1'b0,3'b111,19'b0};
      //                     4 : m2 = {1'b1,22'b0};
      //                     5 : m2 = {2'b10,{21{1'b1}}};
      //                     6 : m2 = {23{1'b1}};
      //                     default : begin
      //                        if (i==256) begin
      //                           {m2,dum2} = 0;
      //                        end else begin
      //                           {m2,dum2} = $urandom();
      //                        end
      //                     end
      //                   endcase
                        
      //                   x1i = {s1[0],i[7:0],m1};
      //                   // x2i = {s2[0],j[7:0],m2};

      //                   fx1 = $bitstoshortreal(x1i);
      //                   // fx2 = $bitstoshortreal(x2i);
      //                   // fy = fx1 + fx2;
      //                   fy = $itor(fx1);
      //                   fybit = $shortrealtobits(fy);

		// 	checkovf = i < 255 && j < 255;
		// 	if ( checkovf && fybit[30:23] == 255 ) begin
		// 	   fovf = 1;
		// 	end else begin
		// 	   fovf = 0;
		// 	end
                        
      //                   #1;

      //                   // if (y !== fybit || ovf !== fovf) begin
      //                   if (y !== fybit) begin
      //                      $display("x = %b %b %b, %3d",
		// 		    x1[31], x1[30:23], x1[22:0], x1[30:23]);
      //                      // DEBUG:
      //                      $display("%e %b,%3d,%b %b", fy,
		// 		    fybit[31], fybit[30:23], fybit[22:0], fovf);
      //                      $display("%e %b,%3d,%b %b\n", $bitstoshortreal(y),
		// 		    y[31], y[30:23], y[22:0], ovf);

      //                   end
      //                end
      //             end
      //          end
      //       end
      //    end
      //    //$finish;
      // end

   //    for (i=0; i<255; i++) begin
   //       for (s1=0; s1<2; s1++) begin
   //          for (s2=0; s2<2; s2++) begin
   //             for (j=0;j<23;j++) begin
   //                repeat(10) begin
   //                   #1;

   //                   {m1,dum1} = $urandom();
   //                   x1i = {s1[0],i[7:0],m1};
   //                   {m2,dum2} = $urandom();
   //                   for (k=0;k<j;k++) begin
   //                      tm[k] = m2[k];
   //                   end
   //                   for (k=j;k<23;k++) begin
   //                      tm[k] = m1[k];
   //                   end
   //                   x2i = {s2[0],i[7:0],tm};

   //                   fx1 = $bitstoshortreal(x1i);
   //                   fx2 = $bitstoshortreal(x2i);
   //                   fy = fx1 + fx2;
   //                   fybit = $shortrealtobits(fy);
                     
	// 	     checkovf = i < 255;
	// 	     if (checkovf && fybit[30:23] == 255) begin
	// 		fovf = 1;
	// 	     end else begin
	// 		fovf = 0;
	// 	     end

   //                   #1;

   //                   if (y !== fybit || ovf !== fovf) begin
   //                      $display("x1 = %b %b %b, %3d",
	// 			 x1[31], x1[30:23], x1[22:0], x1[30:23]);
   //                      $display("x2 = %b %b %b, %3d",
	// 			 x2[31], x2[30:23], x2[22:0], x2[30:23]);
   //                      $display("%e %b,%3d,%b %b", fy,
	// 			 fybit[31], fybit[30:23], fybit[22:0], fovf);
   //                      $display("%e %b,%3d,%b %b\n", $bitstoshortreal(y),
	// 			 y[31], y[30:23], y[22:0], ovf);
   //                   end
   //                end
   //             end
   //          end
   //       end
   //    end
   //    $display("end of checking module fadd");
   //    //$finish;
   // end
endmodule

`default_nettype wire