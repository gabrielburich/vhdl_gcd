library ieee;
use ieee.std_logic_1164.ALL;

entity mux is
	port (
		i_DIN0 : in std_logic_vector(7 downto 0);
		i_DIN1 : in std_logic_vector(7 downto 0);
		i_SEL : in std_logic;
		o_DOUT : out std_logic_vector(7 downto 0)
	);
end mux;

architecture arch of mux is
begin
	process (i_DIN0, i_DIN1, i_SEL)
	begin
		if i_SEL = '0' then
			o_DOUT <= i_DIN0;
		else
			o_DOUT <= i_DIN1;
		end if;
	end process;
end arch;
