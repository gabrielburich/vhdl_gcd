library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity subtract is
	port (
		i_DIN0 : in std_logic_vector(7 downto 0);
		i_DIN1 : in std_logic_vector(7 downto 0);
		o_DOUT : out std_logic_vector(7 downto 0)
	);
end subtract;

architecture arch of subtract is
begin
	o_DOUT <= i_DIN0 - i_DIN1;
end arch;
