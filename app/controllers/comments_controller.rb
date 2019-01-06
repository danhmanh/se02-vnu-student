class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_post, only: %i(new create edit update destroy)
  before_action :find_comment, only: %i(edit update destroy)

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
      else
        format.html { render @post }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes comment_params
        format.html { redirect_to @post }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
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
