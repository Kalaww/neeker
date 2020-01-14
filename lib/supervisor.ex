defmodule Neeker.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_opts) do
    [
      Plug.Cowboy.child_spec(scheme: :http, plug: Neeker.API, options: [port: 4000])
    ]
    |> Supervisor.init(strategy: :one_for_one)
  end

end
