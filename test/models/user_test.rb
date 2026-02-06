require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @admin_user = users(:test_admin_user)
    @user = users(:test_user)
  end
  test "full name helper gives correct name" do
    first_name = @user.first_name
    last_name = @user.last_name
    full_name = first_name + " " + last_name

    assert_equal full_name, @user.full_name
  end

  test "inverted full name helper gives correct name" do
    first_name = @user.first_name
    last_name = @user.last_name
    inverted_full_name = last_name + ", " + first_name

    assert_equal inverted_full_name, @user.inverted_full_name
  end

  test "check if user is an admin" do
    assert @admin_user.admin?
    assert_not @user.admin?
  end
end
