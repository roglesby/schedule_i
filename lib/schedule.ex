defmodule Schedule do

  alias Structure.{Team, Match, Timeline, Fixture}
  import Common

  def schedule do
    #let the scheduling begin!
    IO.inspect("Start scheduling")
    schedule(
      %Timeline{maxweek: 1, week: 0, bestweek: 0, game: 0, maxgame: 99, match: 0, bestmatch: 0},
      :nil,
      {[],[]},
      []
    )
  end
  #-------------------------------------------------------------------
  def schedule(
    %Timeline{game: game, maxgame: maxgame}=timeline,
    _fixture,
    {_teams, _teamz},
    matches) when game >= maxgame do
    IO.inspect("Too many loops")
    {timeline, matches}
  end
  def schedule(
    %Timeline{maxweek: maxweek, week: maxweek}=timeline,
    :nil,
    {[], []},
    matches) do
    IO.inspect("End schedule #{maxweek}")
    {timeline, matches}
  end

  def schedule(
    %Timeline{week: week, bestweek: bestweek, game: game}=timeline,
    :nil,
    {[], []},
    matches
  ) do
    display("New week as no more teams to allocate")
    schedule(%Timeline{timeline|week: week + 1, bestweek: biggest(week + 1, bestweek), game: game + 1},
    :nil,
    {Data.teams,[]},
    matches
    )
  end
  def schedule(
    %Timeline{game: game}=timeline,
    :nil,
    {[%Team{} = team | teams], teamz},
    matches
  ) do
    IO.puts("teams #{show([team|teams])}")
    IO.puts("teamz #{show(teamz)}")
    display("New home team #{team.club.name}/#{team.name}")
    schedule(%Timeline{timeline|game: game + 1, venue: :m},
    %Fixture{home: team, away: :nil},
    {teams,teamz},
    matches
    )
  end
  def schedule(
    %Timeline{week: week, game: game}=timeline,
    %Fixture{home: home, away: :nil},
    {[], teamz},
    []
  ) do
    display("No away team #{home}- no available back out. Disaster for Scotland!!! game #{game} in week #{week} with spare #{size(teamz)} teams")
    {timeline,[]}
  end
  def schedule(
    %Timeline{week: week, game: game}=timeline,
    %Fixture{home: team, away: :nil},
    {[], teamz},
    [%Match{fixture: %Fixture{home: away, away: home}, venue: :a, week: week, xteams: xteams} | matches]
  ) do
    display("No away team - back out to the same week!!!")
    #set up fixture depending on status and venue
    schedule(%Timeline{timeline|game: game + 1, venue: :x, xteams: xteams},
    %Fixture{home: home, away: away},
    {[team|join(teamz,[])],[]},    #<-----does this need reversed?
    matches
    )
  end
  def schedule(
    %Timeline{week: week, game: game}=timeline,
    %Fixture{home: team, away: :nil},
    {[], teamz},
    [%Match{fixture: %Fixture{home: home, away: away}, venue: :h, week: week, xteams: xteams} | matches]
  ) do
    display("No away team - back out to the same week!!!")
    #set up fixture depending on status and venue
    schedule(%Timeline{timeline|game: game + 1, venue: :x, xteams: xteams},
    %Fixture{home: home, away: away},
    {[team|join(teamz,[])],[]},    #<-----does this need reversed?
    matches
    )
  end
  def schedule(
    %Timeline{week: week, game: game}=timeline,
    %Fixture{home: team, away: :nil},
    {[], teamz},
    [%Match{fixture: %Fixture{home: home, away: away}, venue: :b, week: week} | matches]
  ) do
    display("No away team - back out to the same week!!!")
    #set up fixture depending on status and venue
    schedule(%Timeline{timeline|game: game + 1, venue: :a},
    %Fixture{home: home, away: away},
    {[team|join(teamz,[])],[]},    #<-----does this need reversed?
    matches
    )
  end
   def schedule(
    %Timeline{game: game}=timeline,
    %Fixture{home: _team, away: :nil},
    {[], teamz},
    [%Match{fixture: %Fixture{home: away, away: home}, venue: :a, week: week}| matches]
  ) do
    display("No away team - back out to the previous away week!!!")
    #set up fixture depending on status and venue
    schedule(%Timeline{timeline|week: week, game: game + 1, venue: :x},
    %Fixture{home: home, away: away},
    {[],[]},
    matches
    )
  end
  def schedule(
    %Timeline{game: game}=timeline,
    %Fixture{home: _team, away: :nil},
    {[], teamz},
    [%Match{fixture: %Fixture{home: home, away: away}, venue: venue, week: week}| matches]
  ) do
    display("No away team - back out to the previous week!!!")
    #set up fixture depending on status and venue
    schedule(%Timeline{timeline|week: week, game: game + 1, venue: newvenue(venue)},
    %Fixture{home: home, away: away},
    {[],[]},
    matches
    )
  end

  def schedule(
    %Timeline{week: week, game: game}=timeline,
    %Fixture{home: home, away: :nil} = fixture,
    {[team | teams], teamz},
    matches
  )
   do
    display("New away team #{team.club.name}/#{team.name}")
    schedule(%Timeline{timeline|game: game + 1, venue: Fix.venue(home, team, :b)},
    %Fixture{fixture| away: team},
    {teams,teamz},
    matches
    )
  end
  def schedule(
    %Timeline{week: week, game: game, venue: :h}=timeline,
    fixture,
    {teams, teamz},
    matches
  ) do
    [teama, teamb|teamx] = join(teamz,teams)
    #IO.inspect("#{teama.club.name}/#{teama.name} and then #{teamb.club.name}/#{teamb.name} ")
    #display("#{fixture.home.club.name}/#{fixture.home.name} v #{fixture.away.club.name}/#{fixture.away.name} ")
    display("We have a home home fixture to add to #{size(matches)} matches")
    schedule(%Timeline{timeline|game: game + 1, venue: :nil},
    :nil,
    {join(teamz, teams),[]},
    [%Match{fixture: fixture, week: week, venue: :h, game: game, xteams: exclude(fixture.home, teamz)} | matches]
    )
  end

  def schedule(
    %Timeline{week: week, game: game, venue: :b}=timeline,
    fixture,
    {teams, teamz},
    matches
  ) do
    #[teama, teamb|teamx] = join(teamz,teams)
    #IO.inspect("#{teama.club.name}/#{teama.name} and then #{teamb.club.name}/#{teamb.name} ")
    display("#{fixture.home.year}/#{fixture.home.league}  #{fixture.home.club.name}/#{fixture.home.name} v #{fixture.away.club.name}/#{fixture.away.name} #{fixture.away.year}/#{fixture.away.league} ")
    display("We have a both home fixture to add to #{size(matches)} matches")
    schedule(%Timeline{timeline|game: game + 1, venue: :nil},
    :nil,
    {join(teamz, teams), []},
    [%Match{fixture: fixture, week: week, venue: :b, game: game, xteams: exclude(fixture.home, teamz)} | matches]
    )
  end
  def schedule(
    %Timeline{week: week, game: game, venue: :a}=timeline,
    fixture,
    {teams, teamz},
    matches
  ) do
    #[teama, teamb|teamx] = join(teamz,teams)
    #IO.inspect("#{teama.club.name}/#{teama.name} and then #{teamb.club.name}/#{teamb.name} ")
    display("#{fixture.home.year}/#{fixture.home.league}  #{fixture.home.club.name}/#{fixture.home.name} v #{fixture.away.club.name}/#{fixture.away.name} #{fixture.away.year}/#{fixture.away.league}")
    display("We have an away home fixture to add to #{size(matches)} matches")
    schedule(%Timeline{timeline|game: game + 1, venue: :nil},
    :nil,
    {join(teamz, teams),[]},
    [%Match{fixture: %Fixture{home: fixture.away, away: fixture.home}, week: week, venue: :a, game: game, xteams: exclude(fixture.home, teamz)} | matches]
    )
  end
  def schedule(
    %Timeline{week: week, game: game, venue: :x}=timeline,
    fixture,
    {teams, teamz},
    matches
  ) do
    display("#{fixture.home.year}/#{fixture.home.league}  #{fixture.home.club.name}/#{fixture.home.name} v #{fixture.away.club.name}/#{fixture.away.name} #{fixture.away.year}/#{fixture.away.league}")
    display("We have no fixture so get rid of away team")
    schedule(%Timeline{timeline|game: game + 1, venue: :m},
    %Fixture{fixture|away: :nil},
    {teams, [fixture.away|teamz]},
    matches
    )
  end

  #-------------------------------------------------------------------

  #-------------------------------------------------------------------


  def newvenue(:h) do
    :x
  end
  def newvenue(:a) do
    :x
  end
  def newvenue(:b) do
    :a
  end
  def scheduletrace(timeline, fixture, {teams,teamz},matches) do
      schedule(timeline, fixture, {teams,teamz},matches)
  end
  def exclude(team, xteams) do
    exclude(team, xteams, [])
  end
  def exclude(team, [], oteams) do
    oteams
  end
  def exclude(%Team{year: year, league: league}=team, [[%Team{year: year, league: league}=team | xteams], oteams]) do
    exclude(team, xteams, [team|oteams])
  end
  def exclude(team, [team|xteams], oteams) do
    exclude(team, xteams, oteams)
  end
  def display(insp) do
    IO.inspect(insp)
  end
  def show(teams) do
    show(teams, "")
  end
  def show([], show) do
    show
  end
  def show([%Team{} = team|teams], show) do
    show(teams, "#{show}  #{team.year} / #{team.league} : #{team.club.name} / #{team.name}")
  end
end
