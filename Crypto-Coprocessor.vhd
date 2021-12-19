library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CryptoCoprocessor is
 port(
   clock, reset : in std_logic;
   instruction  : in std_logic_vector(15 downto 0)
 );
end CryptoCoprocessor;

architecture Structural of CryptoCoprocessor is
  signal interA, interB : std_logic_vector(15 downto 0);
  signal interResult    : std_logic_vector(15 downto 0);
begin
  RAM : entity work.register_file
    port map(
      Abus => interA,
      Bbus => interB,
      Result => interResult,
      clock => clock,
      writeEnable => '1',
      reset => reset,
      regAsel => instruction(11 downto 8),
      regBsel => instruction(7 downto 4),
      writeRegSel => instruction(3 downto 0)
    );
    
  ProcessingUnit : entity work.CryptoProc
    port map(
      Abus_in => interA,
      Bbus_in => interB,
      Ctrl_in => instruction(15 downto 12),  -- OPCODE
      Result => interResult
    );
end Structural;