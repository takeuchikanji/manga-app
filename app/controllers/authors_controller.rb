class AuthorsController < ApplicationController
  load_and_authorize_resource

  def index
    @authors = Author.all
    @comics = Comic.all.page(params[:page]).per(15)
    @comic = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find(1)
    @comic_two = Comic.find(2)
    @comic_three = Comic.find(3)
    @comic_four = Comic.find(4)
    @comic_five = Comic.find(5)
  end

  def new
    @author = Author.new
    comic = @author.comics.build
  end

  def create
    # cities = Author.find_or_initialize_by(name: params[:name]) 
    # if cities.new_record? # 新規データなら保存
    #   cities.save!
    # end
    @author = Author.create(author_params)
    redirect_to root_path
  end

  def edit
    @author = Author.find(params[:id])
    @comic = Comic.find_by(name: params[:format])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(update_author_params)
      redirect_to root_path
    end
  end

  # def show
  #   @author = Author.find(params[:id])
  #   @comic = Comic.find(params[:id])
  # end

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
    params.require(:author).permit(:name, comics_attributes: [:name, :image, :number_of_books, :summary, :review, :booknumber_id, genre_ids: []])
  end

  def update_author_params
    params.require(:author).permit(:name, comics_attributes: [:name, :image, :number_of_books, :summary, :review, :booknumber_id, {genre_ids: []}, :_destroy, :id])
  end
end
