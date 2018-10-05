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
    [{index, location}] = :ets.match(@store_name, get_index)
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

end
