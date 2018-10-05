defmodule MyBot do
  @doc """
  Setting up the global variables to reduce clutter and keep it scalable for future development
  """
  @max_x 5
  @max_y 5
  @min_x 0
  @min_y 0
  @valid_directions ["N", "E", "S", "W"]
  @store_name :player
  @move_error "Error: Invalid Move -- Not Found. Please check `info` for a list of moves"
  @coord_error "Invalid Coordinates"
  @placement_error "Invalid Placement"
  @danger_error "Error: Your Robot would fall off the edge"
  @play_error "Error You Must Place your Robot first"

  @doc """
  Initialize the Table
  """
  def init_table, do: :ets.new(@store_name, [:named_table, :ordered_set, :bag])
  @doc """
  Fetch the last known position from the game table to use for the targetted move
  """
  def last_position do
    [{index, location}] = :ets.match_object(@store_name, {get_index, :"$2"})
    location
  end
  @doc """
  Get the Current index of the table to use as a key
  """
  def get_index, do: :ets.info(@store_name, :size)
  @doc """
  The main move storing function, this places the move into the table
  """
  def store_position({x, y, f}), do: :ets.insert(@store_name, {get_index+1, {x, y, f}})
  @doc """
  This ensures that any direction used is correct, or else we return a movement error
  """
  defp validate_operation({x, y, f}) do
    with true <- Enum.any?(@valid_directions, fn dir -> dir == f end),
         true <- store_position({x, y, f}) do
           {:ok, {x, y, f}}
    else
      false -> {:error, @placement_error}
    end
  end
  @doc """
  Initial Placement Function for the STDIN input method, this sanitzes the input and ensures the coordinates are of a valid structure
  """
  def place(:validate, {x, y, f}) do
    with true <- Regex.match?(~r/[0-9]/, x),
         true <- Regex.match?(~r/[0-9]/, y),
         true <- Regex.match?(~r/[A-Z]/, f) do
              place({String.to_integer(x), String.to_integer(y), f})
    else
         false -> @placement_error
    end
  end
  @doc """
  Now we process the placement move correctly as it's now been sanitzed and validated
  """
  def place({x, y, f}) when x <= @max_x and y <= @max_y, do: validate_operation({x, y, f})
  def place({x, y, f}) when x > @max_x or y > @max_y, do: {:error, @placement_error}
  def place({y, f}), do: {:error, @coord_error}
  def place({f}), do: {:error, @coord_error}
  @doc """
  We call left/0 initially as we dont have oour current position, so lets retrieve it and call again with left/1
  """
  def left(size) when size !== 0 and is_integer(size), do: left(last_position)
  def left(0), do: IO.puts @play_error
  def left({x, y, "N"}), do: validate_operation({x, y, "W"})
  def left({x, y, "W"}), do: validate_operation({x, y, "S"})
  def left({x, y, "S"}), do: validate_operation({x, y, "E"})
  def left({x, y, "E"}), do: validate_operation({x, y, "N"})
  @doc """
  We call right/0 initially as we dont have oour current position, so lets retrieve it and call again with right/1
  """
  def right(size) when size !== 0 and is_integer(size), do: right(last_position)
  def right(0), do: IO.puts @play_error
  def right({x, y, "N"}), do: validate_operation({x, y, "E"})
  def right({x, y, "W"}), do: validate_operation({x, y, "N"})
  def right({x, y, "S"}), do: validate_operation({x, y, "W"})
  def right({x, y, "E"}), do: validate_operation({x, y, "S"})
  @doc """
  We call move/0 initially as we dont have oour current position, so lets retrieve it and call again with move/1
  """
  def move(size) when size !== 0 and is_integer(size), do: move(last_position)
  def move(0), do: IO.puts @play_error
  @doc """
  Correct Movement is validated in the guard clauses
  """
  def move({x, y, "N"}) when y+1 <= @max_y, do: validate_operation({x, y+1, "N"})
  def move({x, y, "E"}) when x+1 <= @max_x, do: validate_operation({x+1, y, "E"})
  def move({x, y, "S"}) when y-1 >= @min_y, do: validate_operation({x, y-1, "S"})
  def move({x, y, "W"}) when x-1 >= @min_x, do: validate_operation({x-1, y, "W"})
  @doc """
  Guard clauses catching the out-of-bounds clauses and returning subsequent errors
  """
  def move({x, y, "N"}) when y+1 > @max_y, do: {:error, @danger_error}
  def move({x, y, "E"}) when x+1 > @max_x, do: {:error, @danger_error}
  def move({x, y, "S"}) when y-1 < @min_y, do: {:error, @danger_error}
  def move({x, y, "W"}) when x-1 < @min_x, do: {:error, @danger_error}
  @doc """
  This will return the last known coordinates/position of the robot
  """
  def report(size) when size !== 0 and is_integer(size), do: last_position
  def report(0), do: IO.puts @play_error

  

end
