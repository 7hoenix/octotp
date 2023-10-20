defmodule Birdle.Game.Words do
  use GenServer

  # Initialization

  {:ok, contents} = File.read("../words.txt")
  @list String.split(contents, "\n", trim: true)
  @num_words length(@list)
  @set MapSet.new(@list)

  def random, do: Enum.random(@list)

  def member?(word), do: MapSet.member?(@set, word)

  # Client

  def start_link(seed) do
    GenServer.start_link(__MODULE__, seed, name: :birdle_words_server)
  end

  def get(pid \\ :birdle_words_server) do
    GenServer.call(pid, :get)
  end

  def new_word(pid \\ :birdle_words_server) do
    GenServer.cast(pid, :new_word)
  end

  # Server (callbacks)

  @impl true
  def init({y, m, d}) do
    IO.puts("started: words server")
    origin = Date.new!(y, m, d)
    today = Date.utc_today()
    count = Date.diff(today, origin)
    offset = rem(count, @num_words)
    step = (count / @num_words) |> floor
    new_seed = {y, m, d + step}
    :rand.seed(:exsss, new_seed)
    full_list = Enum.shuffle(@list)
    current_list = Enum.drop(full_list, offset)
    {:ok, current_list}
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
