library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
  generic(
    N : natural := 16
  );
  port(
    Abus, Bbus  : in std_logic_vector(N-1 downto 0);
    ALUctrl     : in std_logic_vector(2 downto 0);
    ALUout      : out std_logic_vector(N-1 downto 0)
  );
end ALU;

architecture Behavioral of ALU is
begin
  with ALUctrl select
    ALUout <= std_logic_vector(resize(unsigned(Abus) + unsigned(Bbus), N)) when "000", -- ADD
              std_logic_vector(resize(unsigned(Abus) - unsigned(Bbus), N)) when "001", -- SUB
              std_logic_vector(resize(unsigned(Abus) * unsigned(Bbus), N)) when "010", -- MUL
              Abus AND Bbus           when "011", -- AND
              Abus OR Bbus            when "100", -- OR
              Abus XOR Bbus           when "101", -- XOR
              NOT Abus                when "110", -- NOT
              Abus                    when others; --"111"; -- MOV
end Behavioral;