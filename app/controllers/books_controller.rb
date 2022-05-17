class BooksController < ApplicationController
  has_scope :by_shelf, as: :shelf

  def index
    # TODO: Book.with_attached_avatar
    @books = apply_scopes(Book.with_attached_cover).all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def	create
    # binding.remote_pry
    # binding.pry

    puts "PARAMS:"
    puts params

    if author_params[:name].present? && book_params[:author_id].present?
      @book = Book.new(book_params)
      @book.errors.add(:base, "Choose author or enter authors name to create a new one!")
      return render(:new)
    elsif author_params[:name].present?
      @autor = Author.create(name: author_params[:name])
      @book = @autor.books.new(book_params)
    else
      @book = Book.new(book_params)
    end
    @book.save ? redirect_to(book_path(@book)) : render(:new)
  end

  private

  def author_params
    params.require(:book).permit(:name)
  end

  def book_params
    params.require(:book).permit(:title, :cover, :shelf, :author_id)
  end
end
