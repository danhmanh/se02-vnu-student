class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :find_post, only: %i(show edit update destroy)

  def create
    @post = current_user.posts.build post_params

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @post }
      else
        @feed_items = []
        format.html { redirect_to root_path }
        format.json { render json: @post.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes post_params
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit :content, :picture
  end

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "Can not find this post."
    redirect_to root_path
  end
end
