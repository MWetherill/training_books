class AddDiscardToGenres < ActiveRecord::Migration[8.0]
  def change
    add_column :genres, :discarded_at, :datetime
  end
end
