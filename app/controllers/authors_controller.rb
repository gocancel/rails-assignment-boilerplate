# frozen_string_literal: true

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
      respond_to do |format|
        format.turbo_stream do
          @authors = Author.all
        end
        format.html { redirect_to @author, notice: 'Author created.' }
      end
    else
      render :new
    end
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
