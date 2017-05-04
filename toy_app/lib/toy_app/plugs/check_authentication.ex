defmodule ToyApp.Plugs.CheckAuthentication do
  import Plug.Conn

  alias ToyApp.Accounts

  def init(options) do
    options
  end

  def call(conn, _) do
    case user_id = get_session(conn, :user_id) do
      nil ->
        conn
      _ ->
        conn
        |> assign(:current_user, Accounts.get_user!(user_id))
    end
  end
end
