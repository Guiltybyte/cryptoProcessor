library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROT is
  generic(
    N : natural := 16
  );
  port(
    ROT_in  : in  std_logic_vector(N-1 downto 0);
    ROTctrl : in  std_logic_vector(2 downto 0);
    ROT_out : out std_logic_vector(N-1 downto 0)
  );
end ROT;

architecture Behavioral of ROT is
begin      
  with ROTctrl select
    ROT_out <=  std_logic_vector(unsigned(ROT_in) ROL 1) when "000",  -- ROL1
                std_logic_vector(unsigned(ROT_in) ROL 2) when "001",  -- ROL2
                std_logic_vector(unsigned(ROT_in) ROL 3) when "010",  -- ROL3
                std_logic_vector(unsigned(ROT_in) ROL 4) when "011",  -- ROL4
                std_logic_vector(unsigned(ROT_in) ROL 8) when "100",  -- ROL8
                std_logic_vector(unsigned(ROT_in) ROR 4) when "101",  -- ROR4
                -- This will run when "110" & "111" however there should never be a case when Ren = '1' and Rctrl = "111"
                std_logic_vector(unsigned(ROT_in) ROR 8) when others; -- ROR8                
end Behavioral;