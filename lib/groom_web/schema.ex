defmodule GroomWeb.Schema do
  @moduledoc """
    GraphQL schema for GroomWeb.
  """
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(GroomWeb.Schema.AccountTypes)
  alias GroomWeb.Resolvers

  query do
    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Accounts.find_user/3)
    end
  end
end
