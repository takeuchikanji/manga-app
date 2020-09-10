class ComicsController < ApplicationController
  def index
    @comics = Comic.all
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


  private

  def comic_params
    params.require(:comic).permit(:name, :image, :number_of_books, :summary, :review, genre_ids: [])
  end
end
