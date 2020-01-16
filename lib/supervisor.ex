defmodule Neeker.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_opts) do
    [
      cluster_supervisor(),
      Plug.Cowboy.child_spec(scheme: :http, plug: Neeker.API, options: [port: 4000])
    ]
    |> Supervisor.init(strategy: :one_for_one)
  end

  defp cluster_supervisor() do
    topologies =
      [
        neekers: [
          strategy: Cluster.Strategy.Kubernetes.DNS,
          config: [
            service: "neeker",
            application_name: "neeker",
            polling_interval: 2_000
          ]
        ]
      ]

    {Cluster.Supervisor, [topologies, [name: Neeker.ClusterSupervisor]]}
  end

end
