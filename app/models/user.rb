class User < ApplicationRecord
  has_secure_password

  has_many :books
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def full_name
    first_name + " " + last_name
  end

  alias_method :pub_act_key, :full_name

  def inverted_full_name
    last_name + ", " + first_name
  end
end
