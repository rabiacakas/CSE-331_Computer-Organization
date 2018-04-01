library verilog;
use verilog.vl_types.all;
entity mips_core is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end mips_core;
