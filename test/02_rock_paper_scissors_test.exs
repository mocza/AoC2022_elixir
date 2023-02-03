defmodule RockPaperScissorsTest do
  use ExUnit.Case
  doctest RockPaperScissors

  test "rules" do
    assert RockPaperScissors.play([:rock, :paper]) == :win
    assert RockPaperScissors.play([:paper, :rock]) == :lose
    assert RockPaperScissors.play([:rock, :scissors]) == :lose
    assert RockPaperScissors.play([:scissors, :rock]) == :win
    assert RockPaperScissors.play([:scissors, :paper]) == :lose
    assert RockPaperScissors.play([:paper, :scissors]) == :win
    assert RockPaperScissors.play([:paper, :paper]) == :draw
    assert RockPaperScissors.play([:rock, :rock]) == :draw
    assert RockPaperScissors.play([:scissors, :scissors]) == :draw
  end

  test "score" do
    assert RockPaperScissors.score([:rock, :rock]) == 1 + 3
    assert RockPaperScissors.score([:rock, :paper]) == 2 + 6
    assert RockPaperScissors.score([:rock, :scissors]) == 3 + 0
    assert RockPaperScissors.score([:paper, :paper]) == 2 + 3
    assert RockPaperScissors.score([:paper, :rock]) == 1 + 0
    assert RockPaperScissors.score([:paper, :scissors]) == 3 + 6
    assert RockPaperScissors.score([:scissors, :scissors]) == 3 + 3
    assert RockPaperScissors.score([:scissors, :rock]) == 1 + 6
    assert RockPaperScissors.score([:scissors, :paper]) == 2 + 0
  end

  test "decrypt" do
    assert RockPaperScissors.decrypt(["A", "X"]) == [:rock, :rock]
  end


end
