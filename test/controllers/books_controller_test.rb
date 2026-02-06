require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:test_admin_user)
    @user = users(:test_user)
    @book = books(:test_book_one)

    @book.cover.attach(
      io:  File.open(File.join(Rails.root, "app/assets/images/dummy_cover.jpg")),
        filename: "dummy_cover.jpg"
    )

    @book.body.attach(
      io:  File.open(File.join(Rails.root, "app/assets/images/dummy_body.pdf")),
        filename: "dummy_body.pdf"
    )
  end

  test "admin can access index page" do
    sign_in @admin_user

    get books_path
    assert_response :success
  end

  test "book can access index page" do
    sign_in @user

    get books_path
    assert_response :success
  end

  test "admin can access show page" do
    sign_in @admin_user

    get book_path(@book)
    assert_response :success
  end

  test "book can access show page" do
    sign_in @user

    get book_path(@book)
    assert_response :success
  end

  test "admin can access new book page" do
    sign_in @admin_user

    get new_book_path
    assert_response :success
  end

  test "user can access new book page" do
    sign_in @user

    get new_book_path
    assert_response :success
  end
end
