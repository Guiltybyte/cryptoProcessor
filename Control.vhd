------------------------
-- REQUIRES VHDL 2008 --
------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
  port(
    Ctrl                : in  std_logic_vector(3 downto 0);
    Ctrl_ALU, Ctrl_ROT  : out std_logic_vector(2 downto 0);
    ALUen, ROTen, LUTen : out std_logic
  );
end Control;

architecture Behavioral of Control is
begin
  Ctrl_ALU <= Ctrl(Ctrl_ALU'range);
  Ctrl_ROT <= Ctrl(Ctrl_ROT'range);
  
  ALUen <= not Ctrl(Ctrl'length-1); -- ALU enabled only when this MSB is LOW
  LUTen <= and Ctrl;                -- reduction AND is 1 if and only if all bits are 1
  ROTen <= (not LUTen) and (Ctrl(Ctrl'length-1)); -- high if and only if MSB is high and LUTen is low
end Behavioral;