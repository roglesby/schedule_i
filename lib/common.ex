defmodule Common do

  #alias Structure.{Team, Match, Timeline, Fixture, }
  def size(ls) do
    size(ls, 0)
  end
  def size([], size) do
    size
  end
  def size([l|ls], size) do
    size(ls, size + 1)
  end
  def reverse(ls) do
    reverse(ls, [])
  end
  def reverse([l|ls], lx) do
    reverse(ls, [l|lx])
  end
  def reverse([],lx) do
    lx
  end
  #---------------------------
  def biggest(a, b) when a > b do
    a
  end
  def biggest(_a, b) do
    b
  end
  def join([], teamz) do
    teamz
  end
  def join([team|teams], teamz) do
     join(teams, [team|teamz])
  end

  #-------------------------------------------UNUSED CODE------------------------
  def whatteams([],[],[]) do
     #we have a problem
     {[],[]}
  end
  def whatteams(teams, teamz, []) do
      {Common.reverse(teams), Common.reverse(teamz)}
  end
  def whatteams([],[],[team|teamx]) do
     whatteams([team], [], teamx)
  end
  #def whatteams([%Team{year: year, league: league} = team|teams], teamz, [%Team{year: year, league: league} = teamo | teamx]) do
  #    whatteams([teamo, team | teams], teamz, teamx)
  #end
  def whatteams(teams, teamz, [team | teamx]) do
      whatteams(teams, [team | teamz], teamx)
  end
end
