defmodule DemoApp.Web.MicropostControllerTest do
  use DemoApp.Web.ConnCase

  alias DemoApp.Accounts

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  def fixture(:micropost) do
    {:ok, micropost} = Accounts.create_micropost(@create_attrs)
    micropost
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, micropost_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Microposts"
  end

  test "renders form for new microposts", %{conn: conn} do
    conn = get conn, micropost_path(conn, :new)
    assert html_response(conn, 200) =~ "New Micropost"
  end

  test "creates micropost and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, micropost_path(conn, :create), micropost: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == micropost_path(conn, :show, id)

    conn = get conn, micropost_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Micropost"
  end

  test "does not create micropost and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, micropost_path(conn, :create), micropost: @invalid_attrs
    assert html_response(conn, 200) =~ "New Micropost"
  end

  test "renders form for editing chosen micropost", %{conn: conn} do
    micropost = fixture(:micropost)
    conn = get conn, micropost_path(conn, :edit, micropost)
    assert html_response(conn, 200) =~ "Edit Micropost"
  end

  test "updates chosen micropost and redirects when data is valid", %{conn: conn} do
    micropost = fixture(:micropost)
    conn = put conn, micropost_path(conn, :update, micropost), micropost: @update_attrs
    assert redirected_to(conn) == micropost_path(conn, :show, micropost)

    conn = get conn, micropost_path(conn, :show, micropost)
    assert html_response(conn, 200) =~ "some updated content"
  end

  test "does not update chosen micropost and renders errors when data is invalid", %{conn: conn} do
    micropost = fixture(:micropost)
    conn = put conn, micropost_path(conn, :update, micropost), micropost: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Micropost"
  end

  test "deletes chosen micropost", %{conn: conn} do
    micropost = fixture(:micropost)
    conn = delete conn, micropost_path(conn, :delete, micropost)
    assert redirected_to(conn) == micropost_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, micropost_path(conn, :show, micropost)
    end
  end
end
