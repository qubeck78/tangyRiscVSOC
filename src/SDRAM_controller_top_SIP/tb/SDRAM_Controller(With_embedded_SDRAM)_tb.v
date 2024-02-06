
`timescale 1ns/1ps
module tb ;
    reg I_clk ; 
    reg I_rst_n ; 
    reg I_selfrefresh ; 
    reg I_power_down ; 
    reg I_wrd ; 
    wire O_wrd_error_flag ; 
    wire [(32 - 1):0] O_cnt_error ; 
    wire [(32 - 1):0] O_sdrc_data_i ; 
    wire O_sdram_clk ; 
    wire O_sdram_cke ; 
    wire O_sdram_cs_n ; 
    wire O_sdram_cas_n ; 
    wire O_sdram_ras_n ; 
    wire O_sdram_wen_n ; 
    wire O_sdrc_busy_n ; 
    wire [(11 - 1):0] O_sdram_addr ; 
    wire [(2 - 1):0] O_sdram_ba ; 
    wire [((32 / 8) - 1):0] O_sdram_dqm ; 
    wire [32:0] out ; 
    wire [(32 - 1):0] IO_sdram_dq ; 
    sdrc_interface_test_top uut (.I_clk(I_clk), .I_rst_n(I_rst_n), .I_selfrefresh(I_selfrefresh), .I_power_down(I_power_down), .I_wrd(I_wrd), .O_wrd_error_flag(O_wrd_error_flag), .O_cnt_error(O_cnt_error), .O_sdrc_data_i(O_sdrc_data_i), .O_sdram_clk(O_sdram_clk), .O_sdram_cke(O_sdram_cke), .O_sdram_cs_n(O_sdram_cs_n), .O_sdram_cas_n(O_sdram_cas_n), .O_sdram_ras_n(O_sdram_ras_n), .O_sdram_wen_n(O_sdram_wen_n), .O_sdrc_busy_n(O_sdrc_busy_n), 
                .IO_sdram_dq(IO_sdram_dq), .O_sdram_addr(O_sdram_addr), .O_sdram_ba(O_sdram_ba), .O_sdram_dqm(O_sdram_dqm), .out(out)) ; 
    GSR GSR (.GSRI(1'b1)) ; 
    localparam DQ_BITS = 16 ; 
    localparam DQS_BITS = 2 ; 
    localparam nDRAM = (32 / DQ_BITS) ; 
    generate
        genvar o ; 
        for (o = 0;(o < nDRAM);o = (o + 1'b1))
        begin : sdram_sim_model
            sdram_sim_model sdram_model (.Dq(IO_sdram_dq[(((o + 1) * DQ_BITS) - 1) -: DQ_BITS]), .Addr(O_sdram_addr), .Ba(O_sdram_ba), .Clk(O_sdram_clk), .Cke(O_sdram_cke), .Cs_n(O_sdram_cs_n), .Ras_n(O_sdram_ras_n), .Cas_n(O_sdram_cas_n), .We_n(O_sdram_wen_n), .Dqm(O_sdram_dqm[(((o + 1) * DQS_BITS) - 1) -: DQS_BITS])) ; 
        end
    endgenerate
    initial
        begin
            $fsdbDumpfile ("sdram.fsdb") ;
            $fsdbDumpvars  ;
        end
    parameter Period = 20 ; 
    initial
        begin
            I_clk = 1'b0 ;
            forever
                #((Period / 2)) I_clk = (~I_clk) ;
        end
    parameter Period_sdrc = 20 ; 
    integer file_out ; 
    initial
        begin
            file_out = $fopen("Result.dat","w") ;
            #(3) ;
            $fdisplay (file_out,"Golden_data   Test_result") ;
            forever
                #(5) if ((out[0] == 1)) 
    begin
        $fdisplay (file_out,"   %d       %d",O_sdrc_data_i,out[32:1]) ;
    end
        end
    initial
        begin
            I_rst_n = 1 ;
            I_selfrefresh = 0 ;
            I_power_down = 0 ;
            I_wrd = 0 ;
            #((2500 * Period)) ;
            I_rst_n = 0 ;
            #((5 * Period)) ;
            I_rst_n = 1 ;
            #((16200 * Period_sdrc)) ;
            #((20 * Period_sdrc)) ;
            #((50 * Period_sdrc)) ;
            I_wrd = 1 ;
            #((10000 * Period_sdrc)) ;
            $display ("******************finish******************") ;
            if (O_cnt_error) 
                $fdisplay (file_out,"Test finish\n Error number=%d",O_cnt_error) ;
            else
                $fdisplay (file_out,"Test finish\n No error") ;
            $fclose (file_out) ;
            $finish  ;
        end
endmodule



`timescale 1ns/1ps
module sdrc_interface_test_top (I_clk, I_rst_n, I_selfrefresh, I_power_down, I_wrd, O_wrd_error_flag, O_cnt_error, O_sdrc_data_i, O_sdram_clk, O_sdram_cke, O_sdram_cs_n, O_sdram_cas_n, O_sdram_ras_n, O_sdram_wen_n, O_sdrc_busy_n, 
        IO_sdram_dq, O_sdram_addr, O_sdram_ba, O_sdram_dqm, out) ;
    input I_clk ; 
    input I_rst_n ; 
    input I_selfrefresh ; 
    input I_power_down ; 
    input I_wrd ; 
    output O_wrd_error_flag ; 
    output [(32 - 1):0] O_cnt_error ; 
    output [(32 - 1):0] O_sdrc_data_i ; 
    output O_sdram_clk ; 
    output O_sdram_cke ; 
    output O_sdram_cs_n ; 
    output O_sdram_cas_n ; 
    output O_sdram_ras_n ; 
    output O_sdram_wen_n ; 
    output O_sdrc_busy_n ; 
    inout [(32 - 1):0] IO_sdram_dq ; 
    output [(11 - 1):0] O_sdram_addr ; 
    output [(2 - 1):0] O_sdram_ba ; 
    output [((32 / 8) - 1):0] O_sdram_dqm ; 
    output [32:0] out ; 
    wire [(32 - 1):0] sdrc_data_out ; 
    wire [(21 - 1):0] sdrc_addr ; 
    wire [(32 - 1):0] sdrc_data ; 
    wire [(8 - 1):0] sdrc_data_len ; 
    wire [((32 / 8) - 1):0] sdrc_dqm ; 
    reg sdram_clk ; 
    reg sdrc_clk ; 
    initial
        begin
            sdram_clk = 0 ;
            forever
                #(3.019) sdram_clk = (~sdram_clk) ;
        end
    initial
        begin
            sdrc_clk = 0 ;
            forever
                #(3.019) sdrc_clk = (~sdrc_clk) ;
        end
    sdrc_interface_used b2v_inst0 (.sdrc_selfrefresh(sdrc_selfrefresh), .sdrc_power_down(sdrc_power_down), .sdrc_wr_n(sdrc_wr_n), .sdrc_rd_n(sdrc_rd_n), .sdrc_addr(sdrc_addr), .sdrc_data(sdrc_data), .sdrc_dqm(sdrc_dqm), .sdrc_data_len(sdrc_data_len), .o_wrd_error_flag(O_wrd_error_flag), .o_cnt_error(O_cnt_error), .sdrc_data_i(O_sdrc_data_i), .clk(sdrc_clk), .rst_n(I_rst_n), .i_selfrefresh(I_selfrefresh), .i_power_down(I_power_down), 
                .i_wrd(I_wrd), .sdrc_init_done(sdrc_init_done), .sdrc_busy_n(sdrc_busy_n), .sdrc_rd_valid(sdrc_rd_valid), .sdrc_wrd_ack(sdrc_wrd_ack), .sdrc_data_out(sdrc_data_out)) ; 
    SDRAM_controller_top_SIP b2v_inst1 (.I_sdrc_rst_n(I_rst_n), .I_sdrc_clk(sdrc_clk), .I_sdram_clk(sdram_clk), .I_sdrc_selfrefresh(sdrc_selfrefresh), .I_sdrc_power_down(sdrc_power_down), .I_sdrc_wr_n(sdrc_wr_n), .I_sdrc_rd_n(sdrc_rd_n), .I_sdrc_addr(sdrc_addr), .I_sdrc_data(sdrc_data), .I_sdrc_data_len(sdrc_data_len), .I_sdrc_dqm(sdrc_dqm), .IO_sdram_dq(IO_sdram_dq), .O_sdram_clk(O_sdram_clk), .O_sdram_cke(O_sdram_cke), .O_sdram_cs_n(O_sdram_cs_n), 
                .O_sdram_cas_n(O_sdram_cas_n), .O_sdram_ras_n(O_sdram_ras_n), .O_sdram_wen_n(O_sdram_wen_n), .O_sdrc_init_done(sdrc_init_done), .O_sdrc_busy_n(sdrc_busy_n), .O_sdrc_rd_valid(sdrc_rd_valid), .O_sdrc_wrd_ack(sdrc_wrd_ack), .O_sdram_addr(O_sdram_addr), .O_sdram_ba(O_sdram_ba), .O_sdram_dqm(O_sdram_dqm), .O_sdrc_data(sdrc_data_out)) ; 
    assign out[0] = sdrc_rd_valid ; 
    assign out[32:1] = sdrc_data_out[(32 - 1):0] ; 
    assign O_sdrc_busy_n = sdrc_busy_n ; 
