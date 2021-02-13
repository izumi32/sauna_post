class MicropostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def index
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿を作成しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:name, :address, :price, :sauna, :evaluate)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
