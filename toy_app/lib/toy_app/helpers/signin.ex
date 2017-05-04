defmodule ToyApp.Helpers.Signin do
  import ToyApp.Helpers.Authentication

  def check(user, password) do
    case authentication(user, password) do
      true -> {:ok, user}
         _ -> :error
    end
  end
end
