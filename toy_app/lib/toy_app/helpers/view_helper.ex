defmodule ToyApp.Helpers.ViewHelper do
  alias ToyApp.Accounts
  alias ToyApp.Accounts.User
  alias ToyApp.Helpers.Gravatar

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def current_user?(conn, %User{id: id}) do
    current_user(conn) == Accounts.get_user!(id)
  end

  def gravatar_for(%User{email: email}) do
    Gravatar.get_gravatar_url(email, 50)
  end
end
