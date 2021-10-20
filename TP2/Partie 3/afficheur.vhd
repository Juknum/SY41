library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity afficheur is 
  port (
    E: in std_logic_vector(7 downto 0);
    HEX0, HEX1 : out std_logic_vector(6 downto 0);
    SIGN : out std_logic
  );
end afficheur;

architecture arch_afficheur of afficheur is -- Déclaration des signaux interne
signal S : std_logic_vector(7 downto 0);

component segment is -- Déclaration des components (identique à l'entity) => voir segment.vhd
  port (
    E : in std_logic_vector(3 downto 0);
    HEX : out std_logic_vector(6 downto 0)
  );
end component;

component reg is
	port (
		CLK : in std_logic;
		INPUT : in std_logic_vector(7 downto 0);
		OUTPUT : out std_logic_vector(7 downto 0)
	);
end component;

begin
  process(E)
    begin
      if E(7) = '1' then
        SIGN <= '0';
        S <= std_logic_vector(unsigned(not(E)) + 1);
      else
        SIGN <= '1';
        S <= E;
      end if;
  end process;

  U1 : segment port map(S(3 downto 0), HEX0);
  U2 : segment port map(S(7 downto 4), HEX1);
end arch_afficheur;