library verilog;
use verilog.vl_types.all;
entity sync is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        USBdata         : in     vl_logic_vector(1 downto 0);
        USBdata_sync    : out    vl_logic
    );
end sync;
