class RequestsController < ApplicationController
  def index
    if user_signed_in? && current_user.admin?
      @requests = Request.all
    else
      redirect_to root_path
    end
  end

  def new
    if signed_in?
      @request = Request.new
    else
      redirect_to root_path
    end
  end

  def create
    if signed_in?
      @request = Request.new(request_params)
      if @request.save
        redirect_to root_path, notice: "要望を送信しました"
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if user_signed_in? && current_user.admin?
      @request = Request.find(params[:id])
      if @request.destroy
        redirect_to root_path, notice: "削除しました"
      end
    else
      redirect_to root_path
    end
  end

  def show
    if user_signed_in? && current_user.admin?
      @request = Request.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private
  def request_params
    params.require(:request).permit(:comicname, :authorname, :comment).merge(user_id: current_user.id)
  end
end
