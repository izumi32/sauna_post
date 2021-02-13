class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @search_params = micropost_search_params
      @feed_items = current_user.feed.paginate(page: params[:page]).search(@search_params)
    end
  end

  private

  def micropost_search_params
    params.fetch(:search, {}).permit(:name, :address, :price_from, :price_to, :sauna, :evaluate)
  end
end
