require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:test_admin_user)
    @user = users(:test_user)
    @genre = genres(:test_genre)
  end

  test "admin can access index page" do
    sign_in @admin_user

    get genres_path
    assert_response :success
  end

  test "user can access index page" do
    sign_in @user

    get genres_path
    assert_response :success
  end

  test "admin can access show page" do
    sign_in @admin_user

    get genre_path(@genre)
    assert_response :success
  end

  test "user can access show page" do
    sign_in @user

    get genre_path(@genre)
    assert_response :success
  end

  test "admin can access new genre page" do
    sign_in @admin_user

    get new_genre_path
    assert_response :success
  end

  test "user cannot access new genre page" do
    sign_in @user

    get new_genre_path
    assert_response :redirect
  end

  test "admin can create a new genre" do
    sign_in @admin_user

    assert_difference -> { Genre.count }, 1 do
      post genres_path, params: {
        genre: {
          name: "Default"
        }
      }
    end
  end

  test "user cannot create a new genre" do
    sign_in @user

    assert_difference -> { Genre.count }, 0 do
      post genres_path, params: {
        genre: {
          name: "Default"
        }
      }
    end
  end

  test "admin can access edit genre page" do
    sign_in @admin_user

    get edit_genre_path(@genre)
    assert_response :success
  end

  test "user cannot access edit genre page" do
    sign_in @user

    get edit_genre_path(@genre)
    assert_response :redirect
  end

  test "admin can update a genre" do
    sign_in @admin_user

    start_name = @genre.name

    @genre.update(name: "UpdatedTestGenre")

    end_name = @genre.name

    assert_not_equal start_name, end_name
  end

  test "user cannot update a genre" do
    sign_in @user

    start_name = @genre.name

    @genre.update(name: "UpdatedTestGenre")

    end_name = @genre.name

    assert_not_equal start_name, end_name
  end

  test "admin can destroy genre" do
    sign_in @admin_user

    get genres_path

    assert_dom "td", "TestGenre"

    delete genre_url(@genre)

    assert_not_dom "td", "TestGenre"
  end

  test "user cannot destroy genre" do
    sign_in @user

    get genres_path

    assert_dom "td", "TestGenre"

    delete genre_url(@genre)

    get genres_path

    assert_dom "td", "TestGenre"
  end
end
