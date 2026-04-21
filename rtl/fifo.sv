
module fifo #(
    parameter WIDTH = 32,
    parameter DEPTH = 10
) (
    input logic clk,
    input logic rst,
    input logic wr_en,
    input logic rd_en,
    input logic [WIDTH-1:0] wr_data,
    
    output logic [WIDTH-1:0] rd_data,
    output logic full,
    output logic empty
);
localparam ADDR_W = $clog2(DEPTH);
localparam [ADDR_W-1:0] LAST_ADDR = ADDR_W'(DEPTH-1);
logic [WIDTH-1:0] mem [DEPTH-1:0];
logic [ADDR_W-1:0] wr_ptr, rd_ptr;
logic [ADDR_W:0] size;

always_ff @(posedge clk) begin
    if(rst) begin
        for (int i = 0; i < DEPTH; i = i+1 ) begin
            mem[i] <= '0;
        end
        wr_ptr <= '0;
        rd_ptr <= '0;
        size <= 0;
        rd_data <= '0;
    end else begin
        if(wr_en && !full) begin
            mem[wr_ptr] <= wr_data;
            wr_ptr <= (wr_ptr == LAST_ADDR) ? '0 : wr_ptr+1;  
        end
        if(rd_en && !empty) begin
            rd_data <= mem[rd_ptr];
            rd_ptr <= (rd_ptr == LAST_ADDR) ? '0 : rd_ptr+1;  
        end
        case({wr_en && !full, rd_en && !empty})
            2'b01: size <= size - 1;
            2'b10: size <= size + 1;
            default: size <= size;
        endcase
    end

end

assign empty = (size == 0);
assign full = (size == DEPTH);
    
endmodule