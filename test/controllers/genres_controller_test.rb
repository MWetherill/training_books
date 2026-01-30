require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    @user = users(:admin_user)
    sign_in @user

    get genres_path
    assert_response :success
  end
end
