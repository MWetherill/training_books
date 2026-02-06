require "test_helper"

class GenreTest < ActiveSupport::TestCase
  test "valid genre" do
    genre = Genre.new(name: "test")
    assert genre.valid?

    genre_no_name = Genre.new
    assert_not genre_no_name.save
  end
end
