defmodule MyBotTest do
  use ExUnit.Case
  doctest MyBot
  
  test "ets Table Creates and operates correctly" do
    assert MyBot.init_table == :player
  end

  test "Placement works anywhere on board" do
    MyBot.init_table
    assert MyBot.place({1,2,"N"}) == {:ok, {1,2,"N"}}
    assert MyBot.place({6,2,"N"}) == {:error, "Invalid Placement"}
  end

  test "Can Turn Left From All Directions" do
  end

  test "Can Turn Right From All Directions" do
  end

  test "Toy can move Forwards" do
  end

  test "Toy can report last position" do
  end

  test "Game Runs A Simulation 1" do
  end

  test "Game Runs A Simulation 2" do
  end

  test "Game Runs A Simulation 3" do
  end

  test "Game Runs A Simulation 4" do
  end

  test "Incorrect Coordinates are caught" do
  end

  test "Incorrect Direction is caught" do
  end


end
