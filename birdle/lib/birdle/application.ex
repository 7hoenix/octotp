defmodule Birdle.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @birdle_word_server_origin {2023, 10, 12}

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Birdle.Worker.start_link(arg)
      {Birdle.Game.Words, @birdle_word_server_origin},
      {DynamicSupervisor, name: :dsup, strategy: :one_for_one},
      %{id: :test, start: {Birdle.BoardServer, :start_link, [:robin]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Birdle.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
