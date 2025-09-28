-- DE10 Lite
-- 64MB of SDRAM with a single 64MB (32Mx16) SDRAM chip. The chip
-- consists of 16-bit data line, control line, and address line connected to the FPGA

-- for now just use on chip capabilities

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ieee.fixed_pkg.all; --fixed point numbers

entity weights is
    generic(
        DATA_WIDTH : integer := 16; --total bits
        ADDR_WIDTH : integer :=10; -- number of weights
        INT_BITS : integer := 4; -- number of int bits
    );
    port(
        clk : in std_logic;
        addr: in unsigned(ADR_WIDTH-1 downto 0);
        data: out sfixed(INT_BITS-1 downto -(DATA_WIDTH-INT_BITS))
    );
    end entity;

    architecture rtl of weight_memory is

        --understand this better 
        -- defines a new type called ram_type, which is an array
        -- from 0 to 1023
        -- each element is a signed vector of width DATA_WIDTH
        type ram_type is array (0 to 2**ADDR_WIDTH-1) of sfixed(INT_BITS-1 downto -(DATA_WIDTH-INT_BITS));

        --hardcoded weights for now
        signal ram :ram_type := (

        -- eventually use a .mif file?
        0 => to_signed(0.12, INT_BITS-1, -(DATA_WIDTH - INT_BITS)),
        0 => to_signed(-0.18, INT_BITS-1, -(DATA_WIDTH - INT_BITS)),
        0 => to_signed(0.27, INT_BITS-1, -(DATA_WIDTH - INT_BITS))
        );

    begin

        -- read synch

        process(clk)
        begin
            if(clk'event and clk = '1') then
                data <= ram(to_integer(addr))
            end if;
        end process;

    end architecture;