library verilog;
use verilog.vl_types.all;
entity glue is
    port(
        n_rst           : in     vl_logic;
        clk             : in     vl_logic;
        usb_data_in     : in     vl_logic_vector(7 downto 0);
        new_byte        : in     vl_logic;
        usb_data_out    : out    vl_logic_vector(527 downto 0);
        usb_shift_out   : out    vl_logic
    );
end glue;
