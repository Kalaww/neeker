defmodule Neeker.Application do
  use Application

  def start(_type, _args) do
    Neeker.Supervisor.start_link()
  end

end
