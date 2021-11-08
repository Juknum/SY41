library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity somme is
  port (
    INPUT : in std_logic_vector(7 downto 0);
    clk, enter, add : in std_logic;
    MEM : out std_logic_vector(7 downto 0)
  );
end somme;

architecture arch_somme of somme is
  signal LATEST : std_logic_vector(7 downto 0); -- pour la valeur déjà enregistrée

  begin
    process(clk)
    variable RES : std_logic_vector(7 downto 0) := "00000000";

    begin
      if rising_edge(clk) then
        MEM <= INPUT;
        if enter = '1' then
          MEM <= INPUT;
          LATEST <= INPUT;
        elsif add = '1' then
          RES := std_logic_vector(to_unsigned(to_integer(unsigned(INPUT)) + to_integer(unsigned(LATEST)), 8));
          MEM <= RES;
          LATEST <= RES;
        end if;
      end if;
    end process;

end arch_somme;