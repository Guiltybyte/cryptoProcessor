library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CryptoProc is
  port(
    Abus_in, Bbus_in : in std_logic_vector(15 downto 0);
    Ctrl_in : in std_logic_vector(3 downto 0);
    Result  : out std_logic_vector(15 downto 0)
  );
end CryptoProc;

architecture Structural of CryptoProc is
  -- define intermediate signals
  signal inter_ALUctrl, inter_ROTctrl : std_logic_vector(2 downto 0);
    
  -- intermediate outputs for later tristate buffering on result line
  signal inter_ALUout, inter_ROT_out, inter_LUT_out : std_logic_vector(Result'range);
  signal inter_ALUen, inter_ROTen, inter_LUTen      : std_logic;

begin
  Control_inst : entity work.Control
    port map(
      Ctrl => Ctrl_in,
      Ctrl_ALU => inter_ALUctrl,
      Ctrl_ROT => inter_ROTctrl,
      ALUen => inter_ALUen,
      ROTen => inter_ROTen,
      LUTen => inter_LUTen
    );
  ALU_inst : entity work.ALU
    port map(
      Abus => Abus_in,
      Bbus => Bbus_in,
      ALUctrl => inter_ALUctrl,
      ALUout => inter_ALUout
    );
  ROT_inst : entity work.ROT 
    port map(
      ROT_in => Bbus_in,
      ROTctrl => inter_ROTctrl,
      ROT_out => inter_ROT_out
    );
  LUT_inst : entity work.NL_LUT
    port map(
      LUT_in => Abus_in,
      LUT_out => inter_LUT_out
    );

  ------------------------------------------
  -- TRI State buffering on Result Line   --
  ------------------------------------------
  Result <= inter_ROT_out when inter_ROTen = '1' else (others => 'Z');
  Result <= inter_ALUout  when inter_ALUen = '1' else (others => 'Z');
  Result <= inter_LUT_out when inter_LUTen = '1' else (others => 'Z');
end Structural;
  