defmodule DemoApp.Web.MicropostController do
  use DemoApp.Web, :controller

  alias DemoApp.Accounts

  def index(conn, _params) do
    microposts = Accounts.list_microposts()
    render(conn, "index.html", microposts: microposts)
  end

  def new(conn, _params) do
    changeset = Accounts.change_micropost(%DemoApp.Accounts.Micropost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"micropost" => micropost_params}) do
    case Accounts.create_micropost(micropost_params) do
      {:ok, micropost} ->
        conn
        |> put_flash(:info, "Micropost created successfully.")
        |> redirect(to: micropost_path(conn, :show, micropost))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    micropost = Accounts.get_micropost!(id)
    render(conn, "show.html", micropost: micropost)
  end

  def edit(conn, %{"id" => id}) do
    micropost = Accounts.get_micropost!(id)
    changeset = Accounts.change_micropost(micropost)
    render(conn, "edit.html", micropost: micropost, changeset: changeset)
  end

  def update(conn, %{"id" => id, "micropost" => micropost_params}) do
    micropost = Accounts.get_micropost!(id)

    case Accounts.update_micropost(micropost, micropost_params) do
      {:ok, micropost} ->
        conn
        |> put_flash(:info, "Micropost updated successfully.")
        |> redirect(to: micropost_path(conn, :show, micropost))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", micropost: micropost, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    micropost = Accounts.get_micropost!(id)
    {:ok, _micropost} = Accounts.delete_micropost(micropost)

    conn
    |> put_flash(:info, "Micropost deleted successfully.")
    |> redirect(to: micropost_path(conn, :index))
  end
end
