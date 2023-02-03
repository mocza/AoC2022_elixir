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

  test "decrypt#1: player1 A=rock, B=paper, C=scissors and player2 X=rock, Y=paper, Z=scissors" do
    assert RockPaperScissors.decrypt1(["A", "X"]) == [:rock, :rock]
  end

  test "decrypt#2: player1 A=rock, B=paper, C=scissors and player2 X=lose, Y=draw, Z=win" do
    assert RockPaperScissors.decrypt2(["A", "X"]) == [:rock, :lose]
    assert RockPaperScissors.decrypt2(["A", "Y"]) == [:rock, :draw]
    assert RockPaperScissors.decrypt2(["A", "Z"]) == [:rock, :win]
    assert RockPaperScissors.decrypt2(["B", "X"]) == [:paper, :lose]
    assert RockPaperScissors.decrypt2(["B", "Y"]) == [:paper, :draw]
    assert RockPaperScissors.decrypt2(["B", "Z"]) == [:paper, :win]
    assert RockPaperScissors.decrypt2(["C", "X"]) == [:scissors, :lose]
    assert RockPaperScissors.decrypt2(["C", "Y"]) == [:scissors, :draw]
    assert RockPaperScissors.decrypt2(["C", "Z"]) == [:scissors, :win]
  end

  test "play for outcome" do
    assert RockPaperScissors.how_to_play_for_outcome([:rock, :lose]) == [:rock, :scissors]
    assert RockPaperScissors.how_to_play_for_outcome([:rock, :draw]) == [:rock, :rock]
    assert RockPaperScissors.how_to_play_for_outcome([:rock, :win]) == [:rock, :paper]
    assert RockPaperScissors.how_to_play_for_outcome([:paper, :lose]) == [:paper, :rock]
    assert RockPaperScissors.how_to_play_for_outcome([:paper, :draw]) == [:paper, :paper]
    assert RockPaperScissors.how_to_play_for_outcome([:paper, :win]) == [:paper, :scissors]
    assert RockPaperScissors.how_to_play_for_outcome([:scissors, :lose]) == [:scissors, :paper]
    assert RockPaperScissors.how_to_play_for_outcome([:scissors, :draw]) == [:scissors, :scissors]
    assert RockPaperScissors.how_to_play_for_outcome([:scissors, :win]) == [:scissors, :rock]
  end

  test "score2" do
    assert RockPaperScissors.score2([:rock, :draw]) == 1 + 3
    assert RockPaperScissors.score2([:rock, :win]) == 2 + 6
    assert RockPaperScissors.score2([:rock, :lose]) == 3 + 0
    assert RockPaperScissors.score2([:paper, :draw]) == 2 + 3
    assert RockPaperScissors.score2([:paper, :lose]) == 1 + 0
    assert RockPaperScissors.score2([:paper, :win]) == 3 + 6
    assert RockPaperScissors.score2([:scissors, :draw]) == 3 + 3
    assert RockPaperScissors.score2([:scissors, :win]) == 1 + 6
    assert RockPaperScissors.score2([:scissors, :lose]) == 2 + 0
  end

end
