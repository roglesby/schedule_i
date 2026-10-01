defmodule Structure do
  defmodule Association do
    defstruct name: "ESSDA",
              season: "2026",
              maxweeks: 15,
              startdate: ~D[2026-03-01]

    def print(assoc) do
      IO.puts("Association: #{assoc.name} for #{assoc.season} starting " <>
      Calendar.strftime(assoc.startdate, "%d/%m/%Y"))
    end
  end
  defmodule Timeline do
    defstruct week: 0, maxweek: 0, bestweek: 0,
              game: 0, maxgame: 0,
              match: 0, bestmatch: 0,
              venue: :n, xteams: []
    def print(%Timeline{} = timeline) do
      IO.puts("Timeline: #{timeline.week} of #{timeline.maxweek} : #{timeline.match} of #{timeline.bestmatch} - #{timeline.game} of #{timeline.maxgame}")
    end
  end
  defmodule Configs do
    defstruct random: true,
              # the tolerance for imbalance of home - away fixtures per team.
              checkfix: 1,
              repeatvisitweeks: 4,
              repeatteamweeks: 3,
              maxclubvisits: 1,
              maxteamvisits: 1,
              maxstreak: 3,
              # We never want an imbalance of more than 3 for homev away teams at any club
              pitchlimit: 3,
              # some clubs want a tighter imbalance of only 1. impose the same limit on small clubs
              pitchlimit_strict: 1,
              # If a club has 4 or less teams, then impose a strict pitch limit. These are small clubs
              pitchlimit_club: 4

    def print(%Configs{} = c) do
      IO.puts("Config: #{c.random}:#{c.checkfix}:#{c.repeatvisitweeks}:#{c.repeatteamweeks}:#{c.maxclubvisits}:#{c.maxteamvisits}:#{c.maxstreak}" <>
        ":#{c.pitchlimit}:#{c.pitchlimit_strict}:#{c.pitchlimit_club}")
    end
  end
  defmodule Sides do
  @formats %{
    _2014: :nines,
    _2015: :sevens,
    _2016: :sevens,
    _2017: :sevens
  }

  def for_year(year), do: Map.fetch!(@formats, year)
end
  defmodule Club do
    #@enforce_keys [:name]
    defstruct [name: "", area: " ", restricted: :notok]

    def print(club = %Club{}) do
      "Club: #{club.name} - #{club.area}/#{club.restricted}"
    end

    def prints([]) do
    end

    def prints([club | clubs]) do
      IO.puts(print(club))
      prints(clubs)
    end
  end

  defmodule Team do
    defstruct name: " ", club: nil, year: 0, league: " "
    def sides(%Team{year: year}), do: Sides.for_year(year)
    def print(team = %Team{}) do
      "Team: #{team.year}/#{team.league}/#{sides(team)} - #{team.club.name}/#{team.name} #{team.club.area}"
    end

    def prints([]) do
    end

    def prints([team | teams]) do
      IO.puts(print(team))
      prints(teams)
    end
  end

  defmodule Fixture do
    defstruct home: %Team{},
              away: %Team{}
    def sides(%Team{year: year}), do: Sides.for_year(year)
    def nilfixture do
        %Fixture{home: nil, away: nil}
    end
    def prints([]) do
    end

    def prints([fixture | fixtures]) do
      IO.puts(print(fixture))
      prints(fixtures)
    end
    def print(%Fixture{home: nil, away: nil}) do
      "Fixture: Nil Fixture!!!"
    end
    def print(%Fixture{home: %Team{} = home, away: :nil} = fixture) do
      "Fixture: #{fixture.home.year}/#{fixture.home.league}/#{sides(fixture.home)}" <>
        " #{fixture.home.club.name}/#{fixture.home.name} v Nil Team"
    end
    def print(fixture) do
      "Fixture: #{fixture.home.year}/#{fixture.home.league}/#{sides(fixture.home)}" <>
        " #{fixture.home.club.name}/#{fixture.home.name} v #{fixture.away.club.name}/#{fixture.away.name}"
    end
  end

  defmodule Match do
    defstruct fixture: %Fixture{}, week: :nil, venue: nil, game: 0, xteams: []
    def print(%Match{}=match) do
        IO.puts("Match #{match.week} " <> Fixture.print(match.fixture) <> " " <> Atom.to_string(match.venue) <> " (#{match.game})")
    end
    def prints([]) do

    end
    def prints([match|matches]) do
      print(match)
      prints(matches)
    end
  end
  defmodule Clubconstraint do
    defstruct club1: %Club{}, club2: %Club{}, type: ""
    def prints([]) do
    end
    def prints([clubconstraint|clubconstraints]) do
      IO.puts(print(clubconstraint))
      prints(clubconstraints)
    end
    def print(clubconstraint) do
      "Club Constraint: #{clubconstraint.type} #{clubconstraint.club1.name} v #{clubconstraint.club2.name}"
    end
  end
  defmodule Areaconstraint do
    defstruct area1: "", area2: "", type: ""
    def prints([]) do
    end
    def prints([areaconstraint|areaconstraints]) do
      IO.puts(print(areaconstraint))
      prints(areaconstraints)
    end
    def print(areaconstraint) do
      "Area Constraint: #{areaconstraint.type} #{areaconstraint.area1} v #{areaconstraint.area2}"
    end
  end
  defmodule Teamconstraint do
    defstruct team1: %Team{}, team2: %Team{}, type: ""
    def prints([]) do
    end
    def prints([teamconstraint|teamconstraints]) do
      IO.puts(print(teamconstraint))
      prints(teamconstraints)
    end
    def print(teamconstraint) do
      "Team Constraint: #{teamconstraint.type} " <>
      "#{teamconstraint.team1.club.name}/#{teamconstraint.team1.name} v #{teamconstraint.team2.club.name}/#{teamconstraint.team2.name}"
    end
  end
end
