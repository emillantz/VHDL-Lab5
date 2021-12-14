----------------------------------------------------------------------------------
-- Namn:        instruktionsavkodare
-- Filnamn:     instruktionsavkodare.vhd
-- Testbench:   instruktionsavkodare_tb.vhd
--
-- Insignaler:
--      OPCODE - operationskod fr�n instruktionen
--      Z      - zero-flagga fr�n ber�kningsenhet
--
-- Utsignaler:
--      StackOp - styr stacken i adressv�ljaren
--      AddrSrc - styr varifr�n n�sta adress ska h�mtas
--      ALUOp   - best�mmer operatinen f�r ALU i ber�kningsenhet
--      ALUSrc  - v�ljer om ett register eller insignalen fr�n IO-blocket ska 
--                vara operand till ALU
--      RegEna  - laddsignal till registerblocket
--      OutEna  - laddsignal till utsignalsregistret i IO-blocket
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity instruktionsavkodare is
    port(
        OPCODE : in std_logic_vector(3 downto 0);
        Z : in std_logic;
        StackOp : out std_logic_vector(1 downto 0);
        AddrSrc : out std_logic_vector(1 downto 0);
        ALUOp : out std_logic_vector(2 downto 0);
        ALUSrc : out std_logic;
        RegEna : out std_logic;
        OutEna : out std_logic
    );
end entity;

architecture behaviour of instruktionsavkodare is
    
begin
process(OPCODE, Z)
begin
    StackOp <= STACK_OP_HOLD;
    AddrSrc <= ADDR_PC_PLUS_ONE;
    ALUOp <= "000";
    ALUSrc <= '0';
    OutEna <= '0';
    RegEna <= '0';

    case OPCODE is
        when OPCODE_CALL =>
            StackOp <= STACK_OP_PUSH;
            AddrSrc <= ADDR_DATA;
        when OPCODE_RET =>
            StackOp <= STACK_OP_POP;
            AddrSrc <= ADDR_TOS;
        when (OPCODE_BZ) =>
        ALUOp <= "001";
            if(Z = '1') then
                AddrSrc <= ADDR_DATA;
            end if;
        when OPCODE_B =>
            AddrSrc <= ADDR_DATA;
        when OPCODE_ADD =>
            ALUOp <= "010";
            ALUSrc <= '0';
            RegEna <= '1';
        when OPCODE_SUB =>
            ALUOp <= "011";
            ALUSrc <= '0';
            RegEna <= '1';
        when OPCODE_LD =>
            RegEna <= '1';
        when OPCODE_IN => 
            ALUOp <= "001";
            ALUSrc <= '1';
            RegEna <= '1';
        when OPCODE_OUT =>
            ALUOp <= "001";
            ALUSrc <= '0';
            OutEna <= '1';
        when OPCODE_AND =>
            ALUOp <= "100";
            ALUSrc <= '0';
            RegEna <= '1';
        when OPCODE_DOUT =>
            OutEna <= '1';
        when others =>
            OutEna <= '0';
    end case;
end process;     
end architecture;