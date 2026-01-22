class Genre < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(c, m) { c&.current_user },
    params: { changes: ->(c, m) { m.previous_changes } }

  has_many :book_genres
  has_many :books, through: :book_genres

  alias_attribute :pub_act_key, :name
end
