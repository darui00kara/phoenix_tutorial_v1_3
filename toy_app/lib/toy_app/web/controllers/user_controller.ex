defmodule ToyApp.Web.UserController do
  use ToyApp.Web, :controller

  plug ToyApp.Plugs.SignedInUser when action in [:show, :edit, :update, :index, :delete]
  plug :correct_user? when action in [:edit, :update, :delete]

  alias ToyApp.Accounts

  def index(conn, params) do
    users = Accounts.pagenate_list_users(params)

    if users do
      render(conn, "index.html", users: users)
    else
      conn
      |> put_flash(:error, "Invalid page number!!")
      |> render("index.html", users: [])
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%ToyApp.Accounts.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id} = params) do
    user  = Accounts.get_user_with_relationships(id)
    posts = extract_follow_ids(user.followed_users, :followed_id)
            |> Accounts.get_relationship_posts_with_paginate(user, params)

    if posts do
      render(conn, "show.html", user: user, posts: posts)
    else
      conn
      |> put_flash(:error, "Invalid page number!!")
      |> render("show.html", user: user, posts: [])
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> delete_session(:user_id)
    |> redirect(to: static_page_path(conn, :home))
  end

  
  def following(conn, %{"id" => id} = params) do
    user  = Accounts.get_user_with_relationships(id)
    users = extract_follow_ids(user.followed_users, :followed_id)
            |> Accounts.get_relationship_users(params)

    if users do
      render(conn, "following.html", user: user, users: users)
    else
      conn
      |> put_flash(:error, "Invalid page number!!")
      |> render("following.html", user: user, users: [])
    end
  end

  def followers(conn, %{"id" => id} = params) do
    user  = Accounts.get_user_with_relationships(id)
    users = extract_follow_ids(user.followers, :follower_id)
            |> Accounts.get_relationship_users(params)

    if users do
      render(conn, "followers.html", user: user, users: users)
    else
      conn
      |> put_flash(:error, "Invalid page number!!")
      |> render("followers.html", user: user, users: [])
    end
  end

  defp correct_user?(conn, _) do
    user = conn.params["id"] |> String.to_integer |> Accounts.get_user!

    if current_user?(conn, user) do
      conn
    else
      conn
      |> put_flash(:info, "Please signin.")
      |> redirect(to: session_path(conn, :new))
      |> halt
    end
  end

  defp current_user?(conn, user) do
    conn.assigns[:current_user] == user
  end

  defp extract_follow_ids(follow_users, key) do
    Enum.reduce(follow_users, [], fn(follow_user, acc) ->
      case Map.get(follow_user, key) do
        nil -> acc
         id -> [id | acc]
      end
    end) |> Enum.reverse
  end
end
