library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity afficheur is 
  port (
    INPUT : in std_logic_vector(9 downto 0); -- switches
    BTN : in std_logic; -- bouton pour la somme
    clk : in std_logic;

    HEX0, HEX1 : out std_logic_vector(6 downto 0); -- afficheurs
    SIGN : out std_logic -- afficheur (signe)
  );
end afficheur;

architecture arch_afficheur of afficheur is
signal SEG : std_logic_vector(7 downto 0); -- sortie 7 segments
signal MEM : std_logic_vector(7 downto 0); -- mémoire
signal PULSE : std_logic; -- pulsation

-- segment.vhd
component segment is
  port (
    SW : in std_logic_vector(3 downto 0);
    HEX : out std_logic_vector(6 downto 0)
  );
end component;

-- somme.vhd
component somme is
  port (
    INPUT : in std_logic_vector(7 downto 0);
    clk, enter, add : in std_logic;
    MEM : out std_logic_vector(7 downto 0)
  );
end component;

-- pulse_input.vhd
component pulse_input is 
  port (
    pb, clk : in std_logic;
    pb_pulse : out std_logic
  );
end component;

begin
  -- clock
  U4 : pulse_input port map(BTN, clk, PULSE);
  -- on somme
  U3 : somme port map(INPUT(7 downto 0), PULSE, INPUT(9), INPUT(8), MEM(7 downto 0));  
  
  process(MEM)
    begin
      -- si négatif
      if MEM(7) = '1' then
        SIGN <= '0';
        SEG <= std_logic_vector(unsigned(not(MEM)) + 1);

      -- si positif
      else
        SIGN <= '1';
        SEG <= MEM;
      end if;
  end process;

  -- on affiche
  U1 : segment port map(SEG(3 downto 0), HEX0);
  U2 : segment port map(SEG(7 downto 4), HEX1);
end arch_afficheur;