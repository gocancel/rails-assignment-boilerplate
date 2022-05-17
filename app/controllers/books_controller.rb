class BooksController < ApplicationController
  has_scope :by_shelf, as: :shelf

  def index
    # TODO: Book.with_attached_avatar
    @books = apply_scopes(Book.includes(:cover_attachment)).all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def	create
    @book = Book.create!(book_params)
    # @book.save ? redirect_to(book_path(@book)) : render(:new)

    redirect_to @book
  end

  private

  def book_params
    params.require(:book).permit(:title, :cover, :shelf)
  end
end
