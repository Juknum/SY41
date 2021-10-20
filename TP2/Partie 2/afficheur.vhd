library ieee;
use ieee.std_logic_1164.all;

entity afficheur is
  port (
    INPUT: in std_logic_vector(7 downto 0);
    OUTPUT: out std_logic_vector(13 downto 0);
    SIGN: out std_logic
  );
end afficheur;

architecture a of afficheur is

component segment is
  port (
    BITS : in std_logic_vector(3 downto 0);
    HEX : out std_logic_vector(6 downto 0)
  );
end component;

begin
  DIGIT0 : segment port map (BITS=>INPUT(3 downto 0), HEX=>OUTPUT(6 downto 0));
  DIGIT1 : segment port map (BITS=>INPUT(7 downto 4), HEX=>OUTPUT(13 downto 7));
end a;