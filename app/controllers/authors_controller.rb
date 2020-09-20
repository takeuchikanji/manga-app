class AuthorsController < ApplicationController
  load_and_authorize_resource

  def index
    @authors = Author.all
    @comics = Comic.all.page(params[:page]).per(5)
    @comic = Comic.order(created_at: :desc).limit(5)
  end

  def new
    @author = Author.new
    comic = @author.comics.build
  end

  def create
    @author = Author.create(author_params)
    redirect_to root_path
  end

  def edit
    @author = Author.find(params[:id])
    @comic = Comic.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(update_author_params)
      redirect_to root_path
    end
  end

  def show
    @author = Author.find(params[:id])
    @comic = Comic.find(params[:id])
  end

  def destroy
    author = Author.find(params[:id])
    author.destroy
    redirect_to root_path
  end

  # def search
  #   @q = Author.ransack(params[:q])
  #   @authors = @q.result(distinct: true)
  # end

  private

  def author_params
    params.require(:author).permit(:name, comics_attributes: [:name, :image, :number_of_books, :summary, :review, genre_ids: []])
  end

  def update_author_params
    params.require(:author).permit(:name, comics_attributes: [:name, :image, :number_of_books, :summary, :review, {genre_ids: []}, :_destroy, :id])
  end
end
