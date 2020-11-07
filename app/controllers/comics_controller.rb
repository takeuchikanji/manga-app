class ComicsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Comic.ransack(params[:q])
    @genres = Genre.all
    @comics = @q.result(distinct: true)
    @comic = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find(1)
    @comic_two = Comic.find(7)
    @comic_three = Comic.find(3)
    @comic_four = Comic.find(4)
    @comic_five = Comic.find(5)
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      redirect_to root_path, notice: "投稿を完了しました"
    else
      render :new
    end
  end

  def show
    @comic = Comic.find(params[:id])
    @author = Author.find(@comic.author.id)
    @comic_genre = @comic.genres.pluck(:genre)
  end

  def search
    @q = Comic.ransack(params[:q])
    @comics = @q.result(distinct: true)
    @comics_count = @q.result(distinct: true)
    @comic = Comic.order(created_at: :desc).limit(5)
    @comics = @comics.page(params[:page]).per(10)
    @comic_one = Comic.find(1)
    @comic_two = Comic.find(7)
    @comic_three = Comic.find(3)
    @comic_four = Comic.find(4)
    @comic_five = Comic.find(5)
  end

  private

  def comic_params
    params.require(:comic).permit(:name, :image, :number_of_books, :summary, :review, genre_ids: [])
  end
end
