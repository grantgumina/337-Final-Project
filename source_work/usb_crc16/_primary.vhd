library verilog;
use verilog.vl_types.all;
entity usb_crc16 is
    port(
        n_rst           : in     vl_logic;
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        crc_en          : in     vl_logic;
        crc_out         : out    vl_logic_vector(15 downto 0);
        crc_ready       : out    vl_logic;
        crc_valid       : out    vl_logic
    );
end usb_crc16;
