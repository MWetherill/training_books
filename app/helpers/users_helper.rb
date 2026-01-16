module UsersHelper
  def name(user)
    user.last_name + ", " + user.first_name
  end
end
