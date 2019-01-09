class FollowingsController < ApplicationController
  attr_reader :user

  before_action :logged_in_user, :find_user, only: :index

  def index
    @title = "Following"
    @users = @user.following.page(params[:page])
      .per Settings.size_page_max_length
    render "users/show_follow"
  end

  private

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = "User not found!"
    redirect_to root_path
  end
end
