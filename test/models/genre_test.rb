require "test_helper"

class GenreTest < ActiveSupport::TestCase
  test "valid genre" do
    genre = Genre.new(name: "test")
    assert genre.valid?
  end
end
