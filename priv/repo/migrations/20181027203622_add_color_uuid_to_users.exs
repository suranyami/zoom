defmodule Zoom.Repo.Migrations.AddColorUUIDToUsers do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table(:users) do
      add :color, :string
      add :uuid, :string
    end
  end
end
