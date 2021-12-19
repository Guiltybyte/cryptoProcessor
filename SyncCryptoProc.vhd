library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SyncCryptoProc is
  port(
    Abus, Bbus  : in std_logic_vector(15 downto 0);
    Ctrl        : in std_logic_vector(3 downto 0);
    Result_r    : out std_logic_vector(15 downto 0);
    clk, reset  : in std_logic 
  );
end SyncCryptoProc;

architecture Behavioral of SyncCryptoProc is
  -- intermediate signals
  signal Abus_r, Bbus_r : std_logic_vector(Abus'range);
  signal Result_out     : std_logic_vector(Result_r'range);
  signal Ctrl_r         : std_logic_vector(Ctrl'range); 
begin

  ProcessingUnit : entity work.CryptoProc
    port map(
      Abus_in => Abus_r,
      Bbus_in => Bbus_r,
      Ctrl_in => Ctrl_r,
      Result => Result_out
    );
  -----------------------------
  --  Register Description   --
  -----------------------------
  process(clk, reset) begin
    if reset = '1' then -- reset is asynchronous and enable high
        -- input registers
        Abus_r   <= (others => '0');
        Bbus_r   <= (others => '0');
        Ctrl_r   <= (others => '0');
        -- output register
        Result_r <= (others => '0');    
    else -- else is important to avoid reset and normal operation triggering simultaneously
      -- input registers
      if rising_edge(clk) then 
        Abus_r <= Abus;
        Bbus_r <= Bbus;
        Ctrl_r <= Ctrl;
      end if;
      -- output register
      if falling_edge(clk) then -- Would making this elsif affect behaviour at all?
        Result_r <= Result_out;
      end if;
    end if;  
  end process;
       
end Behavioral;
