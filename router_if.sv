interface router_if(input bit clock);

    logic [7:0] data_in;
    logic [7:0] data_out;
    logic rst;
    logic error;
    logic busy;
    logic read_enable;
    logic valid_out;
    logic pkt_valid;

    //write driver clocking block
    clocking wdr_cb @ (posedge clock);
        default input #1 output #1; //??
        input error; //here input means input to the TB(means in reference to TB)
        input busy;
        output data_in; //here output means output from the TB(means in reference to TB)
        output rst; 
        output packet_valid;
    endclocking
    //Write driver modport
    modport WDR_MP(clocking wdr_cb); 
    
    //read driver clocking block
    clocking rdr_cb @(posedge clock); 
        default input #1 output #1;
        input valid_out; //did not understand how these signals are relevant for read driver
        input read_enable;
    endclocking
    //Read driver modport
    modport RDR_MP(clocking rdr_cb);

    //write monitor clocking block
    clocking wmon_cb (posedge clock);
        default input #1 output #1; //??
        input data_in;  //all signals related to write driver(BOTH INPUT AND OUTPUT) are considered here as input
        input rst;
        input packet_valid;
        input busy;
        input error;
    endclocking
    //Write monitor modport
    modport WRMON_MP (clocking wmon_cb);

    //read monitor clocking block
    clocking rmon_cb(posedge clock);
        default input #1 output #1;
        input data_out; //did not understand this list of signals??
        input read_enable;
    endclocking

    //Read monitor modport
    modport RDMON_MP(clocking rmon_cb);

endinterface : router_if
