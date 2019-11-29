library ieee;
use ieee.std_logic_1164.all;

entity datapatch is
	port (
		i_clk: in std_logic;
		i_x : in std_logic_vector(7 downto 0);
		i_y : in std_logic_vector(7 downto 0);
		o_d : out std_logic_vector(7 downto 0);
		i_x_sel : in std_logic;
		i_y_sel : in std_logic;
		i_x_ena : in std_logic;
		i_y_ena : in std_logic;
		i_gcd_ena : in std_logic;
		i_clr_n : in std_logic;
		o_eq : out std_logic;
		o_less_then : out std_logic
	);
end datapatch;

architecture behavior of datapatch is

-- Compoentes utilizados
	component mux is
		port (
			i_DIN0 : in std_logic_vector(7 downto 0);
			i_DIN1 : in std_logic_vector(7 downto 0);
			i_SEL : in std_logic;
			o_DOUT : out std_logic_vector(7 downto 0)
		);
	end component;

	component register8 is
		port (
			i_D     : in  std_logic_vector(7 downto 0);
			i_CLK   : in  std_logic;
			i_ENA   : in  std_logic;
			i_CLR_n   : in  std_logic;
			o_Q     : out std_logic_vector(7 downto 0)
		);
	end component;

	component subtract is
		port (
			i_DIN0 : in std_logic_vector(7 downto 0);
			i_DIN1 : in std_logic_vector(7 downto 0);
			o_DOUT : out std_logic_vector(7 downto 0)
		);
	end component;

	component equal is
		port (
			i_DIN0 : in std_logic_vector(7 downto 0);
			i_DIN1 : in std_logic_vector(7 downto 0);
			o_DOUT : out std_logic
		);
	end component;

	component lessThen is
		port (
			i_DIN0 : in std_logic_vector(7 downto 0);
			i_DIN1 : in std_logic_vector(7 downto 0);
			o_DOUT : out std_logic
		);
	end component;
	-- Fim Componentes utilizados

	-- Fios internos
	signal w_register_x_out : std_logic_vector(7 downto 0);
	signal w_mux_x_out : std_logic_vector(7 downto 0);
	signal w_subtract_x_out : std_logic_vector(7 downto 0);

	signal w_register_y_out : std_logic_vector(7 downto 0);
	signal w_mux_y_out : std_logic_vector(7 downto 0);
	signal w_subtract_y_out : std_logic_vector(7 downto 0);
	-- Fim fios internos
begin
-- Intancia de componetes
	u_mux_x : mux
		port map (
			i_DIN0 => w_subtract_x_out,
			i_DIN1 => i_x,
			i_SEL => i_x_sel,
			o_DOUT => w_mux_x_out
		);

	u_r_x : register8
		port map (
			i_D => w_mux_x_out,
			i_CLK => i_clk,
			i_ENA => i_x_ena,
			i_CLR_n => i_clr_n,
			o_Q => w_register_x_out
		);

	u_subtract_x : subtract
		port map (
			i_DIN0 => w_register_x_out,
			i_DIN1 => w_register_y_out,
			o_DOUT => w_subtract_x_out
		);

	u_mux_y : mux
		port map (
			i_DIN0 => w_subtract_y_out,
			i_DIN1 => i_y,
			i_SEL => i_y_sel,
			o_DOUT => w_mux_y_out
		);

	u_r_y : register8
		port map (
			i_D => w_mux_y_out,
			i_CLK => i_clk,
			i_ENA => i_y_ena,
			i_CLR_n => i_clr_n,
			o_Q => w_register_y_out
		);

	u_subtract_y : subtract
		port map (
			i_DIN0 => w_register_y_out,
			i_DIN1 => w_register_x_out,
			o_DOUT => w_subtract_y_out
		);

	u_r_gcd : register8
		port map (
			i_D => w_register_x_out,
			i_CLK => i_clk,
			i_ENA => i_gcd_ena,
			i_CLR_n => i_clr_n,
			o_Q => o_d
		);

	u_equa_x_y : equal
		port map (
			i_DIN0 => w_register_x_out,
			i_DIN1 => w_register_y_out,
			o_DOUT => o_eq
		);

	u_lt_x_y : lessThen
		port map (
			i_DIN0 => w_register_x_out,
			i_DIN1 => w_register_y_out,
			o_DOUT => o_less_then
		);
--Fim Intancia de componetes

end behavior;
