library verilog;
use verilog.vl_types.all;
entity usb_crc5 is
    port(
        n_rst           : in     vl_logic;
        clk             : in     vl_logic;
        clk_trans       : in     vl_logic;
        d               : in     vl_logic_vector(15 downto 0);
        valid           : out    vl_logic;
        crc5_result     : out    vl_logic_vector(4 downto 0)
    );
end usb_crc5;
