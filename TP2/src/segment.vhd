library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segment is 
  port (
    SW : in std_logic_vector(3 downto 0); -- 4 bits d'entrées
    HEX : out std_logic_vector(6 downto 0) -- 7 segments de sortie
  );
end segment;

architecture arch_segment of segment is
begin
  process (SW)
  begin
    case SW is
      when "0000" => HEX <= "1000000"; -- 0
      when "0001" => HEX <= "1111001"; -- 1
      when "0010" => HEX <= "0100100"; -- 2
      when "0011" => HEX <= "0110000"; -- 3
      when "0100" => HEX <= "0011001"; -- 4
      when "0101" => HEX <= "0010010"; -- 5
      when "0110" => HEX <= "0000010"; -- 6
      when "0111" => HEX <= "1111000"; -- 7
      when "1000" => HEX <= "0000000"; -- 8
      when "1001" => HEX <= "0010000"; -- 9
      when "1010" => HEX <= "0001000"; -- A
      when "1011" => HEX <= "0000011"; -- b
      when "1100" => HEX <= "1000110"; -- C
      when "1101" => HEX <= "0100001"; -- d
      when "1110" => HEX <= "0000110"; -- E
      when "1111" => HEX <= "0001110"; -- F
      when others => HEX <= "1111111"; -- undefined -> lamp off
    end case;
  end process;
end arch_segment;