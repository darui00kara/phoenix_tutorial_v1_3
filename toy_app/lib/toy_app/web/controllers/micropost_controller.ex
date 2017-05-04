defmodule ToyApp.Web.MicropostController do
  use ToyApp.Web, :controller

  plug ToyApp.Plugs.SignedInUser

  alias ToyApp.Accounts

  def create(conn, %{"micropost_param" => %{"content" => content}}) do
    case Accounts.create_micropost(conn.assigns[:current_user], content) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Post successfully.")
        |> redirect(to: user_path(conn, :show, conn.assigns[:current_user]))
      {:error, _} ->
        conn
        |> put_flash(:error, "Post Failed.")
        |> redirect(to: user_path(conn, :show, conn.assigns[:current_user]))
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _micropost} = Accounts.get_micropost!(id) |> Accounts.delete_micropost

    conn
    |> put_flash(:info, "Micropost deleted successfully.")
    |> redirect(to: user_path(conn, :show, conn.assigns[:current_user]))
  end
end
