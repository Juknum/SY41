library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port(
		CLK : in std_logic;
		INPUT : in std_logic_vector(7 downto 0);
		OUTPUT : out std_logic_vector(7 downto 0)
	);
end entity;

architecture arch_reg of reg is
begin
	process(CLK)
	begin

	if rising_edge(CLK) then
		OUTPUT <= INPUT;
	end if;

	end process;
end arch_reg;