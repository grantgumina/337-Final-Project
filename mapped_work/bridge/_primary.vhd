library verilog;
use verilog.vl_types.all;
entity bridge is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_en        : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(511 downto 0)
    );
end bridge;
