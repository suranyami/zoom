defmodule Groom.Application do
  @moduledoc """
    Start repo, endpoint, Absinthe Subscription supervisors.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Groom.Repo, []),
      supervisor(GroomWeb.Endpoint, []),
      supervisor(Absinthe.Subscription, [GroomWeb.Endpoint])
    ]

    opts = [strategy: :one_for_one, name: Groom.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GroomWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
