class PagesController < ApplicationController
  allow_unauthenticated_access
  def show
    case params[:page]
    when "terms", "privacy"
        render template: "pages/#{params[:page]}"
    end
  end
end
