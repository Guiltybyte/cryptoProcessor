library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NL_LUT is
  generic(
    N_4 : natural := 4 -- number of bits = N_4 * 4 eg. N_4 = 4 means 16 bit LUT
  );
  port(
    LUT_in  : in  std_logic_vector((N_4*4)-1 downto 0);
    LUT_out : out std_logic_vector((N_4*4)-1 downto 0)
  );
end NL_LUT;

architecture Behavioral of NL_LUT is

  component Sbox is
    port(
      Sbox_in   : in  std_logic_vector(3 downto 0);
      Sbox_out  : out std_logic_vector(3 downto 0) 
    );
  end component Sbox;   
begin
  boxes : for iter in 0 to (N_4 - 1) generate
    S_box : Sbox
      port map(
        Sbox_in  => LUT_in((iter*4)+3 downto iter*4),
        Sbox_out => LUT_out((iter*4)+3 downto iter*4)
      );
  end generate boxes;
end Behavioral;