class BooksController < ApplicationController
  def index
    @books = Book.all.order(title: :asc)
  end
end
