class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to @author, notice: 'Author created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def author_params
    params.require(:author).permit(:name)
  end
end
