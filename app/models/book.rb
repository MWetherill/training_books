class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :user
  has_many :genres
end
