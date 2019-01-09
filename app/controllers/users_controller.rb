class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :find_user

  def show
    @create_relationship = current_user.active_relationships.build
    @destroy_relationship = current_user.active_relationships.find_by followed_id: @user.id
    @posts = @user.posts.page(params[:page])
      .per Settings.size_page_max_length
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.html { redirect_to user_path }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :avatar
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = "User not found!"
    redirect_to root_path
  end
end
