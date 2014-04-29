library verilog;
use verilog.vl_types.all;
entity tb_glue is
    generic(
        CLK_PERIOD      : real    := 5.555556;
        ULPI_CLK_PERIOD : real    := 16.666667
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of ULPI_CLK_PERIOD : constant is 1;
end tb_glue;
