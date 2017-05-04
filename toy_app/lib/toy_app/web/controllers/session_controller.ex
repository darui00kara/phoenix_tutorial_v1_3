defmodule ToyApp.Web.SessionController do
  use ToyApp.Web, :controller

  alias ToyApp.Accounts

  def new(conn, _params) do
    render conn, "signin_form.html"
  end

  def create(conn, %{"signin_params" => %{"email" => email, "password" => password}}) do
    case Accounts.user_signin(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User signin is success!")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :show, user))
      :error ->
        conn
        |> put_flash(:error, "User signin is failed! email or password is incorrect.")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Signout now! See you again!!")
    |> delete_session(:user_id)
    |> redirect(to: static_page_path(conn, :home))
  end
end
