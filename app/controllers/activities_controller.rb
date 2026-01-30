class ActivitiesController < ApplicationController
  def index
    @pagy, @activities = pagy(PublicActivity::Activity.where(trackable_type: [ "Book", "User", "Genre" ]).order(created_at: :desc))
  end

  def current_ability
    @current_ability ||= Ability.new(Current.user)
  end
end
