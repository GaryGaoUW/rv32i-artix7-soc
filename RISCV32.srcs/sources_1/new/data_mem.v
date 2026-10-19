`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/22 19:34:49
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem (
    input clk,
    input [3:0] we,
    input [31:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
);

    reg [31:0] ram[0:1023];
    
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            ram[i] = 32'h00000000; 
        end
    end

    assign rdata = ram[addr[31:2]];
    wire [31:0] shifted_wdata = wdata << {addr[1:0], 3'b000};

    always @(posedge clk) begin
        if (we) begin
            if (we[0]) ram[addr[31:2]][7:0] <= shifted_wdata[7:0];
            if (we[1]) ram[addr[31:2]][15:8] <= shifted_wdata[15:8];
            if (we[2]) ram[addr[31:2]][23:16] <= shifted_wdata[23:16];
            if (we[3]) ram[addr[31:2]][31:24] <= shifted_wdata[31:24];
        end
    end
endmodule
