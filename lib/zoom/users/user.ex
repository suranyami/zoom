defmodule Zoom.User do
  @moduledoc """
    User database schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:age, :integer)
    field(:name, :string)
    field(:color, :string)
    field(:uuid, :string)

    timestamps()
  end

  @attrs [
    :age,
    :name,
    :color,
    :uuid
  ]
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @attrs)
  end
end
