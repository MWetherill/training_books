class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Discard::Model

  include PublicActivity::Model

  attr_accessor :skip_activity

  def skip_activity?
    @skip_activity.present?
  end

  create_activity_condition = ->(m, c) { !m.skip_activity? }

  tracked owner: ->(c, m) { c&.current_user },
    params: { changes: ->(c, m) { m.previous_changes } },
    on: {
      create: create_activity_condition,
      update: create_activity_condition,
      destroy: create_activity_condition
    }

  before_discard do
    @skip_activity = true
  end

  after_discard do
    @skip_activity = false
    create_activity("destroy")
  end
end
