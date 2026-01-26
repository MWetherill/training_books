class Book < ApplicationRecord
  belongs_to :user
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  has_one_attached :cover
  has_one_attached :body

  alias_attribute :pub_act_key, :title
end
