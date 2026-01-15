class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(name: :asc)
  end
end
