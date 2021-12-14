----------------------------------------------------------------------------------
-- Namn:        registerblock
-- Filnamn:     registerblock.vhd
-- Testbench:   registerblock_tb.vhd
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv l�g
--      F       - resultatet fr�n ALU
--      DEST    - best�mmer vilket av registerna R0 och R1 som ska vara aktivt
--      RegEna  - laddsignal till det aktiva registret
--
-- Utsignaler:
--      RegOut  - det aktiva registrets inneh�ll
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity registerblock is
    port(
        clk : in std_logic;
        n_rst : in std_logic;
        F : in std_logic_vector(7 downto 0);
        DEST : in std_logic;
        RegEna : in std_logic;
        RegOut : out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of registerblock is
    signal R0_OUT : std_logic_vector(7 downto 0);
    signal R1_OUT : std_logic_vector(7 downto 0);
    signal ENA0, ENA1 : std_logic;
begin
ENA0 <= (not DEST) and RegEna;
ENA1 <= DEST and RegEna;

REG0: entity REG8 port map(
        CLK => clk,
        CLR => n_rst,
        ENA => ENA0,
        D => F,
        Q => R0_OUT
);  

Reg1: entity REG8 port map(
        CLK => clk,
        CLR => n_rst,
        ENA => ENA1,
        D => F,
        Q => R1_OUT
);  

REGSEL: entity MUX2x8 port map(
    IN0 => R0_OUT,
    IN1 => R1_OUT,
    SEL => DEST,
    O => RegOut
);  

end architecture;