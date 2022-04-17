class BooksController < ApplicationController
  has_scope :by_shelf, as: :shelf

  def index
    @books = apply_scopes(Book.includes(:cover_attachment)).all
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @book = Book.new
    @authors = Author.all
  end
  
  def create
    @book = Book.new(book_params)

    if @book.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:books, partial: "books/book", locals: { book: @book })
        end
        format.html { redirect_to @book, notice: 'Book created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :shelf, :cover, :author_id)
  end
end
