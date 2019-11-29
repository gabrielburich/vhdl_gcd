library ieee;
use ieee.std_logic_1164.all;

entity gcdCalc is
	port (
		i_clk: in std_logic;
		i_clr_n : in std_logic;
		i_go: in std_logic;
		i_x : in std_logic_vector(7 downto 0);
		i_y : in std_logic_vector(7 downto 0);
		o_d : out std_logic_vector(7 downto 0);
		o_rdy : out std_logic
	);
end gcdCalc;

architecture behavior of gcdCalc is
-- Compoentes utilizados
	component datapatch is
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
	end component;

	component controlUnit is
		port (
			i_CLK : in  std_logic;
			i_go : in  std_logic;
			i_eq : in std_logic;
			i_lessThen : in std_logic;
			o_x_sel : out std_logic;
			o_y_sel : out std_logic;
			o_x_ena : out std_logic;
			o_y_ena : out std_logic;
			o_gcd_ena : out std_logic;
			o_rdy : out std_logic
		);
	end component;
-- Fim Componentes utilizados
-- Fios internos
	signal w_datapatch_x_sel_in : std_logic;
	signal w_datapatch_y_sel_in : std_logic;
	signal w_datapatch_x_ena_in : std_logic;
	signal w_datapatch_y_ena_in : std_logic;
	signal w_datapatch_gcd_ena_in : std_logic;
	signal w_datapatch_eq_out : std_logic;
	signal w_datapatch_lt_out : std_logic;
-- Fim fios internos
begin
	-- Intancia de componetes
	u_datapatch : datapatch
		port map (
			i_clk => i_clk,
			i_x  => i_x,
			i_y  => i_y,
			o_d  => o_d,
			i_x_sel  => w_datapatch_x_sel_in,
			i_y_sel  => w_datapatch_y_sel_in,
			i_x_ena  => w_datapatch_x_ena_in,
			i_y_ena  => w_datapatch_y_ena_in,
			i_gcd_ena  => w_datapatch_gcd_ena_in,
			i_clr_n  => i_clr_n,
			o_eq  => w_datapatch_eq_out,
			o_less_then  => w_datapatch_lt_out
		);

	u_control_unit : controlUnit
		port map (
			i_CLK    => i_CLK,
			i_go   => i_go,
			i_eq   => w_datapatch_eq_out,
			i_lessThen  => w_datapatch_lt_out,
			o_x_sel => w_datapatch_x_sel_in,
			o_y_sel => w_datapatch_y_sel_in,
			o_x_ena => w_datapatch_x_ena_in,
			o_y_ena => w_datapatch_y_ena_in,
			o_gcd_ena => w_datapatch_gcd_ena_in,
			o_rdy  => o_rdy
		);
--Fim Intancia de componetes
end behavior;
