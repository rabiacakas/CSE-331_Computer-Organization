library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        read_data_1     : in     vl_logic_vector(31 downto 0);
        read_data_2     : in     vl_logic_vector(31 downto 0);
        functionField   : in     vl_logic_vector(5 downto 0);
        aluResult       : out    vl_logic_vector(31 downto 0)
    );
end ALU;
