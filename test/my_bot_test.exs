defmodule MyBotTest do
  use ExUnit.Case
  doctest MyBot

  test "greets the world" do
    assert MyBot.hello() == :world
  end
end
