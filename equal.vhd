library ieee;
use ieee.std_logic_1164.all;

entity equal is
	port (
		i_DIN0 : in std_logic_vector(7 downto 0);
		i_DIN1 : in std_logic_vector(7 downto 0);
		o_DOUT : out std_logic
	);
end equal;

architecture arch of equal is
begin
	O_DOUT <= '1' when i_DIN0 = i_DIN1 else '0';
end arch;
