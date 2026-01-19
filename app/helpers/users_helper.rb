module UsersHelper
  def name(user)
    user.last_name + ", " + user.first_name
  end

  def users_for_select(users)
    users.map { |u| [ "#{u.last_name}, #{u.first_name}".strip, u.id ] }
  end
end
