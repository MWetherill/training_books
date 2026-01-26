class GenresController < ApplicationController
  before_action :set_genre, only: %i[ show edit update destroy ]

  def index
    @pagy, @genres = pagy(:offset, Genre.kept.all.order(name: :asc))
    @genres_total = Genre.kept.all.count
  end

  def show
    @pagy, @books = pagy(:offset, @genre.books.order(title: :asc))

    activities = @genre.activities
    @activities = activities.order(created_at: :desc)
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: "Genre was successfully created." }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entry }
      end
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to @genre
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @genre.discard
    redirect_to genres_path, notice: "Genre destroyed"
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
