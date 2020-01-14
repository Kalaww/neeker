defmodule Neeker.MixProject do
  use Mix.Project

  def project do
    [
      app: :neeker,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Neeker.Application, []}
    ]
  end

  defp deps do
    [
      {:libcluster, "~> 3.2"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  defp releases do
    [
      neeker: [
        include_executables_for: [:unix]
      ]
    ]
  end
end
