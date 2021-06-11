defmodule TeacherWeb.MovieView do
  use TeacherWeb, :view

  def flag_enabled?(flag_name, user) do
    FunWithFlags.enabled?(flag_name, for: user)
  end

  def flag_enabled?(flag_name) do
    FunWithFlags.enabled?(flag_name)
  end

  def is_admin?(user) do
    FunWithFlags.enabled?(:movie_admin) &&
    FunWithFlags.Group.in?(user, :admin)
  end
end
