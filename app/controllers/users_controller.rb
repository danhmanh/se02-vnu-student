class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :find_user

  def show
    @posts = @user.posts.page(params[:page])
      .per Settings.size_page_max_length
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.html { redirect_to user_path }
        format.json { render :show, status: :ok, location: user_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
    flash[:danger] = "Cannot find this user"
    redirect_to root_path
  end
end
