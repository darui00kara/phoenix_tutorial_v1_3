defmodule ToyApp.Web.UserView do
  use ToyApp.Web, :view

  def is_empty_list?(list) when is_list(list) do
    Enum.empty? list
  end
end
