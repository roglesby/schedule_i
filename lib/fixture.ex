defmodule Fix do
  #alias Structure.{Club, Team, Match, Timeline, Fixture, Clubconstraint, Teamconstraint, Areaconstraint}
  alias Structure.{Club, Team, Clubconstraint, Teamconstraint, Areaconstraint}
  import Structure
  def venue(%Team{club: club}, %Team{club: club}, _venue) do
    display("Same club #{club.name}")
    :x
  end
  def venue(%Team{year: year, league: league} = home, %Team{year: year, league: league} = away, venue) do
    display("Same year #{year} and league #{league}")
    venue = constraint(home, away, Data.constraints, venue)
    #IO.puts("venue is #{venue}")
    venue
  end
  def venue(home, away, _venue) do
    display("different leagues #{home.year} #{away.year}  #{home.league} #{away.league}")
    :x
  end
  def display(_insp) do
    #IO.inspect(insp)
  end
  def constraint(_home, _away, _constraints, :x) do
    :x
  end
  def constraint(_home, _away, [], venue) do
    venue
  end
  def constraint(home, away,
              [%Teamconstraint{type: :X, team1: home, team2: away} | _constraints],
              _venue ) do
              :x
  end
  def constraint(home, away,
              [%Teamconstraint{type: :X, team1: away, team2: home} | _constraints],
              _venue ) do
              :x
  end
  def constraint(%Team{club: homeclub}, %Team{club: awayclub},
              [%Clubconstraint{type: :X, club1: homeclub, club2: awayclub} | _constraints],
              _venue ) do
              :x
  end
  def constraint(%Team{club: homeclub}, %Team{club: awayclub},
              [%Clubconstraint{type: :X, club1: awayclub, club2: homeclub} | _constraints],
              _venue ) do
              :x
  end
  def constraint(%Team{club: %Club{area: homearea}}, %Team{club: %Club{area: awayarea}},
              [%Areaconstraint{type: :X, area1: homearea, area2: awayarea} | _constraints],
              _venue ) do
              :x
  end
  def constraint(%Team{club: %Club{area: homearea}}, %Team{club: %Club{area: awayarea}},
              [%Areaconstraint{type: :X, area1: awayarea, area2: homearea} | _constraints],
              _venue ) do
              :x
  end
  def constraint(home, away,
              [_constraint | constraints],
              venue ) do
              constraint(home, away, constraints, venue)
  end
end
