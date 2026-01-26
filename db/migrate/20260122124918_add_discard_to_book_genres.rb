class AddDiscardToBookGenres < ActiveRecord::Migration[8.0]
  def change
    add_column :book_genres, :discarded_at, :datetime
  end
end
