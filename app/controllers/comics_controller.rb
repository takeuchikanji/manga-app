class ComicsController < ApplicationController

  def index
    @comics = Comic.order("name_kana")
    @comic_info = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find_by(id: 21)
    @comic_two = Comic.find_by(id: 22)
    @comic_three = Comic.find_by(id: 23)
    @request_count = Request.all
  end

  def show
    @comic = Comic.find(params[:id])
    @author = Author.find(@comic.author.id)
    @comic_genre = @comic.genres.pluck(:genre)
    @request_count = Request.all
  end

  def searchscreen    ##検索画面
    @q = Comic.ransack(params[:q])
    @genres = Genre.all
    @comics = @q.result(distinct: true)
    @comic_info = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find_by(id: 21)
    @comic_two = Comic.find_by(id: 22)
    @comic_three = Comic.find_by(id: 23)
    @request_count = Request.all
  end

  def search      ##検索結果の画面c
    @q = Comic.ransack(params[:q])
    @comics = @q.result(distinct: true)
    @comics_count = @q.result(distinct: true)
    @comic_info = Comic.order(created_at: :desc).limit(5)
    @comics = @comics.page(params[:page]).per(10)
    @comic_one = Comic.find_by(id: 21)
    @comic_two = Comic.find_by(id: 22)
    @comic_three = Comic.find_by(id: 23)
    @request_count = Request.all
  end

  def recommend
    @authors = Author.all
    @comic_info = Comic.order(created_at: :desc).limit(5)    ##サイドバーの登録最新から5件取得
    @comics_recommend = Comic.where(recommend_id: 1).page(params[:page]).per(10)    ##おすすめ作品を取得、ページネーションを10作品ごと
    @comic_one = Comic.find_by(id: 21)
    @comic_two = Comic.find_by(id: 22)
    @comic_three = Comic.find_by(id: 23)
    @request_count = Request.all
  end

  private

  def comic_params
    params.require(:comic).permit(:name, :image, :number_of_books, :summary, :review, genre_ids: [])
  end
end
