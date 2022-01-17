library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD_UNSIGNED.ALL; -- available in VHDL2008

entity register_file is
  generic(
    N : natural := 16; -- Word size
    M : natural := 4   -- Number of RAM Addresses
  ); 
  port(
    Abus, Bbus                    : out std_logic_vector(N-1 downto 0);
    Result                        : in  std_logic_vector(N-1 downto 0);
    clock, reset, writeEnable     : in  std_logic;
    regAsel, regBsel, writeRegSel : in  std_logic_vector(M-1 downto 0) 
  );
end register_file;

architecture Behavioral of register_file is
  type memory is array(0 to 2**M-1) of std_logic_vector(N-1 downto 0);
  signal RAM : memory := (
    0 => x"0001", 1 => x"c505", 2 => x"3c07",
    3 => x"d405", 4 => x"1186", 5 => x"f407",
    6 => x"1086", 7 => x"4706", 8 => x"6808",
    9 => x"baa0", 10 => x"c902", 11 => x"100b",
    12 => x"C000", 13 => x"c902", 14 => x"100b",
    15 => x"b000", others => (others => '0')
  );
begin
  -- Sync Write
  write : process(clock) begin
    if writeEnable = '1' and falling_edge(clock) then
      RAM(to_integer(writeRegSel)) <= Result;   
    end if;
  end process write;
  
  -- Async Read
  Abus <= RAM(to_integer(regAsel));
  Bbus <= RAM(to_integer(regBsel));
end Behavioral;
