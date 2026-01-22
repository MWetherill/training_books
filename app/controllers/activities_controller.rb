class ActivitiesController < ApplicationController
  def index
    @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
  end
end
