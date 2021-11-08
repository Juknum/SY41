library ieee;
use ieee.std_logic_1164.all;

entity pulse_input is
  port (
    pb, clk : in std_logic;
    pb_pulse : out std_logic
  );
end pulse_input;

architecture arch_pulse_input of pulse_input is
  signal x : std_logic_vector(1 downto 0);
  
  begin

    process(clk)
    begin
      if rising_edge(clk) then
        if x = "00" and pb = '0' then
          x <= "01";

        elsif x = "01" and pb = '0' then
          x <= "10";

        elsif x = "10" and pb = '1' then
          x <= "00";
        
        end if;
      end if;
    end process;

  pb_pulse <= x(0);

end arch_pulse_input;