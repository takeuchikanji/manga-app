class CommentsController < ApplicationController
  before_action :set_comic

  def index
    @comment = Comment.new
    @comments = @comic.comments.includes(:user).order(created_at: :desc)
  end

  def create
    if signed_in?
      @comment = Comment.create(comment_params)
      respond_to do |format|
        format.html { redirect_to item_path(params[:comic_id])  }
        format.json
      end
    end
  end

  def destroy
    @comment_id = Comment.find(params[:id])
    if signed_in? && @comment_id.user_id == current_user.id
      @comment = @comic.comments.find(params[:id])
      @comment.destroy
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
