defmodule Teacher.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Accounts.User
  alias Comeonin.Bcrypt

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :admin, :boolean
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password])
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)
  end
end

defimpl FunWithFlags.Actor, for: Teacher.Accounts.User do
  def id(%Teacher.Accounts.User{username: username}) do
    "user:#{username}"
  end
end

defimpl FunWithFlags.Group, for: Teacher.Accounts.User do
  def in?(%Teacher.Accounts.User{admin: admin}, :admin) do
    admin
  end
end
