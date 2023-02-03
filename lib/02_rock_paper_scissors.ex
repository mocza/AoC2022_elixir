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

  # def solution2_1() do
  #   read_encrypted("./test/rock_paper_scissors/input.txt")
  #   |> Enum.map(&(String.split(&1)))
  #   |> Enum.map(&(decrypt(&1)))
  #   |> Enum.map(&(score(&1)))
  #   |> Enum.reduce(0, &(&1 + &2))
  # end

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

  def decrypt(pair) do
    [opponent, mine] = pair
    [@decrypt[:opponent][opponent], @decrypt[:mine][mine]]
  end

  def read_encrypted(path) do
    String.split(File.read!(path), "\n")
  end

end
