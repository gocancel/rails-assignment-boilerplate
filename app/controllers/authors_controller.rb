class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.create(author_params)
      if @author.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.prepend(:authors, partial: 'authors/author', locals: { author: @author })
          end
          format.html { redirect_to @author, notice: 'Author created.' }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
  end
  
  def author_params
    params.require(:author).permit(:name)
  end
end
