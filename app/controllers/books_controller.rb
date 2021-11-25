class BooksController < ApplicationController
  has_scope :by_shelf, as: :shelf

  def index
    @books = apply_scopes(Book.includes(:cover_attachment)).all
  end

  def show
    @book = Book.find(params[:id])
  end
end
