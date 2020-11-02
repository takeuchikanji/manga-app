class CommentsController < ApplicationController
  before_action :set_comic

  def index
    # @comments = Comment.all
    @comment = Comment.new
    @comments = @comic.comments.includes(:user).order(created_at: :desc)
  end

  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to item_path(params[:comic_id])  }
      format.json
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, comic_id: params[:comic_id])
  end

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end
end
