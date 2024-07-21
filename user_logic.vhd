library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
  Port ( 
  ck        : in std_logic;
  ce        : in std_logic;
  sclr      : in std_logic;
  X_a       : in std_logic_vector(15 downto 0);
  X_b       : in std_logic_vector(15 downto 0);
  z         : out std_logic_vector(31 downto 0)          
  );
end user_logic;

architecture Behavioral of user_logic is
  component  xbip_multadd_0 IS
  PORT (
    CLK      : IN STD_LOGIC;
    CE       : IN STD_LOGIC;
    SCLR     : IN STD_LOGIC;
    A        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    PCOUT    : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END component;

signal temp, W      : std_logic_vector(31 downto 0) := (others => '0');
signal subtract_low : std_logic;

begin
    subtract_low    <= '0';
    z               <= temp;
    
    U:    xbip_multadd_0 
      PORT MAP(
        CLK      => ck,
        CE       => ce,
        SCLR     => sclr,
        A        => X_a,
        B        => X_b,
        C        => temp,
        SUBTRACT => subtract_low,
        P        => W,
        PCOUT    => open
      );

    process(ck, ce)
    begin
        if ck = '1' and ck'event and ce = '1' then
            if sclr = '1' then
                temp    <= (others => '0');
            else
                temp    <= W;
            end if;
        end if;
    end process;
end Behavioral;













