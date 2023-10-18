defmodule Dracula.Server do
  use GenServer

  alias Dracula.Counter.HexDigits, as: Count

  # Client

  def start_link({name, default}) when is_binary(default) do
    GenServer.start_link(__MODULE__, default, name: name)
  end

  def inc(pid \\ :counter1) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid \\ :counter1) do
    GenServer.cast(pid, :dec)
  end

  def show(pid \\ :counter1) do
    GenServer.call(pid, :show)
  end

  # Server (callbacks)

  @impl true
  def init(input) do
    initial = Count.new(input)

    {:ok, initial}
  end

  @impl true
  def handle_call(:show, _from, state) do
    to_caller = Count.show(state)

    {:reply, to_caller, state}
  end

  @impl true
  def handle_cast(:inc, state) do
    new_state = Count.inc(state)

    {:noreply, new_state}
  end

  @impl true
  def handle_cast(:dec, state) do
    new_state = Count.dec(state)

    {:noreply, new_state}
  end

  def child_spec({name, initial}) do
    %{id: name, start: {__MODULE__, :start_link, [{name, initial}]}}
  end
end
