defmodule RezeTest do
  use ExUnit.Case
  doctest Reze

  test "greets the world" do
    assert Reze.hello() == :world
  end
end
