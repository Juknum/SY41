library ieee;
use ieee.std_logic_1164.all;

entity transcodeur is
	port (
		INPUT: in std_logic_vector(3 downto 0);
	  OUTPUT: out std_logic_vector(6 downto 0)
	);
end transcodeur;

architecture trans of transcodeur is
begin
	process(INPUT)
		begin
			case INPUT is
				when "0000" => OUTPUT <= "1000000"; -- 0
				when "0001" => OUTPUT <= "1111001"; -- 1
				when "0010" => OUTPUT <= "0100100"; -- 2
				when "0011" => OUTPUT <= "0110000"; -- 3
				when "0100" => OUTPUT <= "0011001"; -- 4
				when "0101" => OUTPUT <= "0010010"; -- 5
				when "0110" => OUTPUT <= "0000010"; -- 6
				when "0111" => OUTPUT <= "1111000"; -- 7
				when "1000" => OUTPUT <= "0000000"; -- 8
				when "1001" => OUTPUT <= "0010000"; -- 9
				when "1010" => OUTPUT <= "0001000"; -- A
				when "1011" => OUTPUT <= "0000011"; -- b
				when "1100" => OUTPUT <= "1000110"; -- C
				when "1101" => OUTPUT <= "0100001"; -- d
				when "1110" => OUTPUT <= "0000110"; -- E
				when "1111" => OUTPUT <= "0001110"; -- F
				when others => OUTPUT <= "1111111"; -- undefined -> lamp off
			end case;
	end process;
end trans;