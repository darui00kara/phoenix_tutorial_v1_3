defmodule ToyApp.Web.UserView do
  use ToyApp.Web, :view

  alias ToyApp.Accounts.User
  alias ToyApp.Helpers.Gravatar

  def gravatar_for(%User{email: email}) do
    Gravatar.get_gravatar_url(email, 50)
  end
end
