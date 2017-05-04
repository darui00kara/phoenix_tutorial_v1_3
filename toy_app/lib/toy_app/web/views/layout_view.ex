defmodule ToyApp.Web.LayoutView do
  use ToyApp.Web, :view

  def get_controller_name(conn), do: controller_module(conn)
  def get_action_name(conn), do: action_name(conn)
end
