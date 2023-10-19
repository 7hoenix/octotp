defmodule Birdle.Game.Words do
  use GenServer

  # Initialization

  {:ok, contents} = File.read("../words.txt")
  @list String.split(contents, "\n", trim: true)
  @set MapSet.new(@list)

  def random, do: Enum.random(@list)

  def member?(word), do: MapSet.member?(@set, word)

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: :birdle_words_server)
  end

  def get(pid \\ :birdle_words_server) do
    GenServer.call(pid, :get)
  end

  def new_word(pid \\ :birdle_words_server) do
    GenServer.cast(pid, :new_word)
  end

  # Server (callbacks)

  @impl true
  def init(_) do
    {:ok, Enum.shuffle(@list)}
  end

  @impl true
  def handle_call(:get, _from, [head | _tail] = state) do
    {:reply, head, state}
  end

  @impl true
  def handle_cast(:new_word, [_last]) do
    {:noreply, Enum.shuffle(@list)}
  end

  def handle_cast(:new_word, [_head | tail]) do
    {:noreply, tail}
  end
end
