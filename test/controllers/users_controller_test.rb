require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:test_admin_user)
    @user = users(:test_user)
  end

  test "admin can access index page" do
    sign_in @admin_user

    get users_path
    assert_response :success
  end

  test "user can access index page" do
    sign_in @user

    get users_path
    assert_response :success
  end

  test "admin can access show page" do
    sign_in @admin_user

    get user_path(@user)
    assert_response :success
  end

  test "user can access show page" do
    sign_in @user

    get user_path(@user)
    assert_response :success
  end

  test "admin can access new user page" do
    sign_in @admin_user

    get new_user_path
    assert_response :success
  end

  test "user cannot access new user page" do
    sign_in @user

    get new_user_path
    assert_response :redirect
  end

  test "admin can create a new user" do
    sign_in @admin_user

    assert_difference -> { User.count }, 1 do
      post users_path, params: {
        user: {
          first_name: "John",
          last_name: "Doe",
          email_address: "john_doe@example.com",
          password: "password",
          dob: Date.today - 40.years
        }
      }
    end
  end

  test "user cannot create a new user" do
    sign_in @user

    assert_difference -> { User.count }, 0 do
      post users_path, params: {
        user: {
          first_name: "John",
          last_name: "Doe",
          email_address: "john_doe@example.com",
          password: "password",
          dob: Date.today - 40.years
        }
      }
    end
  end

  test "admin can access their own edit user page" do
    sign_in @admin_user

    get edit_user_path(@admin_user)
    assert_response :success
  end

  test "admin can access edit user page" do
    sign_in @admin_user

    get edit_user_path(@user)
    assert_response :success
  end

  test "user can access their own edit user page" do
    sign_in @user

    get edit_user_path(@user)
    assert_response :success
  end

  test "user cannot access edit user page for another user" do
    sign_in @user

    get edit_user_path(@admin_user)
    assert_response :redirect
  end

  test "admin can update their own user" do
    sign_in @admin_user

    start_name = @admin_user.first_name

    @admin_user.update(first_name: "David")

    end_name = @admin_user.first_name

    assert_not_equal start_name, end_name
  end

  test "admin can update a user" do
    sign_in @admin_user

    start_name = @user.first_name

    @user.update(first_name: "David")

    end_name = @user.first_name

    assert_not_equal start_name, end_name
  end

  test "user can update a their own user" do
    sign_in @user

    start_name = @user.first_name

    @user.update(first_name: "David")

    end_name = @user.first_name

    assert_not_equal start_name, end_name
  end

  test "user cannot update another user" do
    sign_in @user

    start_name = @admin_user.first_name

    @admin_user.update(first_name: "David")

    end_name = @admin_user.first_name

    assert_not_equal start_name, end_name
  end

  test "admin can destroy user" do
    sign_in @admin_user

    get users_path

    assert_dom "td", "user@example.com"

    delete user_url(@user)

    assert_not_dom "td", "user@example.com"
  end

  test "user cannot destroy user" do
    sign_in @user

    get users_path

    assert_dom "td", "user@example.com"

    delete user_url(@user)

    get users_path

    assert_dom "td", "user@example.com"
  end
end
