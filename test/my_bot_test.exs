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
    MyBot.init_table
    MyBot.place({1, 2, "N"})
    assert MyBot.left(MyBot.get_index) == {:ok, {1, 2, "W"}}
    MyBot.place({1, 2, "E"})
    assert MyBot.left(MyBot.get_index) == {:ok, {1, 2, "N"}}
    MyBot.place({1, 2, "S"})
    assert MyBot.left(MyBot.get_index) == {:ok, {1, 2, "E"}}
    MyBot.place({1, 2, "W"})
    assert MyBot.left(MyBot.get_index) == {:ok, {1, 2, "S"}}
  end

  test "Can Turn Right From All Directions" do
    MyBot.init_table
    MyBot.place({1, 2, "N"})
    assert MyBot.right(MyBot.get_index) == {:ok, {1, 2, "E"}}
    MyBot.place({1, 2, "E"})
    assert MyBot.right(MyBot.get_index) == {:ok, {1, 2, "S"}}
    MyBot.place({1, 2, "S"})
    assert MyBot.right(MyBot.get_index) == {:ok, {1, 2, "W"}}
    MyBot.place({1, 2, "W"})
    assert MyBot.right(MyBot.get_index) == {:ok, {1, 2, "N"}}
  end

  test "Toy can move Forwards" do
    MyBot.init_table
    MyBot.place({1,2,"N"})
    assert MyBot.move(MyBot.get_index) == {:ok, {1,3,"N"}}
    MyBot.place({1,5,"N"})
    assert MyBot.move(MyBot.get_index) == {:error, "Error: Your Robot would fall off the edge"}
  end

  test "Toy can report last position" do
    MyBot.init_table
    MyBot.place({1, 2, "N"})
    assert MyBot.report(MyBot.get_index) == {1, 2, "N"}
  end

  test "Game Runs A Simulation 1" do
    MyBot.init_table
    MyBot.place({1, 2, "N"})
    MyBot.move(MyBot.get_index)
    assert MyBot.report(MyBot.get_index) == {1, 3, "N"}
  end

  test "Game Runs A Simulation 2" do
    MyBot.init_table
    MyBot.place({0, 0, "N"})
    MyBot.left(MyBot.get_index)
    assert MyBot.report(MyBot.get_index) == {0, 0, "W"}
  end

  test "Game Runs A Simulation 3" do
    MyBot.init_table
    MyBot.place({1, 2, "E"})
    MyBot.move(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    MyBot.left(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    assert MyBot.report(MyBot.get_index) == {3, 3, "N"}
  end

  test "Game Runs A Simulation 4" do
    MyBot.init_table
    MyBot.place({1, 2, "E"})
    MyBot.move(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    MyBot.left(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    MyBot.move(MyBot.get_index)
    assert MyBot.report(MyBot.get_index) == {3, 5, "N"}
  end

  test "Incorrect Coordinates are caught" do
    MyBot.init_table
    assert MyBot.place({"E", 1, "N"}) == {:error, "Invalid Placement"}
    assert MyBot.place({1, "N"}) == {:error, "Invalid Coordinates"}
    assert MyBot.place({"N"}) == {:error, "Invalid Coordinates"}
  end

  test "Incorrect Direction is caught" do
    MyBot.init_table
    assert MyBot.place({1, 2, "G"}) == {:error, "Invalid Placement"}
  end

  test "Input Guards Work Correctly" do
    MyBot.init_table
    assert MyBot.input("PLACE 1,2,N") == {:ok, {1, 2, "N"}}
    assert MyBot.input("PLACE 1, 2, N") == {:ok, {1, 2, "N"}}
    assert MyBot.input("PLace 1,2,N") == :ok
    assert MyBot.input("PLACE 1, 2") == :ok
    assert MyBot.input("PLACE 1,2,N,6, 8") == :ok
  end


end
