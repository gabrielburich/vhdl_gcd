library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gcdCalc_tb is
end gcdCalc_tb;
--------------------------------------------------------------------
architecture arch_1 of gcdCalc_tb is

  component gcdCalc is
    port (
      i_clk: in std_logic;
      i_clr_n : in std_logic;
      i_go: in std_logic;
      i_x : in std_logic_vector(7 downto 0);
      i_y : in std_logic_vector(7 downto 0);
      o_d : out std_logic_vector(7 downto 0);
      o_rdy : out std_logic
    );
  end component;

  constant c_CLKP : time := 10 ns; -- clock period

  signal w_clk : std_logic := '1';
  signal w_clr_n : std_logic := '0';
  signal w_go : std_logic := '0';
  signal w_rdy : std_logic;
  signal w_x     : std_logic_vector(7 downto 0);
  signal w_y     : std_logic_vector(7 downto 0);
  signal w_d     : std_logic_vector(7 downto 0);

begin

  u_0 : gcdCalc
	      port map (
          i_clk => w_CLK,
          i_clr_n => w_clr_n,
          i_go => w_go,
          i_x => w_x,
          i_y => w_y,
          o_d => w_d,
          o_rdy => w_rdy
	    );
  -- process for generating the clock
  w_CLK <= not w_CLK after c_CLKP / 2;

process
  begin

    w_clr_n <= '1';
    w_go <= '1';
    w_x <= "00001100";
    w_y <= "00001001";
    wait for 100 ns;
  end process;

end arch_1;
