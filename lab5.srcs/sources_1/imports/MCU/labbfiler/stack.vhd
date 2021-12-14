----------------------------------------------------------------------------------
-- Namn:        stack
-- Filnamn:     stack.vhd
-- Testbench:   stack_tb.vhd
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv låg
--      D       - data in till stacken
--      StackOp - styr stackens beteende
--
-- Utsignaler:
--      ToS     - värdet av stackens översta element
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity stack is
    port(
        D : in std_logic_vector(5 downto 0);
        ToS : out std_logic_vector(5 downto 0);
        clk, n_rst : in std_logic;
        StackOp : in std_logic_vector(1 downto 0)
    );
end entity;

architecture structural of stack is
    
    
begin
    SR4_0: entity SR4 port map(
         CLR => n_rst,
         CLK => clk,
         SR_SER => D(0),
         SL_SER => '0',
         S0 => StackOp(0),
         S1 => StackOp(1),
         QA => ToS(0),
         QB => open,     
         QC => open,
         QD => open
    );
    SR4_1: entity SR4 port map(
         CLR => n_rst,
         CLK => clk,
         SR_SER => D(1),
         SL_SER => '0',
         S0 => StackOp(0),
         S1 => StackOp(1),
         QA => ToS(1),
         QB => open,
         QC => open,
         QD => open
    );
    SR4_2: entity SR4 port map(
         CLR => n_rst,
         CLK => clk,
         SR_SER => D(2),
         SL_SER => '0',
         S0 => StackOp(0),
         S1 => StackOp(1),
         QA => ToS(2),
         QB => open,
         QC => open,
         QD => open
    );
    SR4_3: entity SR4 port map(
          CLR => n_rst,
          CLK => clk,
          SR_SER => D(3),
          SL_SER => '0',
          S0 => StackOp(0),
          S1 => StackOp(1),
          QA => ToS(3),
          QB => open,
          QC => open,
          QD => open
    );
    SR4_4: entity SR4 port map(
         CLR => n_rst,
         CLK => clk,
         SR_SER => D(4),
         SL_SER => '0',
         S0 => StackOp(0),
         S1 => StackOp(1),
         QA => ToS(4),
         QB => open,
         QC => open,
         QD => open
    );
    SR4_5: entity SR4 port map(
         CLR => n_rst,
         CLK => clk,
         SR_SER => D(5),
         SL_SER => '0',
         S0 => StackOp(0),
         S1 => StackOp(1),
         QA => ToS(5),
         QB => open,
         QC => open,
         QD => open
    );
end architecture;