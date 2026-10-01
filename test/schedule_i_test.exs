defmodule ScheduleITest do
  use ExUnit.Case
  doctest ScheduleI
  alias Structure.{Team, Club}

  test "greets the world" do
    assert ScheduleI.hello() == :world
  end

  test "reverse a list" do
    assert Common.reverse([]) == []
    assert Common.reverse([1,2,3,4]) == [4,3,2,1]
    assert Common.reverse([1]) == [1]
  end
  test "check size of list" do
    assert Common.size([]) == 0
    assert Common.size([1,2,3,4,5]) == 5
  end

  #test "Check the whatteams()" do
  #  team1 = %Team{name: :a, year: :_2014, league: :p, club: %Club{name: :a, area: :m, restricted: :ok}}
  #  team2 = %Team{name: :a, year: :_2014, league: :p, club: %Club{name: :b, area: :m, restricted: :ok}}
  #  team3 = %Team{name: :a, year: :_2014, league: :m, club: %Club{name: :c, area: :m, restricted: :ok}}
  #  team4 = %Team{name: :a, year: :_2014, league: :m, club: %Club{name: :d, area: :m, restricted: :ok}}
  #  team5 = %Team{name: :a, year: :_2015, league: :p, club: %Club{name: :e, area: :m, restricted: :ok}}
  #  team6 = %Team{name: :a, year: :_2015, league: :p, club: %Club{name: :f, area: :m, restricted: :ok}}
  #  teamx = [team1, team2, team3, team4, team5, team6]
  #  teams = [team1, team2]
  #  teamz = [team3, team4, team5, team6]
  #  assert Schedule.whatteams([],[],[]) == {[],[]}
  #  assert Schedule.whatteams([],[],teamx) == {teams, teamz}
  #end
  test "Check max(a,b)" do
    assert Common.max(2,1) == 2
    assert Common.max(1,2) == 2
    assert Common.max(4,4) == 4
  end
  test "Joining two lists" do
    assert Schedule.join([],[]) == []
    assert Schedule.join([], [1,2]) == [1,2]
    assert Schedule.join([1,2],[3,4]) == [2,1,3,4]
  end
end
