class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_post, only: %i(new create edit update destroy)
  before_action :find_comment, only: %i(edit update destroy)

  def new
    @comment = @post.comments.build comment_params
  end

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end
  def edit
  end

  def update
    if @comment.update_attributes comment_params
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = "Comment deleted!"
    else
      flash[:success] = "Can not delete this comment."
    end
    redirect_to @post
  end
  
  private

  def comment_params
    params.require(:comment).permit :content
  end

  def find_post
    @post = Post.find_by id: params[:post_id]

    return if @post
    flash[:danger] = "Can not find this post."
    redirect_to root_path
  end

  def find_comment
    @comment = @post.comments.find_by id: params[:id]

    return if @comment
    flash[:danger] = "Can not find this comment."
    redirect_to @post
  end
end
