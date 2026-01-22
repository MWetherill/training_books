class User < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(c, m) { c&.current_user },
    params: { changes: ->(c, m) { m.previous_changes } }

  has_many :books

  def full_name
    first_name + " " + last_name
  end

  alias_method :pub_act_key, :full_name

  def inverted_full_name
    last_name + ", " + first_name
  end
end
