defmodule Dracula.Service do
  alias Dracula.Counter.HexDigits, as: Count

  def start_link(input) do
    initial = Count.new(input)

    spawn_link(fn -> loop(initial) end)
  end

  def inc(service_pid) do
    send service_pid, :inc
  end

  def dec(service_pid) do
    send service_pid, :dec
  end

  def show(service_pid) do
    send service_pid, {:show, self()}
    receive do
      msg -> msg
    end
  end

  def loop(count) do
    count
    |> listen
    |> loop
  end

  def listen(count) do
    receive do
      :inc ->
        Count.inc(count)

      :dec ->
        Count.dec(count)

      {:show, from_pid} ->
        send(from_pid, Count.show(count))
        count
    end
  end
end
