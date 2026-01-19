class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  def index
    # @pagy, @books = pagy(:offset, Book.all.order(title: :asc), limit: 10)
    @pagy, @books = pagy(:offset, Book.all.order(title: :asc))
  end

  def show
    @book = Book.find(params[:id])
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
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :short_description, :user_id, genre_ids: [])
  end
end
