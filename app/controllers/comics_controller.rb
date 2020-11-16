class ComicsController < ApplicationController

  def index
  end

  def show
    @comic = Comic.find(params[:id])
    @author = Author.find(@comic.author.id)
    @comic_genre = @comic.genres.pluck(:genre)
  end

  def searchscreen
    @q = Comic.ransack(params[:q])
    @genres = Genre.all
    @comics = @q.result(distinct: true)
    @comic = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find_by(id: 1)
    @comic_two = Comic.find_by(id: 7)
    @comic_three = Comic.find_by(id: 3)
    @comic_four = Comic.find_by(id: 4)
    @comic_five = Comic.find_by(id: 5)
  end

  def search
    @q = Comic.ransack(params[:q])
    @comics = @q.result(distinct: true)
    @comics_count = @q.result(distinct: true)
    @comic = Comic.order(created_at: :desc).limit(5)
    @comics = @comics.page(params[:page]).per(10)
    @comic_one = Comic.find_by(id: 1)
    @comic_two = Comic.find_by(id: 7)
    @comic_three = Comic.find_by(id: 3)
    @comic_four = Comic.find_by(id: 4)
    @comic_five = Comic.find_by(id: 5)
  end

  def recommend
    @authors = Author.all
    # @comics = Comic.all.page(params[:page]).per(10)   ##ページネーション
    @comic = Comic.order(created_at: :desc).limit(5)    ##サイドバーの登録最新から5件取得
    @comics_recommend = Comic.where(recommend_id: 1).page(params[:page]).per(10)    ##おすすめ作品を取得、ページネーションを10作品ごと
    @comic_one = Comic.find_by(id: 1)
    @comic_two = Comic.find_by(id: 7)
    @comic_three = Comic.find_by(id: 3)
    @comic_four = Comic.find_by(id: 4)
    @comic_five = Comic.find_by(id: 5)
  end

  private

  def comic_params
    params.require(:comic).permit(:name, :image, :number_of_books, :summary, :review, genre_ids: [])
  end
end
