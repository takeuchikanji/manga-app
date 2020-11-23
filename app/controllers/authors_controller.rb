class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    @comic_info = Comic.order(created_at: :desc).limit(5)
    @comic_one = Comic.find_by(id: 1)
    @comic_two = Comic.find_by(id: 7)
    @comic_three = Comic.find_by(id: 3)
    # @comic_four = Comic.find_by(id: 4)
    # @comic_five = Comic.find_by(id: 5)
    @request_count = Request.all
  end

  def new
    if user_signed_in? && current_user.admin?
      @author = Author.new
      comic = @author.comics.build
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in? && current_user.admin?
      @author = Author.where(name: author_params[:name]).first_or_initialize
      if @author.new_record?
        @author.save
      end
      comic = Comic.new(comic_params)
      comic.save!
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
    if user_signed_in? && current_user.admin?
      @author = Author.find(params[:id])
      @comic = Comic.find_by(name: params[:format])
    else
      redirect_to root_path
    end
  end

  def update
    if user_signed_in? && current_user.admin?
      @author = Author.find(params[:id])        ##作者取得
      @comic = Comic.find_by(name: params[:format])     ##作者の作品のうち対応する作品を取得    この行、要らないかもなんかこの@comicじゃ取れてこれず(@comic=nil)で結局下で再度@comic定義してる。。。
      if @author.name == author_params[:name]     ##作者名変更しなかったらtrue
        @author.save
        @comic = Comic.find(params.require(:author).require(:comic).require(:id))
        @comic.update(update_author_comic_params)
      else                        ##作者名を変更したときの処理
        @author_db_find = Author.where(name: author_params[:name]).first_or_initialize    ##再度、変更した作者がDBないにあるかどうか探す(変更後の作者をこの変数に入れて、@author（変更前の作者）とは別にしている)
        if @author_db_find.new_record?                         ##もし、なければauthorの新しいレコードを作成
          @author_db_find.save            ##諸々変更を保存
          if @author.comics.length == 1      ##対象の作者の作品がラスト１だったら、作者を削除   こっちでも変更前の作者が作品０で作者だけ残らないようにする
            @author.comics.each do |comic|    ##削除するが、この記述(reloadまで)しておかないと、モデルに書いているdependent: :destroyによって作品ごと削除してしまう
              comic.author = nil
              @author_db_find.comics << comic
            end
            @author.reload
            @author.destroy
          end
          @comic = Comic.find(params.require(:author).require(:comic).require(:id))
          @comic.update(update_author_db_find_comic_params)
        else                            ##変更した作者名がすでにDBにあればこっち
          if @author.comics.length == 1      ##対象の作者の作品がラスト１だったら、作者を削除
            @author.comics.each do |comic|    ##削除するが、この記述(reloadまで)しておかないと、モデルに書いているdependent: :destroyによって作品ごと削除してしまう
              comic.author = nil
              @author_db_find.comics << comic
            end
            @author.reload
            @author.destroy
          end      
          @comic = Comic.find(params.require(:author).require(:comic).require(:id))   ##この2行を上のifでelseの時のみの挙動にしていたが、1つ削除するときも、コミック情報自体は更新する必要があるため、インデント左に上げてどっちでも保存するようにした
          @comic.update(update_author_db_find_comic_params)
        end
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    if user_signed_in? && current_user.admin?
      author = Author.find(params[:id])
      if author.comics.length == 1
        author.destroy
      else
        comic = Comic.find_by(name: params[:format])
        comic.destroy
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  private

  def author_params
    params.require(:author).permit(:name, comics_attributes: [:name, :name_kana, :image, :number_of_books, :summary, :review, :booknumber_id, :recommend_id, genre_ids: []])
  end

  def update_author_params
    params.require(:author).permit(:name, comics_attributes: [:name, :name_kana, :image, :number_of_books, :summary, :review, :booknumber_id, :recommend_id, {genre_ids: []}, :_destroy, :id])
  end

  def comic_params
    params.require(:author).require(:comics_attributes).require("0").permit(:name, :name_kana, :image, :number_of_books, :summary, :review, :booknumber_id, :recommend_id, genre_ids: []).merge(author_id: @author.id)
  end

  def update_author_comic_params     ##元の作者変更しなかった場合こっち（変更前の作者idをmarge）
    params.require(:author).require(:comic).permit(:name, :name_kana, :image, :number_of_books, :summary, :review, :booknumber_id, :recommend_id, genre_ids: []).merge(author_id: @author.id)
  end

  def update_author_db_find_comic_params     ##元の作者から変更した場合こっち（変更後の作者idをmarge）
    params.require(:author).require(:comic).permit(:name, :name_kana, :image, :number_of_books, :summary, :review, :booknumber_id, :recommend_id, genre_ids: []).merge(author_id: @author_db_find.id)
  end
end