endmodule



`timescale 1ns/1ps
module sdrc_interface_used (
    output sdrc_selfrefresh, 
    output sdrc_power_down, 
    output reg sdrc_wr_n, 
    output reg sdrc_rd_n, 
    output reg [(21 - 1):0] sdrc_addr = 0, 
    output reg [(32 - 1):0] sdrc_data = 0, 
    output [((32 / 8) - 1):0] sdrc_dqm, 
    output [(8 - 1):0] sdrc_data_len, 
    output reg o_wrd_error_flag, 
    output reg [(32 - 1):0] o_cnt_error, 
    output reg [(32 - 1):0] sdrc_data_i, 
    input clk, 
    input rst_n, 
    input i_selfrefresh, 
    input i_power_down, 
    input i_wrd, 
    input sdrc_init_done, 
    input sdrc_busy_n, 
    input sdrc_rd_valid, 
    input sdrc_wrd_ack, 
    input [(32 - 1):0] sdrc_data_out) ;
    parameter STATE_IDLE = 3'b000 ; 
    parameter STATE_READ = 3'b001 ; 
    parameter STATE_READ_WAIT = 3'b010 ; 
    parameter STATE_WRITE = 3'b011 ; 
    parameter STATE_WRITE_WAIT = 3'b100 ; 
    parameter start_data = 0 ; 
    parameter start_addr = 5 ; 
    reg [2:0] wrd_mode_state ; 
    reg [(32 - 1):0] start_wr_data ; 
    reg [(32 - 1):0] start_rd_data ; 
    reg [(8 - 1):0] start_wr_addr ; 
    reg [(8 - 1):0] start_rd_addr ; 
    wire [(2 - 1):0] bank_addr ; 
    wire [(11 - 1):0] row_addr ; 
    reg [(32 - 1):0] sdrc_data_o ; 
    reg [(8 - 1):0] cnt ; 
    assign sdrc_selfrefresh = 0 ; 
    assign sdrc_power_down = 0 ; 
    assign sdrc_data_len = 25 ; 
    assign sdrc_dqm = 0 ; 
    assign bank_addr = 2 ; 
    assign row_addr = 2 ; 
    always
        @(posedge clk or negedge rst_n)
        begin
            if ((~rst_n)) 
                begin
                    o_wrd_error_flag <=  0 ;
                    sdrc_data_i <=  start_data ;
                    o_cnt_error <=  0 ;
                end
            else
                begin
                    if (sdrc_rd_valid) 
                        begin
                            sdrc_data_i <=  (sdrc_data_i + 1) ;
                            if ((sdrc_data_out !== sdrc_data_i)) 
                                begin
                                    o_wrd_error_flag <=  (~o_wrd_error_flag) ;
                                    o_cnt_error <=  (o_cnt_error + 1) ;
                                end
                        end
                    else
                        begin
                            if ((wrd_mode_state == STATE_READ_WAIT)) 
                                begin
                                    sdrc_data_i <=  start_rd_data ;
                                end
                        end
                end
        end
    always
        @(posedge clk or negedge rst_n)
        begin
            if ((~rst_n)) 
                begin
                    wrd_mode_state <=  STATE_IDLE ;
                    start_wr_addr <=  start_addr ;
                    start_rd_addr <=  start_addr ;
                    start_wr_data <=  start_data ;
                    start_rd_data <=  start_data ;
                    sdrc_data <=  start_data ;
                    cnt <=  0 ;
                    sdrc_wr_n <=  1 ;
                    sdrc_rd_n <=  1 ;
                end
            else
                begin
                    case (wrd_mode_state)
                    STATE_IDLE : 
                        begin
                            if ((sdrc_init_done && sdrc_busy_n)) 
                                begin
                                    if (i_wrd) 
                                        begin
                                            wrd_mode_state <=  STATE_WRITE_WAIT ;
                                            start_wr_addr <=  start_addr ;
                                        end
                                end
                        end
                    STATE_WRITE_WAIT : 
                        begin
                            if ((i_wrd && sdrc_busy_n)) 
                                begin
                                    sdrc_wr_n <=  1'b0 ;
                                    wrd_mode_state <=  STATE_WRITE ;
                                    start_rd_addr <=  start_wr_addr ;
                                    start_wr_addr <=  ((start_wr_addr + sdrc_data_len) + 1) ;
                                    sdrc_addr <=  {bank_addr,row_addr,start_wr_addr} ;
                                end
                        end
                    STATE_WRITE : 
                        begin
                            sdrc_wr_n <=  1'b1 ;
                            start_rd_data <=  start_wr_data ;
                            sdrc_data <=  (sdrc_data + 1) ;
                            if ((cnt <= (sdrc_data_len + 2))) 
                                begin
                                    cnt <=  (cnt + 1) ;
                                end
                            else
                                begin
                                    cnt <=  0 ;
                                    start_wr_data <=  (sdrc_data + 1) ;
                                    wrd_mode_state <=  STATE_READ_WAIT ;
                                end
                        end
                    STATE_READ_WAIT : 
                        begin
                            if (sdrc_busy_n) 
                                begin
                                    sdrc_rd_n <=  1'b0 ;
                                    sdrc_addr <=  {bank_addr,row_addr,start_rd_addr} ;
                                    wrd_mode_state <=  STATE_READ ;
                                end
                        end
                    STATE_READ : 
                        begin
                            sdrc_rd_n <=  1'b1 ;
                            if ((cnt <= (sdrc_data_len + 2))) 
                                begin
                                    cnt <=  (cnt + 1) ;
                                end
                            else
                                begin
                                    cnt <=  0 ;
                                    wrd_mode_state <=  STATE_WRITE_WAIT ;
                                end
                        end
                    default : 
                        begin
                            wrd_mode_state <=  STATE_IDLE ;
                        end
                    endcase 
                end
        end
endmodule


