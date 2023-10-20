defmodule Birdle.BoardServer do
  use GenServer

  alias Birdle.Game.{Board, Validate}

  # TODO: Complete Validation

  # Client

  def start_link(name) do
    GenServer.start_link(__MODULE__, :unused, name: name)
  end

  def add_guess(pid, guess) do
    case result = Validate.validate(guess, []) do
      :ok ->
        GenServer.call(pid, {:add_guess, guess}) |> IO.puts()

      _ ->
        elem(result, 1)
    end
  end

  # Server (callbacks)

  @impl true
  def init(_) do
    initial = Board.new()

    {:ok, initial}
  end

  @impl true
  def handle_call({:add_guess, guess}, _from, state) do
    new_state = Board.add_guess(state, guess)

    {:reply, Board.show(new_state), new_state}
  end
end
