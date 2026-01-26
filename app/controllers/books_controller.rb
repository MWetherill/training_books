class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  def index
    # @pagy, @books = pagy(:offset, Book.all.order(title: :asc), limit: 10)
    @pagy, @books = pagy(:offset, Book.kept.all.order(title: :asc))
    @books_total = Book.kept.all.count
  end

  def show
    @book = Book.find(params[:id])

    activities = @book.activities
    @activities = activities.order(created_at: :desc)
  end

  def new
    @book = Book.new
    @users = User.all.order(last_name: :asc)
    @genres = Genre.all.order(name: :asc)
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entry }
      end
    end
  end

  def edit
    @users = User.all.order(last_name: :asc)
    @genres = Genre.all.order(name: :asc)
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.discard
    redirect_to books_path, notice: "Book destroyed"
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :short_description, :user_id, :cover, :body, genre_ids: [])
  end
end
