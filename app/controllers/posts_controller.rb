class PostsController < ApplicationController
  before_action :logged_in_user, except: %i(index)
  before_action :find_post, only: %i(show edit update destroy)

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page])
      .per Settings.size_page_max_length
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted!"
    else
      flash[:success] = "Can not delete this post."
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit :content
  end

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "Can not find this post."
    redirect_to root_path
  end
end
