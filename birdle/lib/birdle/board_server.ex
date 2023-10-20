defmodule Birdle.BoardServer do
  use GenServer

  alias Birdle.Game.{Board, Validate, Words}

  # Client

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def add_guess(pid, guess) do
    GenServer.call(pid, {:add_guess, guess}) |> IO.puts()
  end

  # Server (callbacks)

  @impl true
  def init(name) do
    IO.puts("started: #{name}")
    Words.new_word()
    word = Words.get()
    initial = Board.new(word)

    {:ok, initial}
  end

  @impl true
  def handle_call({:add_guess, guess}, _from, state) do
    case Validate.validate(guess, state.guesses_reversed) do
      :ok ->
        new_state = Board.add_guess(state, guess)
        to_client = Board.show(new_state)
        {:reply, to_client, new_state}

      {:error, error_message} ->
        {:reply, error_message, state}
    end
  end

  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end
end
