library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sbox is
  port(
    Sbox_in   : in  std_logic_vector(3 downto 0);
    Sbox_out  : out std_logic_vector(3 downto 0)
  );
end Sbox;

architecture Behavioral of Sbox is
begin
  with Sbox_in select
    Sbox_out <= x"C" when x"0",
                x"5" when x"1",
                x"6" when x"2",
                x"B" when x"3",
                x"9" when x"4",
                x"0" when x"5",
                x"A" when x"6",
                x"D" when x"7",
                x"3" when x"8",
                x"E" when x"9",
                x"F" when x"A",
                x"8" when x"B",
                x"4" when x"C",
                x"7" when x"D",
                x"1" when x"E",
                x"2" when x"F",
                x"0" when others; -- define default for simulation 
end Behavioral;
