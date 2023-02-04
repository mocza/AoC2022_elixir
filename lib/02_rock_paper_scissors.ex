defmodule RockPaperScissors do
  @signs %{
    rock: %{destroys: :scissors, score: 1, opponent: "A", mine: "X"},
    paper: %{destroys: :rock, score: 2, opponent: "B", mine: "Y"},
    scissors: %{destroys: :paper, score: 3, opponent: "C", mine: "Z"}}
  @scores %{win: 6, draw: 3, lose: 0}
  @decrypt %{
    opponent: %{"A" => :rock, "B" => :paper, "C" => :scissors},
    mine: %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
  }
  @decrypt2 %{
    opponent: %{"A" => :rock, "B" => :paper, "C" => :scissors},
    outcome: %{"X" => :lose, "Y" => :draw, "Z" => :win}
  }

  def play(pair) do
    [opponent, mine] = pair
    cond do
      opponent == mine -> :draw
      @signs[mine][:destroys] == opponent -> :win
      true -> :lose
    end
  end

  def score(pair) do
    [_opponent, mine] = pair
    @signs[mine][:score] + @scores[play(pair)]
  end

  def decrypt1(pair) do
    [opponent, mine] = pair
    [@decrypt[:opponent][opponent], @decrypt[:mine][mine]]
  end

  def read_encrypted(path) do
    String.split(File.read!(path), "\n")
  end

  def decrypt2(pair) do
    [encrypted_opponent, encrypted_outcome] = pair
    [@decrypt2[:opponent][encrypted_opponent], @decrypt2[:outcome][encrypted_outcome]]
  end

  def how_to_play_for_outcome(pair) do
    [opponent, outcome] = pair
    opponent_wins_against = @signs[opponent][:destroys]
    [opponent_loses_against | _] = Enum.filter(@signs, fn {k, _v} -> k != opponent_wins_against and k != opponent end) |> Enum.map(fn {k, _v} -> k end)
    case outcome do
      :lose -> [opponent, opponent_wins_against]
      :draw -> [opponent, opponent]
      :win -> [opponent, opponent_loses_against]
    end
  end

end
