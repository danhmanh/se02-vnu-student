class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.page(params[:page])
        .per Settings.size_page_max_length
    end
  end
end
