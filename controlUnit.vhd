library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
  port (
    i_CLK : in  std_logic;
    i_go  : in  std_logic;
    i_eq  : in std_logic;
    i_lessThen : in std_logic;
    o_x_sel : out std_logic;
    o_y_sel : out std_logic;
    o_x_ena : out std_logic;
    o_y_ena : out std_logic;
    o_gcd_ena : out std_logic;
    o_rdy : out std_logic
  );
END controlUnit;

architecture arch_1 of controlUnit is

  type t_STATE is (t_go, t_init, t_dif, t_comparator, t_xLTy, t_yLTx, t_done, t_rdy);

  signal w_STATE_REG  : t_STATE;
  signal w_NEXT_STATE : t_STATE;
begin

  p_STATE_REG: process(i_CLK)
  begin
    if (i_CLK'event and i_CLK = '1') then
      w_STATE_REG <= w_NEXT_STATE;
    end if;
  end process;

  p_next_state: process(w_STATE_REG, i_go, i_eq, i_lessThen)
  begin
    case (w_STATE_REG) is
      when t_go => if (i_go = '1') then
                     w_NEXT_STATE <= t_init;
                   else
                     w_NEXT_STATE <= t_go;
                   end if;
      when t_init => w_NEXT_STATE <= t_dif;
      when t_dif =>
      			        if( i_eq = '1' ) then
                        w_NEXT_STATE <= t_done;
                    else
                      w_NEXT_STATE <= t_comparator;
              			end if;
      when t_comparator =>
      			        if( i_lessThen = '1' ) then
              			    w_NEXT_STATE <= t_xLTy;
              			else
              			    w_NEXT_STATE <= t_yLTx;
              			end if;
     	when t_xLTy =>  w_NEXT_STATE <= t_dif;
     	when t_yLTx =>	w_NEXT_STATE <= t_dif;
      when t_done =>  w_NEXT_STATE <= t_rdy;
     	when others =>	w_NEXT_STATE <= t_go;
    end case;
 end process;

 results : process(w_STATE_REG)
 begin
    o_x_ena <= '0';
    o_y_ena <= '0';
    o_gcd_ena <= '0';
    o_x_sel <= '0';
    o_y_sel <= '0';
    o_rdy <= '0';
    case (w_STATE_REG) is
      when t_init =>
                o_x_ena <= '1';
                o_y_ena <= '1';
                o_x_sel <= '1';
                o_y_sel <= '1';
      when t_xLTy =>
                o_y_ena <= '1';
      when t_yLTx =>
                o_x_ena <= '1';
      when t_done =>
                o_gcd_ena <= '1';
      when t_rdy =>
                o_rdy <= '1';
      when others => null;
    end case;
 end process;

end arch_1;
