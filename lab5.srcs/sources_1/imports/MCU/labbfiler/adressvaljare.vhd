----------------------------------------------------------------------------------
-- Namn:        adressvaljare
-- Filnamn:     adressvaljare.vhd
-- Testbench:   adressvaljare_tb.vhd
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv låg
--      DATA    - de 6 minst signifikanta bitarna från instruktionen, används då
--                n�sta adress anges av instruktionen
--      AddrSrc - bestämmer varifrån nästa adress ska hämtas
--      StackOp - styr stacken i adressväljaren
--
-- Utsignaler:
--      A           - n�sta adress
--      pc_debug    - nuvarande adress, används för att visa adressen på
--                    Nexys4 display
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity adressvaljare is
    port(
        clk, n_rst : in std_logic;
        DATA : in std_logic_vector(5 downto 0);
        A : out std_logic_vector(5 downto 0);
        AddrSrc : in std_logic_vector(1 downto 0);
        StackOp : in std_logic_vector(1 downto 0);
        pc_debug : out std_logic_vector(5 downto 0)
    );
end entity;

architecture structural of adressvaljare is

signal MUXOut : std_logic_vector(5 downto 0);
signal PC_PLUS_ONE : std_logic_vector(5 downto 0);
signal ToS : std_logic_vector(5 downto 0);
signal pc : std_logic_vector(5 downto 0);
signal Foo : std_logic_vector(1 downto 0);
signal ANDD : std_logic_vector(7 downto 0);
begin
Stack1: entity stack port map(
n_rst => n_rst,
clk => clk,
StackOp => StackOp,
D(5 downto 0) => PC_PLUS_ONE,
ToS => ToS
);  

mux: entity MUX3x6 port map(
IN0 => PC_PLUS_ONE,
IN1 => ToS,
IN2 => DATA,
SEL => AddrSrc,
O => MUXOut
);
A <= MUXOut;

REG6_1: entity REG6 port map(
CLK => clk,
CLR => n_rst,
ENA => '1',
D => MUXOut,
Q => pc
);
pc_debug <= pc;
ANDD <= "00" & pc;

Plusone: entity ALU8 port map(
A => ANDD,
B => "00000001",
S => "010",
Z => open,
F(5 downto 0) => PC_PLUS_ONE,
F(7 downto 6) => Foo
);
end architecture;