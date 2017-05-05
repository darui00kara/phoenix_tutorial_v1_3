defmodule ToyApp.Web.RelationshipView do
  use ToyApp.Web, :view

  alias ToyApp.Following
  alias ToyApp.Accounts.User
  alias ToyApp.Helpers.ViewHelper

  def following?(conn, %User{id: showing_user_id}) do
    current_user = ViewHelper.current_user(conn)
    Following.following?(current_user.id, showing_user_id)
  end
end
