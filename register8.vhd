library ieee;
use ieee.std_logic_1164.all;

entity register8 is
  port (
        i_D     : in  std_logic_vector(7 downto 0);
        i_CLK   : in  std_logic;
        i_ENA   : in  std_logic;
        i_CLR_n : in  std_logic;
        o_Q     : out std_logic_vector(7 downto 0)
        );
end register8;

architecture arch_1 of register8 is
begin
  process(i_CLK, i_CLR_n)
  begin
    if (i_CLR_n = '0') then
      o_Q <= (others => '0');
    elsif (i_CLK'event and i_CLK = '1') then
      if (i_ENA = '1') then
        o_Q <= i_D;
      end if;
    end if;
  end process;
end arch_1;
