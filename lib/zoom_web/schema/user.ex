defmodule ZoomWeb.Schema.User do
  @moduledoc """
    Represents a user account.
  """
  use Absinthe.Schema.Notation

  @desc "User account"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:age, :integer)
    field(:color, :string)
    field(:uuid, :string)
  end
end
