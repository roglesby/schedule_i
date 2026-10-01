defmodule ScheduleI do
  @moduledoc """
  Documentation for `ScheduleI`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ScheduleI.hello()
      :world

  """

  #    Mix.ensure_application!(:wx)
  #    Mix.ensure_application!(:debugger)
  #    :debugger.start()
  #    :int.ni(ScheduleI) ; :int.break(ScheduleI, 22)
  #    :int.ni(Fix) ; :int.break(Fix,4)
  #    ScheduleI.season

  def hello do
    :world
  end
  def assoc do
    %Structure.Association{}
  end
  def season do
    sttime = NaiveDateTime.local_now()
    IO.puts("#{IO.ANSI.red()}")
    Structure.Association.print(assoc())
    IO.puts("#{IO.ANSI.magenta()}")

    :persistent_term.put(:clubs, Map.values(Data.clubs))
    clubs = :persistent_term.get(:clubs)
    Structure.Club.prints(clubs)

    :persistent_term.put(:teams, Data.teams)
    teams = :persistent_term.get(:teams)
    Structure.Team.prints(teams)

    #Structure.Clubconstraint.prints(Data.clubconstraints)
    #Structure.Teamconstraint.prints(Data.teamconstraints)
    #Structure.Areaconstraint.prints(Data.areaconstraints)

    #Structure.Fixture.prints(Data.testfixtures)
    #-------------------------------------------------------------------
    {timeline, matches} = Schedule.schedule
    Structure.Timeline.print(timeline)
    Structure.Match.prints(matches)
    #-------------------------------------------------------------------
    IO.puts("#{IO.ANSI.reset()}")
    sotime = NaiveDateTime.local_now()
    elapsed = NaiveDateTime.diff(sotime, sttime)
    IO.puts(
      "Time: " <>
        Calendar.strftime(sttime, "%d/%m/%Y %H:%M:%S") <>
    " to " <>
    Calendar.strftime(sotime, "%H:%M:%S") <>
    " elapsed #{div(elapsed, 60)} minutes #{rem(elapsed, 60)} seconds."
       )
  end
end
