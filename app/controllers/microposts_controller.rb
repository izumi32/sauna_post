class MicropostsController < ApplicationController
  before_action :logged_in_user

  def index
    redirect_to newpost_path
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
    @micropost = current_user.micropost.find_by(id: params[:id])
    @micropost.destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:name, :address, :price, :sauna, :evaluate)
  end
end
