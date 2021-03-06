defmodule ToyApp.Helpers.Authentication do
  alias ToyApp.Helpers.Encryption

  def authentication(user, password) do
    case user do
      nil -> false
        _ ->
          Encryption.check_password(password, user.password_digest)
    end
  end
end
