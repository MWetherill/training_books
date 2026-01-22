class Book < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(c, m) { c&.current_user },
    params: { changes: ->(c, m) { m.previous_changes } }

  belongs_to :user
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_one_attached :cover
  has_one_attached :body

  alias_attribute :pub_act_key, :title
end
