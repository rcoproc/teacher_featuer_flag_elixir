defmodule TeacherWeb.Helpers.Auth do

  def signed_in?(conn) do
    !!current_user(conn)
  end

  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: Teacher.Repo.get(Teacher.Accounts.User, user_id)
  end

end
