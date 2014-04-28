library verilog;
use verilog.vl_types.all;
entity tb_usb_crc16 is
    generic(
        CLK_PERIOD      : real    := 10.000000
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end tb_usb_crc16;
