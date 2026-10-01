defmodule Data do
  # Structure.Club.prints(Map.values(Data.clubs))
  # Structure.Team.prints(Data.teams)
  alias Structure.{Club, Team, Fixture, Match, Clubconstraint, Teamconstraint, Areaconstraint}

  def clubs do
    [

      %Club{name: :c, area: :c, restricted: :notok},
      %Club{name: :d, area: :e, restricted: :notok},
      %Club{name: :e, area: :m, restricted: :notok},
      %Club{name: :l, area: :w, restricted: :notok}
    ]
    |> Map.new(&{&1.name, &1})
  end

  def teams do
    clubs = clubs()
    # IO.inspect("#{c.restricted}")
    [
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:c]},
      %Team{name: :b, year: :_2014, league: :p, club: clubs[:c]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:d]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:e]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:l]},
      %Team{name: :b, year: :_2014, league: :p, club: clubs[:l]},
      %Team{name: :a, year: :_2014, league: :m, club: clubs[:c]},
      %Team{name: :b, year: :_2014, league: :m, club: clubs[:d]},
      %Team{name: :a, year: :_2014, league: :m, club: clubs[:d]},
      %Team{name: :a, year: :_2014, league: :m, club: clubs[:e]},
      %Team{name: :a, year: :_2014, league: :m, club: clubs[:l]},
      %Team{name: :b, year: :_2014, league: :m, club: clubs[:l]}
    ]
    [
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:c]},
      %Team{name: :b, year: :_2014, league: :p, club: clubs[:c]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:d]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:e]},
      %Team{name: :a, year: :_2014, league: :p, club: clubs[:l]},
      %Team{name: :b, year: :_2014, league: :p, club: clubs[:l]}
    ]
  end
  def testfixtures do
    clubs = clubs()
    fix1 = %Fixture{home: %Team{name: :a, year: :_2014, league: :p, club: clubs[:c]},
       away:  %Team{name: :b, year: :_2014, league: :p, club: clubs[:l]}}

    fix2 = %Fixture{home: %Team{name: :a, year: :_2014, league: :p, club: clubs[:d]},
       away:  %Team{name: :a, year: :_2014, league: :p, club: clubs[:e]}}

    fix3 = %Fixture{home: %Team{name: :b, year: :_2014, league: :p, club: clubs[:c]},
       away:  %Team{name: :a, year: :_2014, league: :p, club: clubs[:l]}}
    [fix1, fix2, fix3]
  end
  def testmatch do
    clubs = clubs()
    fix1 = %Fixture{home: %Team{name: :a, year: :_2014, league: :p, club: clubs[:c]},
       away:  %Team{name: :b, year: :_2014, league: :p, club: clubs[:l]}}
    %Match{fixture: fix1, venue: :b}
  end
  def clubconstraints do
    clubs = clubs()
    con1 = %Clubconstraint{type: :X, club1: clubs[:e], club2: clubs[:l]}
    [con1]
  end
  def teamconstraints do
    clubs = clubs()
    con1 = %Teamconstraint{team1: %Team{name: :a, year: :_2014, league: :p, club: clubs[:c]},
       team2:  %Team{name: :b, year: :_2014, league: :p, club: clubs[:l]},
      type: :Y}
    [con1]
  end
  def areaconstraints do
    con1 = %Areaconstraint{type: :Y, area1: :e, area2: :w}
    [con1]
  end
  def constraints do
    clubconstraints() ++ teamconstraints() ++ areaconstraints()
  end
end
